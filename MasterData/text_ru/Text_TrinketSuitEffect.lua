__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "Дань апреля"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Критический Урон +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Уникальная команда>: в начале хода, если общая жизнь врагов больше 75%, у носителя временно увеличивается критический шанс и критический Урон на +35%."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Кольцевая поэма (Не завершено)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "В начале четного хода снижает расход вычислительной мощности одной случайной карты в руке на 1."
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Береговая линия"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Мастерство границы +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Уникальное команды>: в начале боя получите силу, равную 12% от атакующей силы носителя. Если текущее Царство — «Эквор», Эффект изменяется на: «в начале каждого хода есть (50+0.25*Мастерство царства команды)% шанс получить 1 слой Скопление щупалец, при превышении 100% можно получить несколько слоёв, вероятность в Босс Битве удваивается."
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Проклятый кролик"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Мастерство границы +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "Снаряжение увеличивает щит и Лечение жизни на 12%."
  },
  TrinketSuitEffect_18339_Name = {
    Text = "Антиномия"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Уровень серебряного ключа подзарядки +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Уникальное команды>: базовый Алиемус носителя увеличивается на 20 очков, крит. шанс, крит. Урон, щит и восстановление ОЗ карты команды носителя увеличиваются на 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Органическая форма"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Чёрный Отпечаток дроп +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Уникальный Отряд>. При начале исследования вычитается до 100% сопротивления смерти. Каждое вычитание 1% сопротивления смерти увеличивает безумие носителя на 0.15%."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Багровый пульс"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Критический Урон +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "После освобождения ключевого приказа, носитель получает 30% критический шанс."
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Стандартная мистерия SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "Наносимый Урон, лечение и Усиление щита на 15%."
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Обычная мистерия R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "Наносимый Урон, лечение и Усиление щита на 15%."
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Бог из машины"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Мастерство границы +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "В начале каждого боя получите 1 очко мощности. Против лидера каждые 4 хода дополнительно получайте 1 очко мощности"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Ритуал фотосинтеза"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "Урон сильнодействующий +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Уникальное команды>: после того, как Командная Карта носителя попадает в Ультра пространство, слияние эмбрионов увеличивается на +25~50, чем ниже текущее здоровье, тем больше полученное слияние эмбрионов."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Дальнейшая эволюция"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Уровень восстановления безумия +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Уникальное команды>: в начале исследования носитель получает 35 очков Алиемуса. После использования вспышки Алиемуса, в конце хода в этом бою носитель получает 2 очка Алиемуса, Эффект может накапливаться до 3 раз."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "Высасывание жизни"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Уровень серебряного ключа подзарядки +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Уникальное команды>: по окончании хода получить энергию серебряного ключа, эквивалентную 200% заряда серебряного ключа носителя. Если текущее царство «Кровь и плоть», Эффект изменяется на: за каждые 5 единиц заряда серебряного ключа слияние эмбрионов +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "Сон о лекарстве"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "Урон сильнодействующий +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Уникальное команды>. Чёрная печать, полученная в конце боя –8, в начале боя перетасуйте базовую копию неударной карты защиты снаряженца в колоду для розыгрыша, не более 1 карты каждого типа."
  },
  TrinketSuitEffect_18349_Name = {
    Text = "Сладкий слизень"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +25.2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Команда уникальна>: если в 1 ходу одновременно использована «Аннигиляция» и переключена поза щупальца, щит, восстановление здоровья и финальный Урон снаряженца в этом ходу +25%, перезарядка 3 хода."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Театральный кот (Не завершено)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "Наносимый экипировщиком Урон врагам с уровнем жизни больше 75% всегда наносится как критический Удар."
  },
  TrinketSuitEffect_18351_Name = {
    Text = "Кольцо комнаты 36"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Уровень восстановления безумия +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Уникальное команды>. Максимум энергии серебряного ключа и расход ключевого приказа +200, крит. шанс, крит. Урон, щит и восстановление ОЗ при вспышке Алиемуса носителя увеличиваются на 30%."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Искажённые близнецы: белый"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "В начале четного хода добавьте в руку «защита владельца снаряжения» с <NothingnessIconKeywords:ничто> и <DepleteIconKeywords:расход>."
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Багровые объятия"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Критический шанс +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "Носитель получает 35 очков Ключесвета при нанесении урона, если наносит крит. Урон, получает 70 очков Ключесвета, максимум 3 раза за ход."
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Стандартный мистерия SR (СР)"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "Наносимый Урон, лечение и Усиление щита на 15%."
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Чистое Откровение"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Уровень серебряного ключа подзарядки +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Уникальное команды>: после освобождения ключевого приказа восстановите здоровье, равное 12% Тело снаряженца, Эффект увеличивается в зависимости от процента потерянного здоровья, максимум до 24% Тело снаряженца."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Степной волк"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "Урон сильнодействующий +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "Базовый Урон, наносимый носителем, увеличивается на 20%, а Усиление урона от эффектов <IntoxicationIconKeywords:отравления> и <RetaliateIconKeywords:контратаки>, повышается на 10%."
  },
  TrinketSuitEffect_18357_Name = {
    Text = "Далёкий Роскошный Роскошный Роскошный Роскошный пир"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Чёрный Отпечаток дроп +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "При начале исследования получите 10 чёрных печатей. У владельца щит от «защита» увеличен на 60%."
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Искажённые близнецы: чёрный"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Критический шанс +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "В начале нечетного хода добавьте в руку карту \"Удар\" с <NothingnessIconKeywords:ничто> и <DepleteIconKeywords:расход> на владельца снаряжения."
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Куколка девушки"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Критический шанс +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Уникальное команды>: у снаряженца после первого расхода эмбриона в каждом ходу за каждое щупальце получает 8% временного критического урона, максимум 80%."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Кладбищенский шёпот"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Сопротивление смерти +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "В начале уровня <DeathResistanceIconKeywords:Сопротивление смерти> увеличивается на 25%. После активации сопротивления смерти, носитель получает 50 очков безумия."
  },
  TrinketSuitEffect_99234_Name = {Text = "гумус"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "временный текст"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "временный текст"
  },
  TrinketSuitEffect_99235_Name = {
    Text = "Вознесение"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "временный текст"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "временный текст"
  },
  TrinketSuitEffect_99236_Name = {Text = "Стикс"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "временный текст"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "временный текст"
  }
})
return Text_TrinketSuitEffect
