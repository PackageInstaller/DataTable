__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_FeatureUnlock = readonly({
  FeatureUnlock_100551_LockTip = {
    Text = "После завершения \"расследовательской операции\" 3-10·обычный будет разблокировано"
  },
  FeatureUnlock_100552_LockTip = {
    Text = "Завершите \"Расследовательская операция\" 2-15·Обычный, чтобы разблокировать"
  },
  FeatureUnlock_116229_LockTip = {
    Text = "<Posse:Завершите миссию \"До скорой встречи, Никогда-никогда\"·обычный, чтобы разблокировать>"
  },
  FeatureUnlock_116599_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_116600_FeatureName = {
    Text = "Акция с Поллуксом"
  },
  FeatureUnlock_119961_FeatureName = {
    Text = "Магазин обмена"
  },
  FeatureUnlock_119961_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_120493_FeatureName = {
    Text = "«Операция»Глава 4 о звёздах"
  },
  FeatureUnlock_120493_LockTip = {
    Text = "Завершите «Операцию» главы 3 · Обычный для разблокировки"
  },
  FeatureUnlock_120493_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследовательская операция「Звёзды сошлись·Лай」 была открыта>\n\n<FeatureUnlockDesc:Следуя за новостями о Уильяме после нескольких месяцев блуждания по морю, вы попали в загадочный шторм......>"
  },
  FeatureUnlock_120494_FeatureName = {
    Text = "«Расследование»Звёздное Царство 4 ·Трудный"
  },
  FeatureUnlock_120494_LockTip = {
    Text = "Завершите «Операцию» главы 3 · Сложно и главы 4 · Обычный для разблокировки"
  },
  FeatureUnlock_120494_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследовательская операция「Лай」·Доступен Уровень сложности>"
  },
  FeatureUnlock_120989_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_120990_LockTip = {
    Text = "<Posse:Завершите 「Операция」 Звёздный путь Глава 4·Обычный, чтобы открыть доступ>"
  },
  FeatureUnlock_120991_LockTip = {
    Text = "<Posse:Завершите「Хорал звезд」·Обычный для разблокировки>"
  },
  FeatureUnlock_122563_FeatureName = {
    Text = "Акция Моша"
  },
  FeatureUnlock_122564_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_123278_LockTip = {
    Text = "Завершите «Крещение серебром и кровью»·обычный, чтобы разблокировать"
  },
  FeatureUnlock_123279_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_125344_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_125345_FeatureName = {
    Text = "Сюй акция"
  },
  FeatureUnlock_126274_FeatureName = {
    Text = "Арахна событие"
  },
  FeatureUnlock_126363_FeatureName = {
    Text = "«Исследование»Звёздное Царство Глава 5"
  },
  FeatureUnlock_126363_LockTip = {
    Text = "Завершите «Исследование» Звёздное Царство, Глава 4·обычный, чтобы разблокировать"
  },
  FeatureUnlock_126363_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование «Звёзды сошлись · Театр ткача судеб» открыта>\n\n<FeatureUnlockDesc:Перейдя через врата черного солнца, ты вернулся в тот знакомый город, и всё это - просто настраиваемая сцена...>"
  },
  FeatureUnlock_126364_FeatureName = {
    Text = "«Исследование»Звёздное Царство 5 · Сложный"
  },
  FeatureUnlock_126364_LockTip = {
    Text = "Завершите главу 4 «Космическое расследование» на уровне сложности «Трудный» и главу 5 на уровне сложности «Обычный» для разблокировки"
  },
  FeatureUnlock_126364_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование «Театр ткача судеб» · Сложный открыта>"
  },
  FeatureUnlock_128099_FeatureName = {
    Text = "Коридор воспоминаний"
  },
  FeatureUnlock_128099_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_129487_FeatureName = {
    Text = "Мчащийся экспресс наслаждений"
  },
  FeatureUnlock_129507_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_129645_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_130172_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_130173_FeatureName = {
    Text = "Акция Сая"
  },
  FeatureUnlock_130899_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_130900_FeatureName = {
    Text = "Моск мероприятие"
  },
  FeatureUnlock_133714_FeatureName = {
    Text = "Тайный класс"
  },
  FeatureUnlock_133714_LockTip = {
    Text = "Завершите \"Исследование\"1-11·обычный, чтобы разблокировать"
  },
  FeatureUnlock_133714_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Тайный класс открыт>\n\n<FeatureUnlockDesc:Чтобы следователи всегда оставались в боевой готовности, Мисаг установила программу ежедневных базовых тренировок.>"
  },
  FeatureUnlock_134019_FeatureName = {
    Text = "Еженедельные тренировки"
  },
  FeatureUnlock_134019_LockTip = {
    Text = "Завершите \"Исследование\"1-11·обычный, чтобы разблокировать"
  },
  FeatureUnlock_134020_FeatureName = {
    Text = "Ежедневные тренировки"
  },
  FeatureUnlock_134020_LockTip = {
    Text = "Завершите \"Исследование\"1-11·обычный, чтобы разблокировать"
  },
  FeatureUnlock_140304_LockTip = {
    Text = "Разблокируется после завершения «Забытое семя любви» · Обычный"
  },
  FeatureUnlock_140305_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_140473_FeatureName = {
    Text = "Запретное испытание"
  },
  FeatureUnlock_140473_LockTip = {
    Text = "Завершите \"Исследование\"1-11·обычный, чтобы разблокировать"
  },
  FeatureUnlock_141300_FeatureName = {
    Text = "Активность Понтос"
  },
  FeatureUnlock_141301_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_141798_FeatureName = {
    Text = "Активность Карабу"
  },
  FeatureUnlock_143318_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_143319_LockTip = {
    Text = "Разблокируется после прохождения «Вечный Эпоянс»·Обычный"
  },
  FeatureUnlock_145361_FeatureName = {
    Text = "Событие Лотан: Китовластица"
  },
  FeatureUnlock_145362_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_146356_FeatureName = {
    Text = "«Исследование» Звёздное Царство, Глава 6"
  },
  FeatureUnlock_146356_LockTip = {
    Text = "Разблокируется после завершения «Исследование» Звёздное Царство, Глава 5·Обычный"
  },
  FeatureUnlock_146356_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование «Час истинного положения звёзд·Чествие горы богов» открыто>\n\n<FeatureUnlockDesc:В тряском автомобиле Хранитель добрался до Континента Северного конца на высоте четырёх тысяч метров. На вершине заснеженных гор, окутанных туманом, таинственный ритуал ожидает прихода восходителей……>"
  },
  FeatureUnlock_146357_FeatureName = {
    Text = "«Исследование» Звёздное Царство, Глава 6·Сложный"
  },
  FeatureUnlock_146357_LockTip = {
    Text = "Разблокируется после завершения «Исследование» Звёздное Царство, Глава 5·Сложный и Главы 6·Обычный"
  },
  FeatureUnlock_146357_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование «Чествие горы богов»·Сложный уровень сложности открыт>"
  },
  FeatureUnlock_147083_LockTip = {
    Text = "Разблокируется после прохождения «五日谈»·Обычный"
  },
  FeatureUnlock_147084_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_147085_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_147086_FeatureName = {
    Text = "Активность Генезис Ожье"
  },
  FeatureUnlock_147392_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_147393_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_147394_LockTip = {
    Text = "Разблокируется после завершения «временный текст»·обычный"
  },
  FeatureUnlock_147395_FeatureName = {
    Text = "Активность Вечерняя Звезда·Тинктер"
  },
  FeatureUnlock_147801_FeatureName = {
    Text = "Разложение материалов"
  },
  FeatureUnlock_147801_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_148487_FeatureName = {
    Text = "Автоматическая транскрипция договора"
  },
  FeatureUnlock_148487_LockTip = {
    Text = "Доступен при уровне расследования 45"
  },
  FeatureUnlock_148488_FeatureName = {
    Text = "Мистическое слияние"
  },
  FeatureUnlock_148488_LockTip = {
    Text = "Разблокируется на 60 уровне исследования"
  },
  FeatureUnlock_148488_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Мистическое слияние открыто>\n\n<FeatureUnlockDesc:Мисаг расшифровал в древних текстах ритуал слияния, позволяющий запечатлеть мистические узы в духовном ядре, что значительно усиливает их эффект усиления. Попробуйте сами.\nСоедините мистические узы с Пробуждённым, чтобы получить дополнительный бонус к основному атрибуту.>"
  },
  FeatureUnlock_16955_FeatureName = {
    Text = "Составление материалов"
  },
  FeatureUnlock_16955_LockTip = {
    Text = "Завершите \"Расследовательская операция\" 2-15·Обычный, чтобы разблокировать"
  },
  FeatureUnlock_16956_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_16957_FeatureName = {
    Text = "Извлечение премиального серебра"
  },
  FeatureUnlock_16957_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_16958_FeatureName = {
    Text = "\"Исследование\" Глава 2"
  },
  FeatureUnlock_16958_LockTip = {
    Text = "Разблокируется после завершения \"Исследование\" Глава 1 · Обычный"
  },
  FeatureUnlock_16958_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Во имя восковых фигур\" открыта>\n\n<FeatureUnlockDesc:Следуя подсказкам, предоставленным Дженкином, вы решаете отправиться по адресу 44 Саутварк-стрит, чтобы узнать правду о восковой фигуре...>"
  },
  FeatureUnlock_16959_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 3"
  },
  FeatureUnlock_16959_LockTip = {
    Text = "После завершения главы 2 \"Исследование·обычный\" доступ будет разблокирован"
  },
  FeatureUnlock_16959_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Остерегайтесь злых псов\"открыта>\n\n<FeatureUnlockDesc:В поисках слухов об адском псе \"Цербере\", следователи Мисаг прибыли в маленький городок Лай на окраине Лентиниена, чтобы раскрыть тайну за исчезновениями...>"
  },
  FeatureUnlock_16960_FeatureName = {
    Text = "Безумный городок"
  },
  FeatureUnlock_16960_LockTip = {
    Text = "После завершения \"Расследовательская операция\" Глава 3 · обычный разблокируется"
  },
  FeatureUnlock_16961_FeatureName = {
    Text = "Путешествие Ультра·Промежуток между сменами"
  },
  FeatureUnlock_16961_LockTip = {
    Text = "Прохождение Путешествие в сверхизмерении·Промежуток Ⅷ разблокировать"
  },
  FeatureUnlock_16962_FeatureName = {
    Text = "Путешествие Ультра·Промежуток между сменами"
  },
  FeatureUnlock_16962_LockTip = {
    Text = "Прохождение Путешествие в сверхизмерении·Промежуток Ⅷ разблокировать"
  },
  FeatureUnlock_16963_FeatureName = {
    Text = "Путешествие Ультра·Промежуток между сменами"
  },
  FeatureUnlock_16963_LockTip = {
    Text = "Прохождение Путешествие в сверхизмерении·Промежуток Ⅷ разблокировать"
  },
  FeatureUnlock_16964_FeatureName = {
    Text = "Цепь тьмы"
  },
  FeatureUnlock_16964_LockTip = {
    Text = "После завершения \"Расследовательская операция\" Глава 3 · обычный разблокируется"
  },
  FeatureUnlock_16965_FeatureName = {
    Text = "Разложение пакта"
  },
  FeatureUnlock_16965_LockTip = {
    Text = "Уровень расследования 25 разблокировано"
  },
  FeatureUnlock_16966_FeatureName = {
    Text = "Учебник"
  },
  FeatureUnlock_16966_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_16967_FeatureName = {
    Text = "Глава пролог"
  },
  FeatureUnlock_16968_FeatureName = {
    Text = "Основной Сюжет"
  },
  FeatureUnlock_16969_FeatureName = {
    Text = "Горы беспорядка"
  },
  FeatureUnlock_16969_LockTip = {
    Text = "После завершения \"Расследовательская операция\" Глава 4 (Обычный) будет разблокировано"
  },
  FeatureUnlock_16970_FeatureName = {
    Text = "Область тьмы"
  },
  FeatureUnlock_16970_LockTip = {
    Text = "Разблокируется после завершения \"Расследовательская операция\" 2-4·Обычный"
  },
  FeatureUnlock_16970_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Область тьмы открыта>\n\n<FeatureUnlockDesc:Ищите правду в темном мире. \nХранитель тайн может отправить команды из разных царств для испытаний и получить щедрые награды.>"
  },
  FeatureUnlock_16971_FeatureName = {
    Text = "Глава 5 \"Расследовательская операция\" · Безумие"
  },
  FeatureUnlock_16971_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_16971_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Глаза бури\"·безумие Включено>"
  },
  FeatureUnlock_16972_FeatureName = {
    Text = "Иллюзорное Вдаль от берегов"
  },
  FeatureUnlock_16972_LockTip = {
    Text = "Завершите \"Исследование\" 2-12·обычный, чтобы разблокировать"
  },
  FeatureUnlock_16972_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Иллюзорное Вдаль от берегов уже открыто>\n\n<FeatureUnlockDesc:Это древняя Иллюзия высоких существ. \nВо время погружения Страж должен преодолеть высокое давление негативного резонанса. Каждый день ждут разные испытания для вызова.>"
  },
  FeatureUnlock_16973_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 3 · Безумие"
  },
  FeatureUnlock_16973_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_16973_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Остерегайтесь злых псов\"·Сложный безумие Включено>"
  },
  FeatureUnlock_16977_FeatureName = {
    Text = "\"Исследование\"Глава 4"
  },
  FeatureUnlock_16977_LockTip = {
    Text = "После завершения \"Расследовательская операция\" Глава 3 · обычный разблокируется"
  },
  FeatureUnlock_16977_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"В безмолвии\"открыта>\n\n<FeatureUnlockDesc:Санаторий Лай не станет счастливым домом. Чтобы раскрыть завесу обмана, следователю придется углубиться внутрь...>"
  },
  FeatureUnlock_16978_FeatureName = {
    Text = "Маниакальный восковой музей"
  },
  FeatureUnlock_16978_LockTip = {
    Text = "После завершения главы 2 \"Исследование·обычный\" доступ будет разблокирован"
  },
  FeatureUnlock_16979_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 5"
  },
  FeatureUnlock_16979_LockTip = {
    Text = "После завершения \"Расследовательская операция\" Глава 4 (Обычный) будет разблокировано"
  },
  FeatureUnlock_16979_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Глаза бури\" открыта>\n\n<FeatureUnlockDesc:Чужие корабли, чужие девушки, чужие враги. Покачиваясь на волнах моря, следователям предстоит Рождённый войной с судьбой...>"
  },
  FeatureUnlock_16980_FeatureName = {
    Text = "Мистический апгрейд"
  },
  FeatureUnlock_16980_LockTip = {
    Text = "Уровень расследования 35 разблокирован"
  },
  FeatureUnlock_16980_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Функция улучшения ковенанта открыта>\n\n<FeatureUnlockDesc:Ковенант никогда не показывает свое истинное лицо, вам нужно терпеливо ждать, когда он сформируется. \nХранитель тайн может улучшить ковенант на странице усиления ковенанта, чтобы повысить основные свойства ковенанта.>"
  },
  FeatureUnlock_16981_FeatureName = {
    Text = "Мастерство царства"
  },
  FeatureUnlock_16981_LockTip = {
    Text = "Завершите «Исследование» 1-5·обычный, чтобы разблокировать"
  },
  FeatureUnlock_16982_FeatureName = {
    Text = "Тайна восковых фигур"
  },
  FeatureUnlock_16982_LockTip = {
    Text = "После завершения \"расследовательской операции\" 3-10·обычный будет разблокировано"
  },
  FeatureUnlock_16983_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_16984_FeatureName = {
    Text = "\"Исследование\" Глава 6"
  },
  FeatureUnlock_16984_LockTip = {
    Text = "Разблокируется после завершения главы 5 \"Расследовательская операция\"·обычный"
  },
  FeatureUnlock_16984_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Перевёрнутые звёзды\" Включено>\n\n<FeatureUnlockDesc:Корабль «Сона-Нил» — это движущийся Остров одиночества Крит, который несёт всем людям надежду на путешествие к берегу и свободе...>"
  },
  FeatureUnlock_16985_FeatureName = {
    Text = "Запретное писание"
  },
  FeatureUnlock_16985_LockTip = {
    Text = "Уровень расследования 25 разблокировано"
  },
  FeatureUnlock_16985_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Запретное писание открыта>\n\n<FeatureUnlockDesc:В тёмные времена эти символы были запрещены для переписывания и транскрипции.\nПроследите запретное прошлое, чтобы получить больше комплектов ковенантов.>"
  },
  FeatureUnlock_16986_FeatureName = {
    Text = "\"Расследовательская операция\"Глава 6 · Безумие"
  },
  FeatureUnlock_16986_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_16986_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Перевёрнутые звёзды\"·Сложность безумие включено>"
  },
  FeatureUnlock_16988_FeatureName = {
    Text = "Обитель червей"
  },
  FeatureUnlock_16988_LockTip = {
    Text = "Уровень расследования 20 разблокировано"
  },
  FeatureUnlock_16989_FeatureName = {
    Text = "\"Исследование\" Глава 2 · безумие"
  },
  FeatureUnlock_16989_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_16989_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Во имя восковых фигур\" · Сложность \"Безумие\" Включено>"
  },
  FeatureUnlock_16990_FeatureName = {
    Text = "Область Хаоса·Промежуток"
  },
  FeatureUnlock_16990_LockTip = {
    Text = "Для разблокировки завершите прохождение Области Хаоса·интервала VIII"
  },
  FeatureUnlock_16991_FeatureName = {
    Text = "Интерлюдия"
  },
  FeatureUnlock_16991_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_16991_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Интерлюдия. Учения Включено>\n\n<FeatureUnlockDesc:В эпоху частых бедствий вы можете погрузиться в иллюзии прошлого, чтобы открывать чудеса былых времен.\nПерейдите в миры прошлого для тренировки и получения материалов.>"
  },
  FeatureUnlock_16992_FeatureName = {
    Text = "Область Хаоса·Промежуток"
  },
  FeatureUnlock_16992_LockTip = {
    Text = "Для разблокировки завершите прохождение Области Хаоса·интервала VIII"
  },
  FeatureUnlock_16993_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_16994_FeatureName = {
    Text = "Столица жутких туманов"
  },
  FeatureUnlock_16994_LockTip = {
    Text = "Разблокируется после завершения \"Исследование\" Глава 1 · Обычный"
  },
  FeatureUnlock_16996_FeatureName = {
    Text = "Хватка благочестия"
  },
  FeatureUnlock_16996_LockTip = {
    Text = "Разблокируется после завершения главы 5 \"Расследовательская операция\"·обычный"
  },
  FeatureUnlock_16998_FeatureName = {
    Text = "Руины Понпеи"
  },
  FeatureUnlock_16998_LockTip = {
    Text = "Уровень расследования 20 разблокировано"
  },
  FeatureUnlock_17000_FeatureName = {
    Text = "Запись о росте"
  },
  FeatureUnlock_17000_LockTip = {
    Text = "Завершите «Исследование» 1-5·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17001_FeatureName = {
    Text = "Крэйзи Эрозия Тренировка (в разработке)"
  },
  FeatureUnlock_17001_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17002_FeatureName = {
    Text = "Золотой купон обмена"
  },
  FeatureUnlock_17002_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17003_FeatureName = {
    Text = "\"Расследовательская операция\"Глава 4·Сложность"
  },
  FeatureUnlock_17003_LockTip = {
    Text = "После завершения главы 3 \"Расследовательская операция\"· Сложный и главы 4 · обычный контент будет разблокирован"
  },
  FeatureUnlock_17003_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"В безмолвии\"·Сложный\"Сложный\"Включено>"
  },
  FeatureUnlock_17004_FeatureName = {
    Text = "Шварцшильдово горло"
  },
  FeatureUnlock_17004_LockTip = {
    Text = "Уровень расследования 20 разблокировано"
  },
  FeatureUnlock_17005_FeatureName = {
    Text = "Интерлюдия: Учения (в разработке)"
  },
  FeatureUnlock_17005_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17006_FeatureName = {
    Text = "Органический остаток"
  },
  FeatureUnlock_17006_LockTip = {
    Text = "Завершите \"расследовательскую операцию\" 1-13·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17007_FeatureName = {
    Text = "Космический остаток"
  },
  FeatureUnlock_17007_LockTip = {
    Text = "Завершите \"расследовательскую операцию\" 1-13·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17008_FeatureName = {
    Text = "Семестровые задания"
  },
  FeatureUnlock_17008_LockTip = {
    Text = "Завершите \"Исследование\"1-11·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17008_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Семестровые задания теперь открыты>\n\n<FeatureUnlockDesc:Никто не может избежать давления учёбы, Страж тоже имеет экзамены в конце семестра.\nВыполняйте ежедневные и еженедельные испытания в тайном классе, повышайте Уровень заданий и разблокируйте больше наград.>"
  },
  FeatureUnlock_17009_FeatureName = {
    Text = "Болото мяса и крови·Промежуток"
  },
  FeatureUnlock_17009_LockTip = {
    Text = "Разблокируется после завершения \"Расследовательская операция\" 2-4·Обычный"
  },
  FeatureUnlock_17010_LockTip = {
    Text = "Разблокируется после завершения \"Призрак дождливого города\"·обычный"
  },
  FeatureUnlock_17011_FeatureName = {
    Text = "Тень извне"
  },
  FeatureUnlock_17011_LockTip = {
    Text = "После завершения \"Расследовательская операция\" Глава 4 (Обычный) будет разблокировано"
  },
  FeatureUnlock_17012_FeatureName = {
    Text = "Библиотека тайных писаний"
  },
  FeatureUnlock_17012_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_17013_FeatureName = {
    Text = "Обмен осадка"
  },
  FeatureUnlock_17013_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17014_FeatureName = {
    Text = "Мистическая переиздание"
  },
  FeatureUnlock_17014_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17015_FeatureName = {
    Text = "Пробудить"
  },
  FeatureUnlock_17015_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17015_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Церемония пробуждения открыта>\n\n<FeatureUnlockDesc:Можно использовать \"Чистое ядро\" и \"Светоносное ядро\" для получения пробуждённого и судьбы.\nС помощью церемонии пробуждения также можно получить \"Коренной осадок\", чтобы обменять редкие материалы в Магазине Мисаг.>"
  },
  FeatureUnlock_17016_FeatureName = {
    Text = "Алхимия"
  },
  FeatureUnlock_17016_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17017_FeatureName = {
    Text = "Остаток морской бездны"
  },
  FeatureUnlock_17017_LockTip = {
    Text = "Завершите \"расследовательскую операцию\" 1-13·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17017_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Руины Растворения: Материалы для повышения открыты>\n\n<FeatureUnlockDesc:В руинах разрушения появляются образы остатков различных царств, запишите их на документе, прежде чем они рассеются.>"
  },
  FeatureUnlock_17018_FeatureName = {
    Text = "Озарение"
  },
  FeatureUnlock_17019_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_17020_FeatureName = {
    Text = "Погружение в сознание"
  },
  FeatureUnlock_17020_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_17021_LockTip = {
    Text = "Разблокируется после завершения \"Кровь и Песок\"·обычный"
  },
  FeatureUnlock_17022_FeatureName = {
    Text = "Выпускник"
  },
  FeatureUnlock_17022_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_17023_FeatureName = {
    Text = "Сердечная покупка"
  },
  FeatureUnlock_17023_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17024_FeatureName = {
    Text = "Обмен жемчужин слияния"
  },
  FeatureUnlock_17024_LockTip = {
    Text = "Завершите \"Исследование\" 2-12·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17025_FeatureName = {
    Text = "\"Расследовательская операция\"Глава 2: Сложный Уровень"
  },
  FeatureUnlock_17025_LockTip = {
    Text = "Завершите \"Исследование\" 1-8·Сложный и разблокируйте"
  },
  FeatureUnlock_17025_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Восковая фигура\" · Уровень сложности открыт>"
  },
  FeatureUnlock_17026_LockTip = {
    Text = "Уровень расследования 35 разблокирован"
  },
  FeatureUnlock_17027_LockTip = {
    Text = "Уровень расследования 25 разблокировано"
  },
  FeatureUnlock_17028_LockTip = {
    Text = "Доступен при уровне расследования 45"
  },
  FeatureUnlock_17029_LockTip = {
    Text = "Доступен при уровне расследования 45"
  },
  FeatureUnlock_17030_LockTip = {
    Text = "Уровень расследования 35 разблокирован"
  },
  FeatureUnlock_17031_FeatureName = {
    Text = "Область Хаоса·Промежуток"
  },
  FeatureUnlock_17031_LockTip = {
    Text = "Для разблокировки завершите прохождение Области Хаоса·интервала VIII"
  },
  FeatureUnlock_17032_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17033_FeatureName = {
    Text = "Штормовое открытое море"
  },
  FeatureUnlock_17033_LockTip = {
    Text = "Завершите главу 6 \"Исследование · обычный\", чтобы разблокировать"
  },
  FeatureUnlock_17034_FeatureName = {
    Text = "Почтовый ящик"
  },
  FeatureUnlock_17034_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17035_FeatureName = {
    Text = "Кластер Хаоса"
  },
  FeatureUnlock_17035_LockTip = {
    Text = "Уровень расследования 20 разблокировано"
  },
  FeatureUnlock_17035_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Руины Растворения·Материалы навыков теперь открыты>\n\n<FeatureUnlockDesc:Устали от обычных испытаний? На этот раз вы погрузитесь в глубины сознания, чтобы Превзойти вечность…\nИспользуйте особенности царства, чтобы легко получить материалы, необходимые для улучшения навыков пробуждающего тела.>"
  },
  FeatureUnlock_17036_FeatureName = {Text = "Акция"},
  FeatureUnlock_17036_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17036_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Активность открыта>\n\nХранитель может получить участие в акциях и игровых мероприятиях, завершив задания и получив щедрые награды!"
  },
  FeatureUnlock_17037_FeatureName = {
    Text = "Особая операция"
  },
  FeatureUnlock_17037_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_17038_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 5 · Сложный Уровень"
  },
  FeatureUnlock_17038_LockTip = {
    Text = "Завершите главу 4 \"Расследовательская операция\" в сложном режиме и главу 5 в обычном режиме для разблокировки"
  },
  FeatureUnlock_17038_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Глаза бури\" · Сложность Включено>"
  },
  FeatureUnlock_17039_FeatureName = {
    Text = "Гимн святого зародыша"
  },
  FeatureUnlock_17039_LockTip = {
    Text = "Завершите главу 6 \"Исследование · обычный\", чтобы разблокировать"
  },
  FeatureUnlock_17040_FeatureName = {
    Text = "Личное дело"
  },
  FeatureUnlock_17040_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17041_FeatureName = {
    Text = "Руины Растворения"
  },
  FeatureUnlock_17041_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17041_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Растворение пропасти: Обыск купюр/Растворение эликсира открыт>\n\n<FeatureUnlockDesc:Исследуя останки растворенных объектов, вы можете обменять банкноту с розой или растворить эликсир гнозиса в шкоумите Митхага.>"
  },
  FeatureUnlock_17042_FeatureName = {
    Text = "Общество"
  },
  FeatureUnlock_17042_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17043_FeatureName = {
    Text = "Мистический перенос"
  },
  FeatureUnlock_17043_LockTip = {
    Text = "Доступен при уровне расследования 45"
  },
  FeatureUnlock_17043_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Функция транскрибирования ковенанта открыта>\n\n<FeatureUnlockDesc:Средневековые писцы подвергались смертной казни за транскрибирование ковенанта, к счастью, вы сейчас находитесь в цивилизованную эпоху.\nХранитель тайн может выбрать вид и значение дополнительных свойств при усилении ковенанта.\nТранскрибирование не влияет на вид и значение основных свойств ковенанта.>"
  },
  FeatureUnlock_17044_FeatureName = {
    Text = "\"Исследование\"Глава 3 · Сложный"
  },
  FeatureUnlock_17044_LockTip = {
    Text = "Завершите \"Расследовательская операция\" 3-5·Обычный а также Глава 2·Сложность, чтобы разблокировать"
  },
  FeatureUnlock_17044_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Остерегайтесь злых псов\"·сложная Сложный открыта>"
  },
  FeatureUnlock_17045_FeatureName = {
    Text = "Разборка колеса судьбы"
  },
  FeatureUnlock_17045_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_17046_FeatureName = {
    Text = "Отчёт о миссии"
  },
  FeatureUnlock_17046_LockTip = {
    Text = "Завершите «Исследование» 1-5·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17047_FeatureName = {
    Text = "Мутный отстаток"
  },
  FeatureUnlock_17047_LockTip = {
    Text = "Завершите \"расследовательскую операцию\" 1-13·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17048_FeatureName = {
    Text = "Подарочный магазин"
  },
  FeatureUnlock_17048_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_17049_FeatureName = {
    Text = "Болото Каро·Промежуток между сменами"
  },
  FeatureUnlock_17049_LockTip = {
    Text = "Прохождение \"Болото плоти · Интервал VIII\" разблокировать"
  },
  FeatureUnlock_17050_FeatureName = {
    Text = "Болото Каро·Промежуток между сменами"
  },
  FeatureUnlock_17050_LockTip = {
    Text = "Прохождение \"Болото плоти · Интервал VIII\" разблокировать"
  },
  FeatureUnlock_17051_FeatureName = {
    Text = "Болото Каро·Промежуток между сменами"
  },
  FeatureUnlock_17051_LockTip = {
    Text = "Прохождение \"Болото плоти · Интервал VIII\" разблокировать"
  },
  FeatureUnlock_17052_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_17053_FeatureName = {
    Text = "Фазовый обмен"
  },
  FeatureUnlock_17053_LockTip = {
    Text = "После завершения \"Исследование\"3-2·обычный разблокируется"
  },
  FeatureUnlock_17054_FeatureName = {
    Text = "Фазовая игра"
  },
  FeatureUnlock_17054_LockTip = {
    Text = "После завершения \"Исследование\"3-2·обычный разблокируется"
  },
  FeatureUnlock_17054_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Фазовый поединок теперь открыт>\n\n<FeatureUnlockDesc:Когда различные фазы серебряных ядер начинают взаимодействовать и переплетаться, они определят единственного победителя.\nЭтот режим является дополнительным игровым режимом. Чтобы достичь более интересной и сбалансированной игровой среды, карты и общий игровой процесс могут значительно изменяться каждый сезон. Пожалуйста, внимательно вкладывайте ресурсы в этот режим.>"
  },
  FeatureUnlock_17055_FeatureName = {
    Text = "Замена материалов"
  },
  FeatureUnlock_17055_LockTip = {
    Text = "После завершения \"расследовательской операции\" 3-10·обычный будет разблокировано"
  },
  FeatureUnlock_17056_FeatureName = {
    Text = "\"Исследование\"·безумие"
  },
  FeatureUnlock_17056_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17056_UnlockDesc = {
    Text = "<FeatureUnlockTitle: \"Расследовательская операция\"· Сложный Безумия включена>"
  },
  FeatureUnlock_17057_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17058_FeatureName = {
    Text = "Достижение"
  },
  FeatureUnlock_17058_LockTip = {
    Text = "Завершите «Исследование» 1-5·обычный, чтобы разблокировать"
  },
  FeatureUnlock_17059_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17060_FeatureName = {
    Text = "Наследие глубокого моря·Промежуток между сменами"
  },
  FeatureUnlock_17060_LockTip = {
    Text = "Разблокируется после прохождения Наследие глубокого моря·Промежуток 8"
  },
  FeatureUnlock_17061_FeatureName = {
    Text = "Наследие глубокого моря·Промежуток между сменами"
  },
  FeatureUnlock_17061_LockTip = {
    Text = "Разблокируется после прохождения Наследие глубокого моря·Промежуток 8"
  },
  FeatureUnlock_17062_FeatureName = {
    Text = "Наследие глубокого моря·Промежуток между сменами"
  },
  FeatureUnlock_17062_LockTip = {
    Text = "Разблокируется после прохождения Наследие глубокого моря·Промежуток 8"
  },
  FeatureUnlock_17063_FeatureName = {
    Text = "Путешествие в сверхизмерении·Промежуток"
  },
  FeatureUnlock_17063_LockTip = {
    Text = "Разблокируется после завершения \"Расследовательская операция\" 2-4·Обычный"
  },
  FeatureUnlock_17064_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 1"
  },
  FeatureUnlock_17065_FeatureName = {
    Text = "Наследие глубокого моря: Промежуток"
  },
  FeatureUnlock_17065_LockTip = {
    Text = "Разблокируется после завершения \"Расследовательская операция\" 2-4·Обычный"
  },
  FeatureUnlock_17066_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 4 · Безумие"
  },
  FeatureUnlock_17066_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17066_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"В безмолвии\"·Сложный: безумие Включено>"
  },
  FeatureUnlock_17067_FeatureName = {
    Text = "Область Хаоса·промежуток"
  },
  FeatureUnlock_17067_LockTip = {
    Text = "Разблокируется после завершения \"Расследовательская операция\" 2-4·Обычный"
  },
  FeatureUnlock_17068_FeatureName = {
    Text = "\"Расследовательская операция\"Глава 1 · Сложность"
  },
  FeatureUnlock_17068_LockTip = {
    Text = "Завершите \"Исследование\"3-5·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17069_FeatureName = {
    Text = "\"Исследование\"·Сложный"
  },
  FeatureUnlock_17069_LockTip = {
    Text = "Завершите \"Исследование\"3-5·обычная, чтобы разблокировать"
  },
  FeatureUnlock_17069_UnlockDesc = {
    Text = "<FeatureUnlockTitle: \"Расследовательская операция\"·Сложность Включено>"
  },
  FeatureUnlock_17070_FeatureName = {
    Text = "\"Исследование\"Глава 6 · Сложный"
  },
  FeatureUnlock_17070_LockTip = {
    Text = "Завершите Главу 5 (Сложный) и Главу 6 (обычный) в \"Расследовательской операции\" для разблокировки"
  },
  FeatureUnlock_17070_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Перевёрнутые звёзды\" · Сложность \"Тяжёлая\" Включено>"
  },
  FeatureUnlock_17071_FeatureName = {
    Text = "Лодка тёмного моря"
  },
  FeatureUnlock_17071_LockTip = {
    Text = "Разблокируется после завершения главы 5 \"Расследовательская операция\"·обычный"
  },
  FeatureUnlock_17072_FeatureName = {
    Text = "Слёзы куклы"
  },
  FeatureUnlock_17072_LockTip = {
    Text = "После завершения \"расследовательской операции\" 3-10·обычный будет разблокировано"
  },
  FeatureUnlock_17073_FeatureName = {
    Text = "\"Расследовательская операция\"Глава 1 · Безумие"
  },
  FeatureUnlock_17073_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_17074_FeatureName = {
    Text = "Второе колесо судьбы"
  },
  FeatureUnlock_17074_LockTip = {
    Text = "На уровне расследования 15 можно использовать Часть 2 круг судьбы"
  },
  FeatureUnlock_17074_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Второе колесо судьбы открыто>\n\n<FeatureUnlockDesc:Страж может установить второе колесо судьбы для пробуждённого в интерфейсе колёс судьбы. Одному пробуждённому можно установить не более 1 колеса судьбы уровня SSR.\nРациональное сочетание может значительно повысить способности пробуждённого.>"
  },
  FeatureUnlock_17075_FeatureName = {
    Text = "Назначение"
  },
  FeatureUnlock_17075_LockTip = {
    Text = "Разблокируется после завершения \"Исследование\"1-8·обычный"
  },
  FeatureUnlock_17075_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Задания по диспетчеризации открыты>\n\n<FeatureUnlockDesc:Небольшие задания, которые переплетаются с расследованием и учёбой.\nДиспетчеризуйте пробуждённого для выполнения заданий и получайте Серебро и различные материалы.>"
  },
  FeatureUnlock_20225_LockTip = {
    Text = "Можно разблокировать после завершения \"Смерти скульптуры\"·обычный"
  },
  FeatureUnlock_20226_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_20227_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_20455_LockTip = {
    Text = "После завершения \"Желание рыцаря\" · обычный разблокировать"
  },
  FeatureUnlock_20456_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_20457_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_20458_LockTip = {
    Text = "Разблокируется после завершения \"Искажённое ядро\" (обычный)"
  },
  FeatureUnlock_20459_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_20460_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_20461_LockTip = {
    Text = "После завершения задания \"Бледный владыка\"·обычный режим станет доступным"
  },
  FeatureUnlock_20462_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_20463_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_20785_FeatureName = {
    Text = "Расследование обмена"
  },
  FeatureUnlock_20785_LockTip = {
    Text = "Разблокируется после завершения \"расследовательской операции\" 1-2 · обычный"
  },
  FeatureUnlock_20786_FeatureName = {
    Text = "Обмен тьмы"
  },
  FeatureUnlock_20786_LockTip = {
    Text = "После завершения \"Расследовательская операция\" 2-4 · Обычный доступ будет разблокирован"
  },
  FeatureUnlock_21402_FeatureName = {
    Text = "Регулярные задания"
  },
  FeatureUnlock_21452_FeatureName = {
    Text = "Трансцендентное существо"
  },
  FeatureUnlock_21452_LockTip = {
    Text = "После завершения \"расследовательской операции\" 3-10·обычный будет разблокировано"
  },
  FeatureUnlock_21452_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Сверхопытное существо открыто>\n\n<FeatureUnlockDesc:Они — запрещенные существа, игнорирующие все правила и причинно-следственные связи.\nРасходуя Менофин для вызова, можно получить более редкие материалы для улучшения навыков пробуждающего тела.>"
  },
  FeatureUnlock_23667_FeatureName = {
    Text = "Путешествие Ультра·Промежуток между сменами"
  },
  FeatureUnlock_23667_LockTip = {
    Text = "Прохождение Путешествие в сверхизмерении·Промежуток Ⅷ разблокировать"
  },
  FeatureUnlock_23668_FeatureName = {
    Text = "Область Хаоса·Промежуток"
  },
  FeatureUnlock_23668_LockTip = {
    Text = "Для разблокировки завершите прохождение Области Хаоса·интервала VIII"
  },
  FeatureUnlock_23669_FeatureName = {
    Text = "Болото Каро·Промежуток между сменами"
  },
  FeatureUnlock_23669_LockTip = {
    Text = "Прохождение \"Болото плоти · Интервал VIII\" разблокировать"
  },
  FeatureUnlock_23670_FeatureName = {
    Text = "Наследие глубокого моря·Промежуток между сменами"
  },
  FeatureUnlock_23670_LockTip = {
    Text = "Разблокируется после прохождения Наследие глубокого моря·Промежуток 8"
  },
  FeatureUnlock_23699_LockTip = {
    Text = "Завершите \"Магия историй\" · обычный, чтобы разблокировать"
  },
  FeatureUnlock_23700_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_23701_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_24502_LockTip = {
    Text = "Разблокируется после завершения \"Воспевание розы\"·обычный"
  },
  FeatureUnlock_24503_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_24504_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_25070_LockTip = {
    Text = "После завершения \"Шаг от\"·обычный будет разблокировано"
  },
  FeatureUnlock_25071_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_25072_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_25256_FeatureName = {
    Text = "Зона Р-эффекта"
  },
  FeatureUnlock_25256_LockTip = {
    Text = "Разблокируется после завершения \"расследовательской операции\" 4-3 ·обычный"
  },
  FeatureUnlock_25256_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Зона поглощения катастрофы открыта>\n\n<FeatureUnlockDesc:Углубитесь в зону Р-Эффект, чтобы снять тревогу о кризисе Чёрного Потока.\nХранитель тайн может отправить несколько команд для испытаний и получить щедрые награды, такие как Изначальный гнозис, Серебро и Чёрный дар.>"
  },
  FeatureUnlock_35576_FeatureName = {
    Text = "Магазин сюжета"
  },
  FeatureUnlock_35576_LockTip = {
    Text = "Завершите \"Исследование\"1-10 · обычный, чтобы разблокировать"
  },
  FeatureUnlock_36165_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_36166_LockTip = {
    Text = "Разблокируется после завершения \"всё идёт как обычно\"·обычный"
  },
  FeatureUnlock_36167_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_36628_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_36629_LockTip = {
    Text = "Завершите \"Пылающий банкет\"·обычный, чтобы разблокировать"
  },
  FeatureUnlock_36630_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_38850_FeatureName = {
    Text = "Шкатулка диковин Ванды"
  },
  FeatureUnlock_38850_LockTip = {
    Text = "Завершите \"Исследование\"1-10 · обычный, чтобы разблокировать"
  },
  FeatureUnlock_38851_FeatureName = {
    Text = "Город в озере"
  },
  FeatureUnlock_43518_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_43519_LockTip = {
    Text = "Доступно после завершения \"Падение гиганта\" · обычный"
  },
  FeatureUnlock_43520_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_44550_FeatureName = {
    Text = "Сальвадор"
  },
  FeatureUnlock_44568_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_44569_LockTip = {
    Text = "Завершите \"Цвет крови\" · обычный, чтобы разблокировать"
  },
  FeatureUnlock_44570_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_44700_LockTip = {
    Text = "После завершения \"Убийство из зависти\" в \"Особая операция: цвет крови\" можно разблокировать"
  },
  FeatureUnlock_44701_LockTip = {
    Text = "После завершения \"Наполнить пустой желудок\" в \"Особая операция: цвет крови\" разблокировать"
  },
  FeatureUnlock_44702_LockTip = {
    Text = "Разблокируется после завершения\"Символы крови\"в\"Особая операция: цвет крови\""
  },
  FeatureUnlock_44703_LockTip = {
    Text = "После завершения миссии \"Очищение грехов\" в \"Оперативной записи: цвет крови\" будет разблокировано"
  },
  FeatureUnlock_44704_LockTip = {
    Text = "После завершения \"Зажигая белую надежду\" в \"Особая операция: цвет крови\" будет разблокировано"
  },
  FeatureUnlock_46186_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_46187_LockTip = {
    Text = "Разблокируется после завершения \"Тихая фрагментация\"·обычный"
  },
  FeatureUnlock_46188_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_47456_FeatureName = {
    Text = "Всестороннее исцеление"
  },
  FeatureUnlock_47457_LockTip = {
    Text = "После завершения \"Источник\" в \"Особая операция: Тишина Расщепление\" разблокируется"
  },
  FeatureUnlock_47458_LockTip = {
    Text = "После завершения \"Конец пути\" в \"Особая операция: Тишь Расщепление\" будет разблокировано"
  },
  FeatureUnlock_47459_LockTip = {
    Text = "Разблокируется после завершения \"Золотая фуга\" в \"Особая операция: Тишь Расщепление\""
  },
  FeatureUnlock_47460_LockTip = {
    Text = "После завершения задания \"Бессонная змея\" в \"Особая операция: Тишь расщепления\" будет разблокировано"
  },
  FeatureUnlock_47461_LockTip = {
    Text = "Разблокируется после завершения \"Сказка теней\" в \"Особая операция: Тишина Расщепление\""
  },
  FeatureUnlock_48920_FeatureName = {
    Text = "\"Исследование\"Глава 7"
  },
  FeatureUnlock_48920_LockTip = {
    Text = "Завершите главу 6 \"Исследование · обычный\", чтобы разблокировать"
  },
  FeatureUnlock_48920_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Река желаний\"·включена>\n\n<FeatureUnlockDesc:Священная река Карагай на севере Ремуахе питает прошлое и будущее кочевого народа Арам...>"
  },
  FeatureUnlock_48921_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 7 · Сложный"
  },
  FeatureUnlock_48921_LockTip = {
    Text = "Завершите главу 6 \"Расследовательская операция\" в режиме \"Сложный\" и главу 7 \"обычный\" для разблокировки"
  },
  FeatureUnlock_48921_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Река желаний\"· Сложный Включено>"
  },
  FeatureUnlock_48922_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 7 · Безумие"
  },
  FeatureUnlock_48922_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_48922_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Река желаний\"·Сложный безумие Включено>"
  },
  FeatureUnlock_49170_FeatureName = {
    Text = "Реликвии песков"
  },
  FeatureUnlock_49170_LockTip = {
    Text = "Завершите главу 7 \"Исследование·обычный\", чтобы разблокировать"
  },
  FeatureUnlock_49171_FeatureName = {
    Text = "Стена пустынного песка"
  },
  FeatureUnlock_49171_LockTip = {
    Text = "Завершите главу 7 \"Исследование·обычный\", чтобы разблокировать"
  },
  FeatureUnlock_49205_FeatureName = {
    Text = "Пробуждающее тело тест"
  },
  FeatureUnlock_49205_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_49296_FeatureName = {
    Text = "Колесо Судьбы"
  },
  FeatureUnlock_49296_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49298_FeatureName = {
    Text = "Событие"
  },
  FeatureUnlock_49298_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49300_FeatureName = {
    Text = "Сюжетный CG"
  },
  FeatureUnlock_49300_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49301_FeatureName = {
    Text = "Фонограф"
  },
  FeatureUnlock_49301_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49302_FeatureName = {
    Text = "Изображение"
  },
  FeatureUnlock_49302_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49303_FeatureName = {
    Text = "Мир гравия"
  },
  FeatureUnlock_49303_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49304_FeatureName = {Text = "Роль"},
  FeatureUnlock_49304_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49305_FeatureName = {
    Text = "Ковенант"
  },
  FeatureUnlock_49305_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49306_FeatureName = {
    Text = "Запретный канон наносных отложений"
  },
  FeatureUnlock_49306_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49307_FeatureName = {
    Text = "Организованная Огромная Огромная Огромная Огромная сила"
  },
  FeatureUnlock_49307_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49308_FeatureName = {
    Text = "Сцена CG"
  },
  FeatureUnlock_49308_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49309_FeatureName = {
    Text = "Хроника"
  },
  FeatureUnlock_49309_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49310_FeatureName = {
    Text = "Реликвия"
  },
  FeatureUnlock_49310_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49311_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_49418_FeatureName = {
    Text = "Общий тип задачи"
  },
  FeatureUnlock_49418_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_49567_FeatureName = {
    Text = "Безумие размножения"
  },
  FeatureUnlock_49567_LockTip = {
    Text = "После завершения \"Расследовательской операции\"7-3·Обычный разблокируется"
  },
  FeatureUnlock_49567_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Безумие размножения открыто>\n\n<FeatureUnlockDesc:Под воздействием загадочной силы пробуждающие тела впали в состояние \"Репродуктивного безумия\"... Прошу всех Хранителей тайн быть осторожными!>"
  },
  FeatureUnlock_50092_FeatureName = {
    Text = "Плотские желания"
  },
  FeatureUnlock_51255_FeatureName = {
    Text = "История магия·Погоня за светом Копия"
  },
  FeatureUnlock_51256_LockTip = {
    Text = "Разблокируется после завершения \"Силы Энди Джонсона\" в \"Особая операция: история магии\""
  },
  FeatureUnlock_51257_LockTip = {
    Text = "После завершения задания \"В поисках истории\" в \"Особая операция: Магия историй\" будет разблокировано"
  },
  FeatureUnlock_51258_LockTip = {
    Text = "Разблокируется после завершения \"Щедрость торговца\" в \"Оперативной записи: история магии\""
  },
  FeatureUnlock_51259_LockTip = {
    Text = "После завершения \"Самого дорогого человека\" в \"Особая операция: история магии\" будет разблокировано"
  },
  FeatureUnlock_51260_LockTip = {
    Text = "Разблокируется после завершения \"Наилучший цветок\" в \"Особая операция: история магии\""
  },
  FeatureUnlock_51261_LockTip = {
    Text = "После завершения \"Идеальный финал\" в \"Особая операция: история магии\" будет разблокировано"
  },
  FeatureUnlock_51262_LockTip = {
    Text = "Разблокируется после завершения \"Самого грандиозного видения\" в \"Оперативной записи: история волшебства\""
  },
  FeatureUnlock_51263_LockTip = {
    Text = "После завершения \"Идеальный финал\" в \"Особая операция: история магии\" будет разблокировано"
  },
  FeatureUnlock_51264_LockTip = {
    Text = "После завершения \"Идеальный финал\" в \"Особая операция: история магии\" будет разблокировано"
  },
  FeatureUnlock_51757_FeatureName = {
    Text = "Мир чуждых снов"
  },
  FeatureUnlock_51757_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_51759_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_54118_FeatureName = {
    Text = "Послание розы"
  },
  FeatureUnlock_55456_FeatureName = {
    Text = "Пока сад ещё не увял"
  },
  FeatureUnlock_55458_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_55459_LockTip = {
    Text = "Разблокируется после завершения \"Обитель роз\"·обычный"
  },
  FeatureUnlock_55460_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_57707_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_57708_LockTip = {
    Text = "Разблокируется после завершения \"Удачная охота!\"·обычный"
  },
  FeatureUnlock_57709_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_57710_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_57712_LockTip = {
    Text = "Разблокируется после завершения \"Вернуться в Элворт\"·обычный"
  },
  FeatureUnlock_57714_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_58025_FeatureName = {
    Text = "Мероприятие Мерфи"
  },
  FeatureUnlock_58026_FeatureName = {
    Text = "Вернуться события Мириам"
  },
  FeatureUnlock_58027_FeatureName = {
    Text = "Сальвадор акция повтора"
  },
  FeatureUnlock_58028_FeatureName = {
    Text = "Акция Источник Дор"
  },
  FeatureUnlock_58029_FeatureName = {
    Text = "Акция источника Хило"
  },
  FeatureUnlock_58030_FeatureName = {
    Text = "Активность Тауи"
  },
  FeatureUnlock_58031_FeatureName = {
    Text = "Акция Хамлина"
  },
  FeatureUnlock_58032_FeatureName = {
    Text = "Лейк активность"
  },
  FeatureUnlock_58033_FeatureName = {
    Text = "Акция с Вандой"
  },
  FeatureUnlock_58034_FeatureName = {
    Text = "24 репликаакция"
  },
  FeatureUnlock_58907_FeatureName = {
    Text = "\"Исследование\" Глава 8"
  },
  FeatureUnlock_58907_LockTip = {
    Text = "Завершите главу 7 \"Исследование·обычный\", чтобы разблокировать"
  },
  FeatureUnlock_58907_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Финальная симфония\"открыта>\n\n<FeatureUnlockDesc:Вход. Спокойно сидеть. Ожидание. Желание.\nДирижёрская палочка легко поднята. Готовы ли вы услышать самые сокровенные тайны вселенной?>"
  },
  FeatureUnlock_58908_FeatureName = {
    Text = "Финальная глава \"Исследование\""
  },
  FeatureUnlock_58908_LockTip = {
    Text = "После завершения главы 8 \"Расследовательская операция\"·обычный разблокируется"
  },
  FeatureUnlock_58908_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Конец долгого сна\"включена>\n\n<FeatureUnlockDesc:Он видел долгий сон.\nОн видел сны о богах и звёздах, о том, как пыль превращается в цивилизацию, а цивилизация вновь становится пылью.\nОн видел Досаждение и любовь, видел радость и Страх.\nОн проснулся в ужасе. Всё, что было в его сновидении, никогда не существовало.>"
  },
  FeatureUnlock_58909_FeatureName = {
    Text = "\"Расследовательская операция\" Финальная глава · Сложный"
  },
  FeatureUnlock_58909_LockTip = {
    Text = "Завершите \"Расследовательская операция\", главу 8 · Сложный, и главу 9 · обычный, чтобы разблокировать"
  },
  FeatureUnlock_58909_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Конец долгого сна\"·сложная Сложный включена>"
  },
  FeatureUnlock_58911_FeatureName = {
    Text = "\"Расследовательская операция\"Глава 8 · Сложность"
  },
  FeatureUnlock_58911_LockTip = {
    Text = "Завершите \"Расследовательскую операцию\"Главу 7·Сложность и Главу 8·Обычный для разблокировки"
  },
  FeatureUnlock_58911_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Финальная симфония\"·сложный Уровень открыт>"
  },
  FeatureUnlock_58912_FeatureName = {
    Text = "\"Расследовательская операция\" Глава 8 · Безумие"
  },
  FeatureUnlock_58912_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_58912_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Финальная симфония\"·безумие Включено>"
  },
  FeatureUnlock_58913_FeatureName = {
    Text = "Первородный разлом"
  },
  FeatureUnlock_58913_LockTip = {
    Text = "После завершения главы 8 \"Расследовательская операция\"·обычный разблокируется"
  },
  FeatureUnlock_58914_FeatureName = {
    Text = "Волны чёрного пруда"
  },
  FeatureUnlock_58914_LockTip = {
    Text = "После завершения главы 8 \"Расследовательская операция\"·обычный разблокируется"
  },
  FeatureUnlock_58915_FeatureName = {
    Text = "Финальная глава \"Расследовательская операция\"· Безумие"
  },
  FeatureUnlock_58915_LockTip = {
    Text = "Следите за обновлениями"
  },
  FeatureUnlock_58915_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Конец долгого сна\"·безумие Включено>"
  },
  FeatureUnlock_60580_FeatureName = {
    Text = "Сердечная связь"
  },
  FeatureUnlock_60580_LockTip = {
    Text = "После завершения \"Расследовательская операция\" 2-1·Обычный будет разблокировано"
  },
  FeatureUnlock_60580_UnlockDesc = {
    Text = "<FeatureUnlockTitle:сердечная связь из серебра Включено>\n\n<FeatureUnlockDesc:Союзники, товарищи и Близкий Близкий Близкий Близкий друг, потрясите волшебную коробку, чтобы связаться с ними.>"
  },
  FeatureUnlock_68887_FeatureName = {
    Text = "Акция Клементина"
  },
  FeatureUnlock_68888_FeatureName = {
    Text = "Источник Тулу акция"
  },
  FeatureUnlock_68889_FeatureName = {
    Text = "Тулу активность"
  },
  FeatureUnlock_68890_FeatureName = {
    Text = "Мероприятие Мёрфи: Лжерождённая"
  },
  FeatureUnlock_68891_FeatureName = {
    Text = "Давдейл акция"
  },
  FeatureUnlock_68892_FeatureName = {
    Text = "Акция Мордигиана"
  },
  FeatureUnlock_68893_FeatureName = {
    Text = "Рулим акция"
  },
  FeatureUnlock_68894_FeatureName = {
    Text = "Антрэк акция"
  },
  FeatureUnlock_70556_FeatureName = {Text = "Акция"},
  FeatureUnlock_70556_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_71851_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_72031_FeatureName = {
    Text = "\"Исследование\"Звёздное Царство Глава 1"
  },
  FeatureUnlock_72031_LockTip = {
    Text = "Завершите Главу 9: Расследовательская операция (обычный режим), чтобы разблокировать"
  },
  FeatureUnlock_72031_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Звёзды сошлись·Вернуться в город туманов\"открыта>\n\n<FeatureUnlockDesc:В дыхании пыли Пульсация, Увядание Солнца едва ли может пробиться сквозь>"
  },
  FeatureUnlock_72035_FeatureName = {
    Text = "Прохождение сюжетной линии \"Забытое наследие\""
  },
  FeatureUnlock_72035_LockTip = {
    Text = "Завершите Главу 9 \"Исследование·обычный\" и вернитесь на главный экран для воспроизведения"
  },
  FeatureUnlock_72076_FeatureName = {
    Text = "\"Расследовательская операция\" \"Звёздное Царство\" Глава 1 · Сложный"
  },
  FeatureUnlock_72076_LockTip = {
    Text = "Завершите \"расследовательскую операцию\" Звёздное Царство, Глава 1·обычный, чтобы разблокировать"
  },
  FeatureUnlock_72076_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Расследовательская операция \"Вернуться в город туманов\" · Сложность Включено>"
  },
  FeatureUnlock_73800_FeatureName = {
    Text = "Акция повторного выпуска Морфи"
  },
  FeatureUnlock_74239_LockTip = {
    Text = "После завершения \"Прах страсти\"·обычный, будет разблокировано"
  },
  FeatureUnlock_74240_LockTip = {
    Text = "Не доступно"
  },
  FeatureUnlock_74241_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_74337_FeatureName = {
    Text = "Акция \"Обратный ход\""
  },
  FeatureUnlock_74341_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_74348_FeatureName = {
    Text = "Сальвадор акция повтора"
  },
  FeatureUnlock_74362_FeatureName = {
    Text = "Повтор акции Лекк"
  },
  FeatureUnlock_75909_FeatureName = {
    Text = "Аудиоспектакль"
  },
  FeatureUnlock_75909_LockTip = {
    Text = "Пока нет избранного"
  },
  FeatureUnlock_78650_FeatureName = {
    Text = "24 репликаакция"
  },
  FeatureUnlock_78734_FeatureName = {
    Text = "Многомерное соединение"
  },
  FeatureUnlock_78734_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_78793_FeatureName = {
    Text = "Акция источника Хило"
  },
  FeatureUnlock_79686_FeatureName = {
    Text = "Дизайн пробуждающего"
  },
  FeatureUnlock_79686_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_80156_LockTip = {
    Text = "Завершите \"Исследование\" 1-9·обычный режим, чтобы разблокировать"
  },
  FeatureUnlock_80317_FeatureName = {
    Text = "«Расследование» Глава 2 Звезды · Сложно"
  },
  FeatureUnlock_80317_LockTip = {
    Text = "Завершите первую главу «Космическое расследование» на уровне сложности «Трудный» и вторую главу на уровне сложности «Обычный» для разблокировки"
  },
  FeatureUnlock_80317_UnlockDesc = {
    Text = "<FeatureUnlockTitle:расследование \"трансформация\"·трудный Уровень открыт>"
  },
  FeatureUnlock_80318_FeatureName = {
    Text = "«Расследование» Глава 2 Звезды"
  },
  FeatureUnlock_80318_LockTip = {
    Text = "Завершите \"расследовательскую операцию\" Звёздное Царство, Глава 1·обычный, чтобы разблокировать"
  },
  FeatureUnlock_80318_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование \"Звёзды сошлись·Метаморфоза\" открыта>\n\n<FeatureUnlockDesc:Следуя знакомому золотистому силуэту, Страж приходит в неизведанный санаторий. Здесь скрыто множество разрушенных секретов и душ.>"
  },
  FeatureUnlock_83813_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_84307_FeatureName = {
    Text = "Действие Коперсанта"
  },
  FeatureUnlock_84356_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_88941_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_88942_FeatureName = {
    Text = "Активность Кастора"
  },
  FeatureUnlock_89531_FeatureName = {
    Text = "Магазин костюмов"
  },
  FeatureUnlock_89531_LockTip = {
    Text = "Разблокируется после прохождения пролога"
  },
  FeatureUnlock_90492_LockTip = {
    Text = "Завершите \"Исследование\" 1-2·обычная, чтобы разблокировать"
  },
  FeatureUnlock_91201_FeatureName = {
    Text = "Код приглашения друга"
  },
  FeatureUnlock_91201_LockTip = {
    Text = "Разблокировать после прохождения пролога"
  },
  FeatureUnlock_91202_FeatureName = {
    Text = "«Операция расследования»Глава третья звёзд"
  },
  FeatureUnlock_91202_LockTip = {
    Text = "Завершить главу 2 \"Операции расследования\" в звёздной части на уровне сложности \"Обычный\" для разблокировки"
  },
  FeatureUnlock_91202_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследование\"Звёзды сошлись·Торжество в чертоге мёртвых\"открыта>\n\n<FeatureUnlockDesc:Пройдите сквозь туман кладбища, величественное королевство уже пришло к вам. \nКороль Гулов терпеливо ждёт, ожидая вашего участия в его банкет.>"
  },
  FeatureUnlock_91203_FeatureName = {
    Text = "«Операция расследования»Глава третья звёзд · Трудный"
  },
  FeatureUnlock_91203_LockTip = {
    Text = "Завершить главу 2 \"Операции расследования\" в звёздной части на уровне сложности \"Трудный\" и главу 3 на уровне сложности \"Обычный\" для разблокировки"
  },
  FeatureUnlock_91203_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Исследовательская операция «Пиршество»·Сложный Уровень открыт>"
  },
  FeatureUnlock_91238_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_91239_FeatureName = {
    Text = "Римская акция"
  },
  FeatureUnlock_94856_FeatureName = {
    Text = "Летние специальные события·первая часть"
  },
  FeatureUnlock_94857_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_95783_FeatureName = {
    Text = "Дулесайн активирует"
  },
  FeatureUnlock_97143_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_97144_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_97145_FeatureName = {
    Text = "Катхигу-Ра мероприятие"
  },
  FeatureUnlock_97146_FeatureName = {
    Text = "Активность Пикмана"
  },
  FeatureUnlock_97671_FeatureName = {
    Text = "Мероприятие \"Источник Дамы глубин\""
  },
  FeatureUnlock_97894_LockTip = {
    Text = "<Posse:Завершите миссию «Расследование» 1-2·Обычный, чтобы разблокировать>"
  },
  FeatureUnlock_97895_FeatureName = {
    Text = "Летние специальные события·вторая часть"
  },
  FeatureUnlock_97929_LockTip = {
    Text = "<Posse:Завершите миссию «Прощай, Никогда-никогда»·обычный, чтобы разблокировать>"
  }
})
return Text_FeatureUnlock
