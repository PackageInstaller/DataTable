__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {
    Text = "Учетная запись"
  },
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Максимальный Урон"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Наибольшее количество этажей"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Время завершения"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Все достижения"
  },
  CommonID_AchieveType1_Desc = {
    Text = "История роста"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Расследовать метку"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Боевой дневник"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Тайная жизнь"
  },
  CommonID_Add_State_Desc = {
    Text = "Добавить состояние"
  },
  CommonID_All_Desc = {Text = "Все"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Условие завершения задачи: активирован любой сюжетный узел"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Условие завершения задачи: разблокирован любой элемент справочника в группе"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Условие завершения задачи: выполнено любое событие"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Условие завершения задачи: получить любой предмет"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Условие завершения задачи: срабатывание любого типа узла"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Условие завершения задачи: получить любое создание"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Условие завершения задачи: первое прохождение любого уровня из списка"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Назначение дополнительных наград"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Повышение характеристик"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Смерть пробудившегося тела"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Лидера пробуждающего тела"
  },
  CommonID_BN_Desc = {
    Text = "Бенгальский (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Не может выйти на поле боя"
  },
  CommonID_Battle_Desc = {Text = "Битва"},
  CommonID_Blue_Desc = {Text = "Синий"},
  CommonID_Boss_Desc = {Text = "Босс"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Связывание клавиш"
  },
  CommonID_CN_Desc = {
    Text = "Пожалуйста, предоставьте текст на упрощенном китайском языке для перевода"
  },
  CommonID_CardBorder_Desc = {
    Text = "Внешний вид карты"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Улучшение слотов"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Высший образ"
  },
  CommonID_Card_AttachPost_Desc = {
    Text = "Погоня"
  },
  CommonID_Card_Awake_Desc = {
    Text = "Возвышение"
  },
  CommonID_Card_Curse_Desc = {
    Text = "Карта симптомов"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Карта защиты"
  },
  CommonID_Card_Developing_Desc = {
    Text = "В разработке"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Производная Карта"
  },
  CommonID_Card_Fraud_Desc = {
    Text = "Мошенничество"
  },
  CommonID_Card_Imagery_Desc = {Text = "Образ"},
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Ключевая Карта"
  },
  CommonID_Card_Potion_Desc = {
    Text = "Зелье карточка"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Карта умения"
  },
  CommonID_Card_State_Desc = {
    Text = "Карта состояния"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Ударная Карта"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Колесо судьбы Карта"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Уровень заклинаний"
  },
  CommonID_Challenge_Desc = {
    Text = "Расследование"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Заменить навык"
  },
  CommonID_Chinese_Desc = {
    Text = "Китайский язык"
  },
  CommonID_ChooseHandCard_Desc = {
    Text = "Выбор карты из руки"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Нажмите, чтобы выйти"
  },
  CommonID_ClickToView_Desc = {
    Text = "Просмотреть"
  },
  CommonID_Click_Desc = {
    Text = "Кликните, чтобы перейти"
  },
  CommonID_Close_Desc = {
    Text = "Завершить"
  },
  CommonID_ComingSoon_Desc = {
    Text = "Следите за обновлениями"
  },
  CommonID_CommonAttr_Desc = {
    Text = "Общий бонус свойств"
  },
  CommonID_Common_Desc = {
    Text = "Обычный"
  },
  CommonID_ContinuousSound_Desc = {
    Text = "Непрерывное воспроизведение"
  },
  CommonID_CopperAchieve_Desc = {Text = "Медь"},
  CommonID_CountingStart_Desc = {
    Text = "Начинает отсчет времени моего хода"
  },
  CommonID_Custom_Desc = {
    Text = "Пользовательский"
  },
  CommonID_DE_Desc = {
    Text = "Немецкий язык (альфа)"
  },
  CommonID_DPS_Desc = {Text = "Атака"},
  CommonID_DepressionHit_Desc = {
    Text = "Ударная депрессия"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Запретить главный герой навыки"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Запретить ковенант"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Запретить использование Колеса судьбы"
  },
  CommonID_Display_Desc = {Text = "Кадр"},
  CommonID_DropdownList_Desc = {
    Text = "Список с прокруткой"
  },
  CommonID_EN_Desc = {
    Text = "Английский (GPT бета)"
  },
  CommonID_ES_Desc = {
    Text = "Испанский язык (alpha)"
  },
  CommonID_Elite_Desc = {Text = "Элита"},
  CommonID_EmojiType_10_Desc = {
    Text = "Маленький Мисаг"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "Мой ход"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "Мисаг повседневная жизнь"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Радостный Мисаг"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Недовольный Мисаг"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Глава кампусной жизни"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Спокойный день"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Главы о внеклассных занятиях"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Люблю Мисаг"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Каникулы Мисаг"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Мягкий и пушистый Мисаг"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Рождественский Мисаг"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Пряничная вечеринка"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Кампусные курьезы"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Последователь Мисаг"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Интерлюдия Мисаг"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Песня Сая"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "Мори-Мори"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "Суета сует"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Мори-Чиби"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Фазовая связь"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Светящийся Мисаг"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Безумный Мисаг"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Непринуждённый Мисаг"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Мудрый Мисаг"
  },
  CommonID_Enchant_Desc = {Text = "Гриф"},
  CommonID_Entrance_Desc = {
    Text = "Попап Вход"
  },
  CommonID_FALSE_Desc = {Text = "Нет"},
  CommonID_FR_Desc = {
    Text = "Французский (alpha)"
  },
  CommonID_Forged_Desc = {
    Text = "Усиление"
  },
  CommonID_FreeBattlePos_Desc = {
    Text = "Свободное построение"
  },
  CommonID_FullScreen_Desc = {
    Text = "Полный экран"
  },
  CommonID_Gender_Boy_Desc = {Text = "Муж"},
  CommonID_Gender_Girl_Desc = {
    Text = "Женский"
  },
  CommonID_GetLikeLevel_Desc = {
    Text = "Функция"
  },
  CommonID_GmaeVoice_Desc = {
    Text = "Игровая музыка"
  },
  CommonID_GoldAchieve_Desc = {
    Text = "Золото"
  },
  CommonID_Hall_Desc = {Text = "Холл"},
  CommonID_HarvestAdd_Desc = {
    Text = "Родной дом даёт дополнительные награды"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Условие завершения задачи: обладание одним из пробуждающих тел в списке"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Именем Серебряного ключа"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Глупый файл фото"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Вчера, что никогда не исчезнет"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Почтовая марка коллекции"
  },
  CommonID_High_Desc = {
    Text = "Высокий"
  },
  CommonID_Holy_Desc = {
    Text = "Освящение"
  },
  CommonID_ID_Desc = {
    Text = "Индонезийский (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "Итальянский (alpha)"
  },
  CommonID_Image_Desc = {
    Text = "Изображение"
  },
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Намерение монстра - атака и Усиление"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Намерения монстра атака и ослабление"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Намерения монстра атака и ослабление"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Намерения монстра атаки и защиты"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Намерения монстра атака"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Усиление намерений монстра"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Намерения монстра: безумие, не атака"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Намерения монстра крайне безумны"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Намерения монстра нанести последний Удар"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Намерение монстра, безумие"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Усиление намерений монстра"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Усиление намерений монстра"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Ошеломление намерений монстра"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "У монстра намерения: защита и Усиление"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Намерение монстра — защита и ослабление"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Монстр намерен защищаться"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Намерение монстра: ошеломление"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Монстр намерен совершить сильную атаку"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Монстр намерен совершить сильную атаку"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Намерения монстра значительно усилены"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Намерения монстра подвержены сильному ослаблению"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Намерения монстра непонятны"
  },
  CommonID_ItemManagement_Desc = {
    Text = "Предмет"
  },
  CommonID_JP_Desc = {
    Text = "Японский язык (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "Корейский (альфа)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Главный герой навыки"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Забытое наследие"
  },
  CommonID_KeyType_2_Desc = {
    Text = "Царство хаоса"
  },
  CommonID_KeyType_3_Desc = {
    Text = "Царство глубокого моря"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Царство крови и плоти"
  },
  CommonID_KeyType_5_Desc = {
    Text = "Ультра царство"
  },
  CommonID_Key_Desc = {
    Text = "Клавиша"
  },
  CommonID_Language_Desc = {Text = "Язык"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Увеличение макс. уровня"
  },
  CommonID_Low_Desc = {
    Text = "Низкий"
  },
  CommonID_Management_Desc = {
    Text = "Перейти к управлению"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Ударная ярость"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Общий контроль"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Вернуться долга расходов ресурсов"
  },
  CommonID_MessagePush_Desc = {
    Text = "Уведомление о сообщении"
  },
  CommonID_Middle_Desc = {Text = "Центр"},
  CommonID_Modify_Desc = {
    Text = "Нажмите для изменения"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Один малый монстр"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Второстепенный монстр"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "Матушка-дерево"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Усиление повышенного опыта"
  },
  CommonID_Mute_Desc = {
    Text = "Тишина"
  },
  CommonID_NotAwakerMonster_Desc = {
    Text = "Непробуждающее тело Босс"
  },
  CommonID_Open_Desc = {
    Text = "Открыть"
  },
  CommonID_OperationImpossible_Desc = {
    Text = "Игрок не может выполнить действия по разным причинам (недостаточно арифметики, не свой ход, запечатан или оберегом и т.д.) (разыгрывание карты, взрыв безумия)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Время размышления во время моего хода достигло максимального значения (настроено в таблице постоянных значений)"
  },
  CommonID_Orange_Desc = {
    Text = "Золото"
  },
  CommonID_PT_Desc = {
    Text = "Португальский (alpha)"
  },
  CommonID_PVP_Desc = {
    Text = "Фазовая игра"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "Пассивный навык"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "Личное дело"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "Игра начинается, игрок закончил выбирать карты"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Архив Хранителя"
  },
  CommonID_Potency_Desc = {
    Text = "Озарение"
  },
  CommonID_Privacy_Desc = {
    Text = "Конфиденциальность"
  },
  CommonID_Purple_Desc = {
    Text = "Хронопендулум"
  },
  CommonID_RU_Desc = {
    Text = "Русский (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Красный световой Эффект"
  },
  CommonID_Red_Desc = {
    Text = "Проклятие"
  },
  CommonID_Redeem_Desc = {
    Text = "Перейти к обмену"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Диалог между пробудившимися вражескими существами и нашими пробудившимися"
  },
  CommonID_Relic_Desc = {
    Text = "Реликвия"
  },
  CommonID_Repair_Desc = {
    Text = "Перейти к ремонту"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Уменьшение затрат ресурсов"
  },
  CommonID_SUP_Desc = {
    Text = "Поддержка"
  },
  CommonID_SellCard_Desc = {
    Text = "Продавать карту"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "Горячие клавиши"
  },
  CommonID_SilverAchieve_Desc = {
    Text = "Серебро"
  },
  CommonID_Sin_Desc = {Text = "Грех"},
  CommonID_SkillReady_Desc = {
    Text = "В момент, когда шкала безумия полна и может быть нажата для возрождения алиэмиуса"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Улучшение навыка"
  },
  CommonID_Slider_Desc = {
    Text = "Числовой ползунок"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Базовый Уровень слота"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Баланс звука"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Условие завершения задачи: активируйте диалог с указанным коммуникатором"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Выпуск копии увеличен"
  },
  CommonID_Switch_Desc = {
    Text = "Переключатель"
  },
  CommonID_System_Desc = {
    Text = "Система"
  },
  CommonID_TH_Desc = {
    Text = "Тайский (альфа)"
  },
  CommonID_TRUE_Desc = {Text = "Да"},
  CommonID_TR_Desc = {
    Text = "Турецкий (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Традиционный китайский"
  },
  CommonID_T_Desc = {
    Text = "Оборона"
  },
  CommonID_TaskCount_Desc = {Text = "Счет"},
  CommonID_TaskInProgress_Desc = {
    Text = "В процессе"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Темная башня Вэй"
  },
  CommonID_Through1_Desc = {
    Text = "Пассивный навык 1"
  },
  CommonID_Through2_Desc = {
    Text = "Пассивный навык 2"
  },
  CommonID_Tips_Desc = {
    Text = "Подсказка"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "Метка официального перевода"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "Вознесение"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Чрезмерная вспышка безумия"
  },
  CommonID_VN_Desc = {
    Text = "Вьетнамский язык (альфа)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Очень высокий"
  },
  CommonID_VeryLow_Desc = {
    Text = "Очень низкий"
  },
  CommonID_View_Desc = {
    Text = "Перейти и проверить"
  },
  CommonID_Voice_Desc = {Text = "Звук"},
  CommonID_Web_Desc = {
    Text = "Переход на веб-страницу"
  },
  CommonID_White_Desc = {
    Text = "Серебро"
  },
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Звуковые эффекты при потере фокуса окна"
  },
  CommonID_Window_Desc = {Text = "Окно"},
  CommonID_YellowGlow_Desc = {
    Text = "Жёлтый световой Эффект"
  }
})
return Text_CommonID
