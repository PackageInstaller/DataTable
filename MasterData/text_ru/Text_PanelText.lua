__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PanelText = readonly({
  PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content = {
    Text = "Сверхвознесение"
  },
  PanelText_Btn_Block_Window_Text_C_Display_Content = {
    Text = "Показать карту"
  },
  PanelText_Btn_Block_Window_Text_C_Hide_Content = {
    Text = "Скрытая Карта"
  },
  PanelText_Btn_Get_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_Com_RedDot_Text_C_GroupNew_Content = {Text = "Новый"},
  PanelText_Com_RedDot_Text_C_New_Content = {Text = "Новый"},
  PanelText_Com_Text_New_Text_C_New_Content = {Text = "Новый"},
  ["PanelText_GmPanel_Text_C_Battle_Test (1)_Content"] = {Text = "Бой 2.0"},
  PanelText_GmPanel_Text_C_Battle_Test2_Content = {
    Text = "Игрок против игрока бой"
  },
  PanelText_GmPanel_Text_C_Battle_Test_Content = {
    Text = "PvP матч"
  },
  PanelText_GmPanel_Text_C_Gb_Content = {
    Text = "Закрыть"
  },
  PanelText_GmPanel_Text_C_Hm_Content = {
    Text = "Переключить эффекты кадра на высокий/низкий"
  },
  PanelText_GmPanel_Text_C_Placeholder_Content = {
    Text = "Введите поиск"
  },
  PanelText_GmPanel_Text_C_Xy_Content = {
    Text = "Тестовый протокол"
  },
  PanelText_GmPanel_Text_C_Yc_Content = {
    Text = "Скрыть панель GM"
  },
  PanelText_GmParamEquipPanel_Text_C_Fs_Content = {
    Text = "Отправить"
  },
  PanelText_GmParamEquipPanel_Text_C_Tc_Content = {Text = "Выйти"},
  PanelText_GmParamPanel_Text_C_Fs_Content = {
    Text = "Отправить"
  },
  PanelText_GmParamPanel_Text_C_Param_Content = {
    Text = "Конфигурация"
  },
  PanelText_GmParamPanel_Text_C_Tc_Content = {Text = "Выйти"},
  PanelText_Icon_Common_Text_C_New_Content = {Text = "Новый"},
  PanelText_Icon_Common_Text_C_NoEquip_Content = {
    Text = "Не может быть экипировано"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content = {
    Text = "Охлаждение"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content = {
    Text = "Вознесение"
  },
  PanelText_Panel_Announcement_Text_C_Panel_Title_Content = {
    Text = "Объявление"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content = {
    Text = "Намерения монстра"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Story_Content = {
    Text = "Монстры история"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Canel_Content = {
    Text = "Отмена"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Canel_Content = {
    Text = "Отмена"
  },
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content = {Text = "Вызов"},
  PanelText_Panel_Gm_PVP_Text_C_Canel_Content = {
    Text = "Отмена"
  },
  PanelText_Panel_Gm_PVP_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_Popup_Gm_Effect_Side_Text_Content = {
    Text = "Эффект редактирования"
  },
  PanelText_Popup_Gm_Effect_Text_Cancel_Content = {
    Text = "Закрыть"
  },
  PanelText_Popup_Gm_Effect_Text_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_RedPoint_New_Text_C_New_Content = {Text = "Новый"},
  PanelText_Simple_List_Panel_Text_Content = {
    Text = "Закрыть"
  },
  PanelText_Text_C_Activate_Text_C_Activate_Content = {
    Text = "Стимулирующие материалы"
  },
  PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content = {
    Text = "Выбор контактного лица"
  },
  PanelText_UI_Address_Panel_Main_Text_C_Title_Content = {
    Text = "Коммуникатор"
  },
  PanelText_UI_Address_Panel_Main_Text_Time_Content = {
    Text = "Выберите из списка"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content = {
    Text = "Пока нет новых сообщений"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Title_Content = {
    Text = "Коммуникатор"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Achievement_Content = {
    Text = "Разложение пакта"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Alchemy_Content = {
    Text = "Составление материалов"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content = {
    Text = "Замена материалов"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Recast_Content = {
    Text = "Мистическая переиздание"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveItem_Content = {
    Text = "Разложение материалов"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content = {
    Text = "Разборка колеса судьбы"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_Title_Content = {
    Text = "Алхимия"
  },
  PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content = {
    Text = "Введите Лечение"
  },
  PanelText_UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save_Content = {
    Text = "Удержание"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content = {
    Text = "Замена"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content = {
    Text = "Скоро будет заменено"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content = {
    Text = "Нет предметов, доступных для разложения"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content = {
    Text = "Материалы, необходимые для замены"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content = {
    Text = "Выделить всё"
  },
  PanelText_UI_Alchemy_Popup_Recast_Text_C_Name_Content = {
    Text = "Переиздание"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content = {
    Text = "Выделить всё"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content = {
    Text = "Усилено до текущего предельного уровня"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum_Content = {
    Text = "Количество"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content = {
    Text = "Пока нет связанных мистерий"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Правильная позиция достигла максимума"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content = {
    Text = "Выберите предмет, который нужно разложить"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content = {
    Text = "Разбивка для получения"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content = {
    Text = "Выбрано"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content = {Text = "Отбор"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content = {Text = "Набор"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2_Content = {
    Text = "Положение"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content = {
    Text = "Основной атрибут"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content = {
    Text = "Дополнительные характеристики"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content = {
    Text = "Нажмите, чтобы выбрать"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content = {
    Text = "Выделить всё"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content = {
    Text = "Усилено до текущего предельного уровня"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum_Content = {
    Text = "Количество"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content = {
    Text = "Пока нет связанных мистерий"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content = {
    Text = "Позиции стекинга заполнены"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content = {
    Text = "Выберите предмет, который нужно разложить"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content = {
    Text = "Разбивка для получения"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content = {
    Text = "Выбрано"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content = {
    Text = "Выделить всё"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content = {
    Text = "Усилено до текущего предельного уровня"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum_Content = {
    Text = "Количество"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Правильная позиция достигла максимума"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content = {
    Text = "Выберите предмет, который нужно разложить"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content = {
    Text = "Разбивка для получения"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content = {
    Text = "Выбрано"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content = {
    Text = "Нет связанных судьбоносных колес"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content = {
    Text = "Выделить всё"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content = {
    Text = "Усилено до текущего предельного уровня"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum_Content = {
    Text = "Количество"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content = {
    Text = "Позиции стекинга заполнены"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content = {
    Text = "Выберите предмет, который нужно разложить"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content = {
    Text = "Разбивка для получения"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content = {
    Text = "Выбрано"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content = {
    Text = "Нет связанных судьбоносных колес"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Name_Content = {
    Text = "Разложение"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content = {
    Text = "Выделить всё"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Need_Content = {Text = "Нужно"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content = {
    Text = "Пожалуйста, выберите материалы для разложения слева"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content = {
    Text = "Будет разложено"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content = {
    Text = "Количество разбиений"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content = {
    Text = "Пока нет материалов, которые можно разложить"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content = {
    Text = "Разложение даёт получить материалы"
  },
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Have_Content = {Text = "Есть"},
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content = {
    Text = "Нулевой"
  },
  PanelText_UI_Announcement_Item_Title_Text_New_Info_Content = {Text = "Новый"},
  PanelText_UI_Awaker_Button_Addition_Text_C_Tips_Content = {Text = "Бонус"},
  PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Attributes_Title_Content = {
    Text = "Атрибуты"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content = {
    Text = "Командная конфигурация"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content = {
    Text = "Уровень"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_High_Content = {
    Text = "Показать текущий"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Content = {
    Text = "Связать"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Title_Content = {
    Text = "Склонность"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Name1_Content = {Text = "Имя"},
  PanelText_UI_Awaker_Item_Info_Text_C_Name2_Content = {
    Text = "Стиль ."
  },
  PanelText_UI_Awaker_Item_Info_Text_C_No_Content = {
    Text = "Не получено"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content = {
    Text = "Предварительный просмотр 60 уровня"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content = {
    Text = "Углубление гнозиса"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Content = {Text = "Счет"},
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content = {
    Text = "Боевая Огромная Огромная Огромная Огромная сила"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Title_Content = {Text = "Реalm"},
  PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content = {
    Text = "Подробная информация"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content = {
    Text = "Духи уже заполнены"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content = {
    Text = "Уже пробуждён"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Already_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Disable_Content = {
    Text = "Не заменяемый"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Full_Content = {
    Text = "Углубление личности заполнено"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click_Content = {
    Text = "Обратное пожирание"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Content = {
    Text = "Обратное пожирание"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content = {
    Text = "Озарение"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content = {
    Text = "Озарение"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content = {Text = "Архив"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content = {Text = "Архив"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Click_Content = {
    Text = "Ковенант"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Content = {
    Text = "Ковенант"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Click_Content = {
    Text = "Умение"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Content = {
    Text = "Умение"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content = {
    Text = "Состояние"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content = {
    Text = "Состояние"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content = {
    Text = "Талант"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content = {
    Text = "Талант"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content = {
    Text = "Разблокировка исходной формы потребует следующие предметы, подтвердить ли?"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_1_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content = {
    Text = "Подтвердить разблокировку источника"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Click_Content = {Text = "Общий"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Content = {Text = "Общий"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content = {
    Text = "Режим темы"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content = {
    Text = "Режим темы"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content = {
    Text = "Разблокировать сверхлимитную вспышку безумия"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content = {
    Text = "Разблокировано"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content = {
    Text = "Разблокировано в этот раз"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content = {
    Text = "Повысить предварительный просмотр"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content = {
    Text = "Активационные материалы"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content = {
    Text = "Разблокировано"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content = {
    Text = "Режим расследования"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content = {
    Text = "Режим расследования"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content = {
    Text = "Разблокировано в этот раз"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content = {
    Text = "Разблокировано"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content = {
    Text = "Вернуться генезиса"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content = {
    Text = "Стопка сброса развития"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content = {
    Text = "Вернуться долга предварительного просмотра"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content = {
    Text = "Вернуться долга предварительного просмотра"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content = {
    Text = "Вернуться долга предварительного просмотра"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content = {
    Text = "«После возврата воспоминаний развития или возврата просветления невозможно сделать \"Вернуться к черному бассейну\"»"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content = {
    Text = "Режим темы"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content = {
    Text = "Режим темы"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Click_Content = {
    Text = "Специальный"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Content = {
    Text = "Специальный"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content = {
    Text = "Режим расследования"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content = {
    Text = "Режим расследования"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content = {
    Text = "Вы достигли максимального уровня"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content = {
    Text = "Показать текущий"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content = {
    Text = "Уровень пробуждающего тела недостаточен"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content = {
    Text = "Вознесение"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Material_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content = {
    Text = "Максимальный Уровень предварительного просмотра"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content = {
    Text = "Долгое нажатие на карту позволяет увеличить ее для просмотра"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content = {
    Text = "Вознесение"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Tale_Content = {
    Text = "История"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Text_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content = {
    Text = "Вознесение"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Material_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Tale_Content = {
    Text = "История"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Text_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Material_Content = {
    Text = "Потребление материалов"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content = {
    Text = "Автоматическое вложение"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content = {
    Text = "Улучшение"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content = {
    Text = "Опция два"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content = {
    Text = "Опция три"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content = {
    Text = "Условия повышения"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Material_Content = {
    Text = "Материала для повышения ранга"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content = {
    Text = "Доступен новый навык для активации"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content = {
    Text = "Условия повышения<WordSize20:(Выберите один из вариантов)>"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content = {
    Text = "Подробная информация"
  },
  PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content = {
    Text = "Выберите снаряжение мистерии"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Fast_Content = {
    Text = "Быстро положить"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content = {
    Text = "Улучшение"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content = {
    Text = "Транскрипция"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content = {
    Text = "Улучшение"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content = {
    Text = "Детали пакта"
  },
  ["PanelText_UI_Awaker_Item_Voice_Text_C_ Voice_Content"] = {
    Text = "Озвучено"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content = {Text = "Битва"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content = {Text = "Битва"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Normal_Content = {
    Text = "Повседневная жизнь"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Select_Content = {
    Text = "Повседневная жизнь"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content = {
    Text = "Вернуться к предварительному просмотру"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content = {
    Text = "Вернуться генезиса"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content = {
    Text = "Стековый откат"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Cost_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content = {
    Text = "Текущий Эффект"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Expend_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Fast_Content = {
    Text = "Быстро положить"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content = {
    Text = "Максимальный Уровень"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content = {
    Text = "Стекинг позиций после"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content = {
    Text = "Стекинг позиций после"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content = {
    Text = "<Blue:следующий Уровень эффекта>"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content = {
    Text = "Вернуться к предварительному просмотру"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content = {
    Text = "Сложенные позиции судьбы"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content = {
    Text = "Наложение"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content = {
    Text = "Выбор материала для наложения позиций"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content = {
    Text = "Достигнут предельный Уровень позиций стека"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content = {
    Text = "После использования \"стекового отката\" невозможно провести \"возвращение генезиса\"."
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content = {
    Text = "Детали Колеса Судьбы"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click_Content = {
    Text = "Обратное пожирание"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Content = {
    Text = "Обратное пожирание"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough_Content = {
    Text = "Воспитывать"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content = {
    Text = "Усиление"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content = {
    Text = "Снаряжение средней части"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast_Content = {
    Text = "Быстрое размещение"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content = {
    Text = "Наложение"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content = {
    Text = "Наложение"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content = {
    Text = "Наложение"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Message_Content = {
    Text = "Информация о Пробуждённом"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Story_Content = {
    Text = "История"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content = {
    Text = "Базовая информация"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content = {
    Text = "Обычная форма"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content = {
    Text = "Обычная форма"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content = {
    Text = "Обычная форма"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content = {
    Text = "Исходная форма"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content = {
    Text = "Исходная форма"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content = {
    Text = "Исходная форма"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content = {
    Text = "Текущая часть тела: нет доступных мистерий"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content = {
    Text = "Усиление"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content = {
    Text = "Мистическое слияние"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content = {
    Text = "Отвязать всё"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content = {
    Text = "Сравнение"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info1_Content = {
    Text = "Понять судьбу"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info2_Content = {
    Text = "Колесо судьбы"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info3_Content = {
    Text = "Колесо судьбы"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content = {
    Text = "Выберите Колесо Судьбы снаряжения"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content = {
    Text = "Выберите Колесо Судьбы снаряжения"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content = {
    Text = "Усиление пробуждения\nРазблокировать второе колесо судьбы"
  },
  PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content = {
    Text = "Свойства подробности"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content = {
    Text = "Просмотреть подробности"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content = {
    Text = "Нет предмета для отката"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content = {
    Text = "Выбор включения цели отката"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content = {
    Text = "Постоянный пробудивший"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content = {
    Text = "Специальный Пробудивший"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content = {
    Text = "Ковенанты, экипированные другими Пробуждёнными или находящиеся в Отряде/схеме/Поддержке, автоматически снимаются"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content = {
    Text = "Подтвердить Слияние следующего Ковенанта?"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content = {
    Text = "Подтверждение соединения"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content = {
    Text = "Недостаточно материалов для выполнения запроса. Использовать следующие материалы для补足?"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content = {
    Text = "Подсказка заполнения"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content = {
    Text = "Следующий предмет срок действия истек, Невозможно использовать"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content = {
    Text = "Предмет просрочен"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content = {
    Text = "Нет доступных материалов"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content = {
    Text = "Выбор мистерии"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Content_Content = {
    Text = "Повысить до максимума"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content = {
    Text = "Уровень повышается"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content = {
    Text = "Материалы для улучшения отсутствуют"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Coin_Count_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Popup_Potential_Text_C_Material_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content = {
    Text = "Углубление гнозиса"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content = {
    Text = "Увеличение макс. уровня"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content = {
    Text = "После отката можно получить следующие материалы"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content = {
    Text = "Вернуться долга предварительного просмотра"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content = {
    Text = "Предельный Уровень"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content = {
    Text = "Навык улучшен"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content = {
    Text = "Условия разблокировки"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content = {
    Text = "Показать текущий"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content = {
    Text = "Следующий Уровень"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content = {
    Text = "Предварительный просмотр максимального уровня"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_Require_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content = {
    Text = "Предпросмотр материала для повышения ранга"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content = {
    Text = "Нажмите на пустое место, чтобы закрыть"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content = {
    Text = "Доступен новый навык для активации"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed_Content = {
    Text = "Успешное повышение уровня"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content = {
    Text = "Требование синхронизации"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content = {
    Text = "Уровневые награды"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content = {
    Text = "Награда получено"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Tips_Content = {
    Text = "Просмотреть"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content = {
    Text = "Связать"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content = {
    Text = "Архив разблокирован"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content = {
    Text = "Правила"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content = {
    Text = "Увеличение макс. уровня"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content = {
    Text = "Увеличение макс. уровня"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content = {
    Text = "Сверхвознесение"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content = {
    Text = "Абсолютная аксиома"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content = {
    Text = "Не активировано"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content = {
    Text = "Не активировано"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content = {
    Text = "Разблокировано"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Title_Content = {
    Text = "Углубление личности"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content = {
    Text = "Повышение характеристик"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content = {
    Text = "Разблокировано в этот раз"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Material_Content = {
    Text = "Материала для повышения ранга"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content = {
    Text = "Повышение награды"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content = {
    Text = "Превращение предварительного просмотра"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content = {
    Text = "Награда получено"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content = {
    Text = "После Слияния основной атрибут Ковенанта дополнительно повышается на 50%！"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content = {
    Text = "Слияние Ковенанта"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content = {
    Text = "Нет активных Наборных эффектов"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content = {
    Text = "Правила"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content = {
    Text = "Наборный Эффект"
  },
  PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content = {
    Text = "Снаряжено"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content = {
    Text = "Авто-перенос"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content = {
    Text = "Нажмите для транскрипции, чтобы получить новые дополнительные характеристики"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content = {
    Text = "Исходное дополнительное свойство"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content = {
    Text = "Новое дополнительное свойство"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content = {
    Text = "Транскрипция"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content = {
    Text = "Заменить"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content = {
    Text = "Нет свойств"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content = {
    Text = "Пропустить анимацию"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Text_Content = {Text = "Нужно"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content = {
    Text = "Пояснение к транскрипции"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate_Content = {
    Text = "Материалы SSR и ниже"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut_Content = {
    Text = "Быстро поместить"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content = {
    Text = "Вы достигли максимального уровня"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content = {
    Text = "У вас пока нет неэкипированных судеб"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content = {
    Text = "Выберите снаряжение мистерии"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content = {
    Text = "Нет активных Наборных эффектов"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content = {
    Text = "Наборный Эффект"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content = {
    Text = "Сравнение"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content = {
    Text = "Выберите снаряжение мистерии"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content = {
    Text = "Текущая часть тела: нет доступных мистерий"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content = {
    Text = "Выберите снаряжение мистерии"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content = {
    Text = "Наборный Эффект"
  },
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content = {
    Text = "Пока не экипировано ни одной мистерии"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete_Content = {
    Text = "Потребляемые материалы"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Content = {
    Text = "Быстро положить"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content = {
    Text = "Повысить на 1 Уровень"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content = {
    Text = "Повысить на 1 Уровень"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content = {
    Text = "Усиление"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content = {
    Text = "Повысить до максимального уровня"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content = {
    Text = "Повысить до максимального уровня"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content = {
    Text = "Улучшение"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content = {
    Text = "Уровень"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content = {
    Text = "Авто-выбор"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content = {
    Text = "Отвязать Ковенант"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket_Content = {
    Text = "Требуется Ковенант"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content = {
    Text = "Отвязать Ковенант"
  },
  PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content = {
    Text = "Скрыть"
  },
  PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content = {
    Text = "Суффикс объяснение"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content = {Text = "Обзор"},
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content = {
    Text = "Талант пробуждающего тела"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content = {Text = "Тип"},
  PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content = {
    Text = "Усиление успешно"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content = {
    Text = "Нажмите на пустое место, чтобы закрыть"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content = {
    Text = "Стекинг позиций успешен"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content = {
    Text = "·Выбрать пробуждающее тело"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content = {
    Text = "·Предпросмотр усиления"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Skill_Content = {
    Text = "Умение"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content = {
    Text = "Пробуждающее тело Усиление"
  },
  PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content = {
    Text = "Получено"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content = {
    Text = "Аватар и Эмоция"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content = {
    Text = "Подробный просмотр"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content = {
    Text = "Источник"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content = {
    Text = "Оставшееся время действия:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Аватар и Эмоция"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Подробный просмотр"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Эффект ключевого приказа"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Source_Content = {
    Text = "Получить Генезис"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Time_Content = {
    Text = "Оставшийся срок действия"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content = {
    Text = "Базовая атака"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content = {
    Text = "Базовая защита"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content = {
    Text = "Основное телосложение"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content = {
    Text = "Духи уже заполнены"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content = {
    Text = "Выбор фрагментов пробуждающего тела"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content = {
    Text = "Просмотреть подробности"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content = {
    Text = "Получить"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Emoji_Content = {
    Text = "Эмоция"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content = {
    Text = "Аватар"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content = {
    Text = "Все облики получены"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content = {
    Text = "Вероятностный просмотр"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content = {
    Text = "Внешний вид предварительного просмотра"
  },
  PanelText_UI_Bag_Panel_Main_Text_AmountName_Content = {
    Text = "Количество"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content = {
    Text = "Порядок"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content = {
    Text = "Усилено до текущего предельного уровня"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_None2_Content = {
    Text = "Инвентарь пуст"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content = {
    Text = "Позиции стекинга заполнены"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content = {
    Text = "Замена"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Resolve_Content = {
    Text = "Разложение"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Synthesis_Content = {
    Text = "Синтезировать"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_recast_Content = {
    Text = "Перелить"
  },
  PanelText_UI_Bag_Panel_Main_Text_Intensify_Content = {
    Text = "Усиление"
  },
  PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content = {
    Text = "Наложение"
  },
  PanelText_UI_Bag_Panel_Main_Text_Title_Content = {
    Text = "Инвентарь"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content = {
    Text = "Получить"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Emoji_Content = {
    Text = "Эмоция"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content = {
    Text = "Аватар"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content = {
    Text = "Нет данных"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content = {
    Text = "Внешний вид предварительного просмотра"
  },
  PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content = {
    Text = "Специальная атака пробудивших"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content = {
    Text = "Показать карту"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content = {
    Text = "Скрытая Карта"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content = {Text = "Конец"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content = {
    Text = "Пространство недостаточно"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content = {Text = "Конец"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content = {
    Text = "Настройки"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content = {Text = "Конец"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content = {
    Text = "Общий Урон"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content = {
    Text = "Пространство недостаточно"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content = {
    Text = "Охлаждение"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content = {
    Text = "Охлаждение, можно использовать снова только в следующем ходу"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content = {
    Text = "Сверхвознесение"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content = {
    Text = "Охлаждение"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content = {
    Text = "Охлаждение, можно использовать снова только в следующем ходу"
  },
  PanelText_UI_Battle_Popup_Anger_Text_Title_Content = {
    Text = "Вознесение"
  },
  PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content = {
    Text = "Погоня"
  },
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content = {
    Text = "Выбери группу карт"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content = {
    Text = "Опасность предупреждение"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Hang_Content = {
    Text = "Бой начинается"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content = {
    Text = "Наивысшая тревога"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content = {
    Text = "Нажмите, чтобы продолжить"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content = {
    Text = "Бой проигран"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_1_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content = {
    Text = "Багровая плавильня"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School_Content = {Text = "Страж"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content = {
    Text = "Информация о команде"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content = {
    Text = "Аварийные материалы"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content = {
    Text = "Ключесвет"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content = {
    Text = "Освободить"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content = {
    Text = "Освободить"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content = {
    Text = "Освободить"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content = {
    Text = "Пожалуйста, сделайте выбор команды"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content = {
    Text = "Возвышение"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content = {
    Text = "Составной Зов"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Hang_Content = {
    Text = "Бой начинается"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content = {
    Text = "Бой начинается"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content = {
    Text = "Провести обмен?"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content = {
    Text = "Резервуар экстренного гнозиса исчерпан, вы хотите потратить"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Cost_Content = {
    Text = "расход"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content = {
    Text = "(После обмена будет немедленно поглощено и воскреснет, при отходе возратится экстренное тело гнозиса)"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Cancel_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content = {
    Text = "Подтверждение воскрешения"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content = {
    Text = "Суффикс объяснение"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content = {
    Text = "Возвышение"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag_Content = {
    Text = "Углубление личности"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content = {
    Text = "Возвышение"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content = {
    Text = "Очаг ярости"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content = {
    Text = "Свойства подробности"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Secret_Content = {
    Text = "Ковенант"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content = {
    Text = "Вознесение"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content = {
    Text = "Талант"
  },
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content = {
    Text = "Возвышение"
  },
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket_Content = {
    Text = "Ковенант"
  },
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content = {
    Text = "Действия врага"
  },
  PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content = {
    Text = "Наш ход"
  },
  PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content = {
    Text = "Выбор пробуждающее тело"
  },
  PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content = {
    Text = "Победа"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content = {
    Text = "Текущая команда"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Defense_Content = {
    Text = "защита"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content = {
    Text = "Недоступно для выбора"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content = {
    Text = "Недоступно для выбора"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content = {Text = "Битва"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content = {
    Text = "Сделайте выбор позы щупальцев"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content = {
    Text = "Обратный ход времени позволяет откатить бой к предыдущему ходу"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content = {
    Text = "Обратный ход времени"
  },
  PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content = {
    Text = "Особенности врага"
  },
  PanelText_UI_Card_Panel_Discard_Text_C_Title_Content = {
    Text = "Колода карт на руке"
  },
  PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content = {
    Text = "Накопительные награды"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_En_Content = {
    Text = "Может получить"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Cancel_Content = {Text = "Выход"},
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content = {
    Text = "Необходимо расследовать"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content = {
    Text = "Рекомендуется завершить следующие этапы расследования"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Screening_Content = {
    Text = "Не напоминать сегодня"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Bright_Content = {Text = "Гриф"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Content = {Text = "Гриф"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Begone_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Creation_Content = {
    Text = "Реликвия"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkactivity_Content = {Text = "Гриф"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkgame_Content = {
    Text = "Реликвия"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content = {
    Text = "Нет клеймов"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Bright_Content = {
    Text = "Реликвия"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Content = {
    Text = "Реликвия"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Mail_Content = {
    Text = "Нет реликвий"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_No_Content = {
    Text = "Нет гравировок"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content = {
    Text = "Нет созданий"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Walk_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_mail_Content = {
    Text = "Входящие пусты"
  },
  PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content = {
    Text = "Уровневые достижения"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content = {
    Text = "Превью противника"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content = {
    Text = "Требования к команде"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content = {
    Text = "Рекомендуемый Уровень"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content = {
    Text = "Рекомендуемая область"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Monster_Content = {
    Text = "монстр"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content = {
    Text = "Запись"
  },
  PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Simple_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content = {
    Text = "Кошмар"
  },
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content = {
    Text = "Просто"
  },
  PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content = {
    Text = "Следите за обновлениями"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content = {
    Text = "Завершить"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content = {
    Text = "Следите за обновлениями"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content = {
    Text = "Завершить"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Chaoter_Content = {
    Text = "Сонный пейзаж"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Chaoter_Content = {
    Text = "Сонный пейзаж"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content = {
    Text = "Состояние"
  },
  PanelText_UI_Chapter_Item_Special_01_Text_C_Chaoter_Content = {
    Text = "Сонный пейзаж"
  },
  PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content = {
    Text = "Все условия для получения награды достигнуто"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content = {
    Text = "Достигнуто"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content = {
    Text = "Нет оперативных записей"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Simple_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content = {
    Text = "21.12.2023, 05:00 обновление. Скоро в игре"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content = {
    Text = "Расследование"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content = {
    Text = "Уровневые достижения"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content = {
    Text = "Оценка уровня"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content = {
    Text = "Расследование прогрессирует"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_01_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Now_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content = {
    Text = "Ограниченное по времени событие"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content = {
    Text = "Уровневые достижения"
  },
  PanelText_UI_Chapter_Popup_Achievement_Text_C_Title_Content = {
    Text = "Достижение"
  },
  PanelText_UI_Chapter_Popup_Chapter_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content = {
    Text = "Детали врага"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Effect_Content = {
    Text = "Эффект"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Story_Content = {
    Text = "История"
  },
  PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content = {
    Text = "Оценка расследования"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Simple_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Ограниченное по времени событие"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Review_Content = {
    Text = "Пролог"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Simple_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Ограниченное по времени событие"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content = {
    Text = "Не достигнуты условия разблокировки"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content = {
    Text = "Войти в Сюжет"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content = {
    Text = "Безумие размножения пока не разблокировано"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content = {
    Text = "С продолжающимся \"Плотские желания\" пробуждающие тела подверглись воздействию загадочной силы и впали в состояние \"Репродуктивного безумия\"... Прошу всех Хранителей тайн быть осторожными!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content = {
    Text = "«Акция Волна желания» Время ограничено! Можно игнорировать требования Аффинитета и разблокировать событие, используя всего одну «Точку начала реальности»!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content = {
    Text = "Вечеринка Приглашение"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Collection_History_Details_Text_C_Lock_Content = {
    Text = "Изображение временно не получено"
  },
  PanelText_UI_Collection_History_Details_Text_Title_Content = {
    Text = "Запись"
  },
  PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content = {
    Text = "Существительное..."
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content = {
    Text = "Сбросить фоновую музыку"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content = {
    Text = "Фонограф"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content = {
    Text = "Установить как фоновую музыку"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Label_Content = {
    Text = "Фонограф"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Mail_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content = {
    Text = "Разблокировать"
  },
  PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content = {
    Text = "Разблокировать"
  },
  PanelText_UI_Collection_Panel_EquipDetail_Text_C_Title_Content = {
    Text = "История"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_None2_Content = {
    Text = "Пока нет материалов"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_None_Content = {
    Text = "Нет связанных избранных"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content = {
    Text = "Существительное..."
  },
  PanelText_UI_Collection_Panel_History_Text_C_Label_Content = {
    Text = "Хроника"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Mail_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content = {
    Text = "Изменить фон входа"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Creation_Content = {
    Text = "Реликвия"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Event_Content = {
    Text = "Событие"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Image_Content = {
    Text = "Изображение"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Music_Content = {
    Text = "Фонограф"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Role_Content = {Text = "Роль"},
  PanelText_UI_Collection_Panel_Main_Text_C_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Trinket_Content = {
    Text = "Ковенант"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_World_Content = {
    Text = "Мир гравия"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Panel_Organize_Text_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Title_Content = {
    Text = "История"
  },
  PanelText_UI_Collection_Panel_Relic_Text_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content = {
    Text = "Отобразить пробуждающее тело"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content = {
    Text = "Скачать оригинальное изображение"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content = {
    Text = "После настройки этого изображения в качестве фона спальни, иллюстрации гостей будут скрыты"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content = {
    Text = "Скрыть пробуждающее тело"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_High_Content = {
    Text = "Сбросить фон общежития"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content = {
    Text = "Установить как фон для комнаты отдыха"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Save_Content = {
    Text = "Удержание"
  },
  PanelText_UI_Collection_Panel_Unlock_Text_C_Cost_Content = {
    Text = "расход"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content = {
    Text = "Хроника"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content = {
    Text = "Запретный канон наносных отложений"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Label_Content = {
    Text = "Мир гравия"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Organize_Content = {
    Text = "Организованная Огромная Огромная Огромная Огромная сила"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Title_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Collection_Panel_World_Text_Progress_Content = {
    Text = "Прогресс сбора"
  },
  PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content = {
    Text = "Повышение уровня синхронизации пробуждающего тела"
  },
  PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Across_Content = {
    Text = "Получите за первый раз поделившись"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Share_Content = {
    Text = "Получите за первый раз поделившись"
  },
  PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content = {
    Text = "Активировать талант"
  },
  PanelText_UI_Common_Group_Coin_Text_C_Text_Content = {Text = "Нужно"},
  PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Аватар и Эмоция"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Подробный просмотр"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Close_Content = {
    Text = "Свернуть"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content = {
    Text = "Снаряжено"
  },
  PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Эффект ключевого приказа"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Source_Content = {
    Text = "Получить Генезис"
  },
  PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content = {
    Text = "Рекомендовать"
  },
  PanelText_UI_Common_Item_Tip_Bg_Text_C_Name_Content = {
    Text = "Сортировка"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Dispatch_Content = {
    Text = "Диспетчеризации"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content = {
    Text = "Срок действия истек"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content = {
    Text = "Не может быть экипировано"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NotActive_Content = {
    Text = "Не вступило в силу"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content = {
    Text = "Достигнут лимит"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Using_Content = {
    Text = "Использование"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content = {
    Text = "Позиции заполнены"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content = {
    Text = "Двойной"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content = {
    Text = "Дополнительно"
  },
  PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_DrawCard_Content = {
    Text = "Стопка добора"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content = {
    Text = "Текущий Стопка добора пуста"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content = {
    Text = "Нет карты"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Title_Content = {
    Text = "Подтверждение использования предмета"
  },
  PanelText_UI_Common_Popup_Tip_01_Text_C_Screening_Content = {
    Text = "Больше не показывать сегодня"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_Screening_Content = {
    Text = "Больше не показывать сегодня"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content = {
    Text = "Текущее количество купонов"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_Screening_Content = {
    Text = "Больше не показывать сегодня"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content = {
    Text = "<WhiteQuality:нажмите на пустое место, чтобы закрыть>"
  },
  PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content = {
    Text = "Нажмите на пустое место, чтобы закрыть"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content = {
    Text = "После изменения имени, в течение 72 часов нельзя вносить изменения снова"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameCancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content = {
    Text = "Введите Ваше имя"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Title_Content = {
    Text = "Изменить название"
  },
  PanelText_UI_Common_Popup_Tips_6_Text_null_Content = {
    Text = "(повреждённый)"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Material_Content = {
    Text = "Материала для повышения ранга"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content = {
    Text = "Повышение награды"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content = {
    Text = "Превращение предварительного просмотра"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Day_Content = {
    Text = "Солнце"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Month_Content = {Text = "Луна"},
  PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content = {
    Text = "Свайпните вверх или вниз, чтобы просмотреть больше наград"
  },
  PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content = {
    Text = "Перейти к оценке"
  },
  PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content = {
    Text = "Особая благодарность"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content = {
    Text = "Уважаемым местным волонтерам:"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Name_Content = {
    Text = "Добровольцы по локализации"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content = {
    Text = "Комитет университета митхага"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content = {
    Text = "Глубокая благодарность"
  },
  PanelText_UI_Community_ThanksLetter_Text_Prefix_Content = {
    Text = "Вы с тонким чувством языка и любовью к играм превращаете грубый машинный перевод в живой текст. Именно эта бескорыстная страсть позволяет хранителям тайн по всему миру наслаждаться оригинальным «Забвением накануне».\n Университет Мисаг искренне благодарит следующих хранителей тайн за их выдающийся вклад:"
  },
  PanelText_UI_Community_ThanksLetter_Text_Suffix_Content = {
    Text = "Пусть Cеребряный ключ ведет нас."
  },
  PanelText_UI_Community_ThanksLetter_Text_Title_Content = {
    Text = "Особая благодарность"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content = {
    Text = "Архивировано"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content = {
    Text = "Рекомендуемый порядок отражает лишь рекомендуемый порядок чтения и не означает строгой хронологической последовательности."
  },
  PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content = {
    Text = "Пока нет обучения этого типа"
  },
  PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content = {
    Text = "Поиск обучения..."
  },
  PanelText_UI_Course_Panel_Text_Title_Content = {
    Text = "Обучение"
  },
  PanelText_UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout_Content = {
    Text = "Распродано"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content = {
    Text = "Уровневые достижения"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content = {
    Text = "Рейтинг звездами"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout_Content = {
    Text = "Распродано"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content = {
    Text = "Проклятое пространство"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout_Content = {
    Text = "Распродано"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content = {
    Text = "Расход"
  },
  PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Dbgcopy_Panel_RelicPreview_Text_Name_Content = {
    Text = "Вернуться долга"
  },
  PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content = {
    Text = "Усиление создания"
  },
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content = {Text = "Выбор"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content = {
    Text = "Отказаться"
  },
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content = {
    Text = "Показать событие"
  },
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content = {
    Text = "Скрытое событие"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content = {
    Text = "Пожалуйста, обратите внимание, Страж, различные уровневые главы приносят разные особенности окружения и начальное творение."
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content = {
    Text = "Описание эффекта уровневой главы"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content = {
    Text = "Заменить персонажа"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content = {
    Text = "Текущие роли в команде"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content = {
    Text = "Выбор замены персонажа"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Suppress_Content = {
    Text = "Кровотечение"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content = {
    Text = "Описание эффекта \"Р-прилив\""
  },
  PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content = {
    Text = "Расследование началось"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content = {
    Text = "Начать тренировку"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content = {
    Text = "Награда +100 %"
  },
  PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content = {
    Text = "Текущее прохождение"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content = {
    Text = "Дополнительное прохождение"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Extra_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content = {
    Text = "Вызов не завершён"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content = {
    Text = "Нет состава"
  },
  PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_All_Content = {Text = "Всё"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content = {
    Text = "Выход на бой"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content = {
    Text = "Статистика битвы"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content = {
    Text = "Наносит Урон"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content = {
    Text = "Причиняет лечение"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content = {
    Text = "Нет данных"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content = {
    Text = "Нет данных"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content = {
    Text = "Статистика ходов"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content = {
    Text = "Создание щита"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content = {
    Text = "Уровень глубокого погружения"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content = {
    Text = "Наивысший счёт за этот сезон"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank_Content = {
    Text = "Рейтинговая таблица"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content = {
    Text = "Результаты недели"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content = {
    Text = "Магазин обмена"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content = {
    Text = "Титул уровня расследования"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content = {
    Text = "Рекорд глубоководного погружения"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content = {
    Text = "Фантазийное Вдаль от берегов"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content = {
    Text = "Наивысший счёт за этот сезон"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content = {
    Text = "Результаты недели"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content = {
    Text = "Результаты недели"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content = {
    Text = "Рекорд глубоководного погружения"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content = {
    Text = "Магазин обмена"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content = {
    Text = "Титул уровня расследования"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content = {
    Text = "Статистика оценок"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content = {
    Text = "Расследование успешно"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_High_Content = {
    Text = "Новая высота!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content = {
    Text = "После улучшения способностей пробуждающего тела возвращайтесь бросить вызов сильному противнику!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content = {
    Text = "Общая оценка"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content = {
    Text = "(Общая оценка равна следующей сумме, умноженной на 3)"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content = {
    Text = "Награда за прохождение"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content = {
    Text = "Наивысший рекорд"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content = {
    Text = "Результаты дня"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content = {
    Text = "Еженедельные испытания"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content = {
    Text = "Накопленная оценка за эту неделю"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content = {
    Text = "Магазин обмена"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content = {
    Text = "Расследование титула"
  },
  PanelText_UI_Dungeons_Panel_Material_Text_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content = {
    Text = "Статистика оценок"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content = {
    Text = "Исследовательские данные"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content = {
    Text = "Расследование завершено"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_High_Content = {
    Text = "Новая высота!"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Получено в результате расчета"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content = {
    Text = "Оценка расследования"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content = {
    Text = "※предмет достиг максимума"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content = {
    Text = "Общая оценка"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content = {
    Text = "Статистика боя"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content = {
    Text = "Повышение уровня синхронизации пробуждающего тела"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content = {
    Text = "(Общая оценка равна следующей сумме, умноженной на 3)"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content = {
    Text = "Информация о команде"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content = {
    Text = "Промежуток"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content = {
    Text = "перерыв между сменами"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_1_Content = {
    Text = "Область Хаоса"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_2_Content = {
    Text = "Башня Кровавой Луны"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content = {
    Text = "Бездна Темного Моря"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content = {
    Text = "Путешествие Ультра"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content = {
    Text = "Обмен тьмы"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card2_Content = {
    Text = "(с гравировкой)"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content = {
    Text = "Статистика карт"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content = {
    Text = "Нет творения"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content = {
    Text = "Уровень Хранителя тайн"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Relic_Content = {
    Text = "Реликвия"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Reset_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content = {
    Text = "Данные команды"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content = {
    Text = "Свойства отряда"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content = {
    Text = "Расследовательская команда"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content = {
    Text = "Страж ID:"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Activity_Awaker_Content = {
    Text = "Забытое наследие·Ограничение"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content = {
    Text = "Завершение награды"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Emoji_Content = {
    Text = "Эмоция"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content = {
    Text = "Введение способности"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content = {
    Text = "Получить"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content = {
    Text = "Начать Зонд gameplay"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content = {
    Text = "Постоянный"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Star_Awaker_Content = {
    Text = "Звёздное Царство · Ограничение"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Undone_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content = {
    Text = "Перейти к пробуждению"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content = {
    Text = "Количество раз, которые можно получить на этой неделе"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content = {
    Text = "Количество раз, которые можно получить на этой неделе"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content = {
    Text = "Просмотреть подробности"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Rank_Content = {Text = "Ранг"},
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content = {
    Text = "Воспроизведение записи"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content = {
    Text = "Очки спецподготовки"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_Title_Content = {
    Text = "Рейтинговая таблица"
  },
  PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content = {
    Text = "Выход на бой"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content = {
    Text = "Наносит Урон"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content = {
    Text = "Причиняет лечение"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content = {
    Text = "Создание щита"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content = {
    Text = "Статистика боев"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content = {
    Text = "Выберите пробуждающее тело"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content = {
    Text = "Нет записей исследования"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content = {
    Text = "Заменить группу"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content = {
    Text = "Пройдите запись"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content = {
    Text = "Общее количество ходов"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Award_Content = {
    Text = "Высокий рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content = {
    Text = "Диапазон рангов"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content = {
    Text = "Текущая награда"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content = {
    Text = "Выберите пробуждающее тело"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content = {
    Text = "Расследование титула"
  },
  ["PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content"] = {
    Text = "Нет вознаграждения"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content = {
    Text = "Наивысший рекорд"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content = {
    Text = "Расследование титула"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content = {
    Text = "Наивысший рекорд"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_4_Content = {Text = "Ранг"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content = {Text = "Отряд"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content = {
    Text = "Запись"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Me_Content = {
    Text = "Мой рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content = {
    Text = "Награда будет отправлена на почту каждый понедельник в 9:00 на основе титула расследования"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Ranking_Content = {Text = "Ранг"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content = {
    Text = "Награда"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content = {
    Text = "Меньше или равно"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content = {
    Text = "Расследование рейтинга"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content = {
    Text = "Диапазон рангов"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content = {
    Text = "Расследование титула"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content = {
    Text = "Максимальный прогресс"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content = {
    Text = "Расследование титула"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Content = {Text = "Ранг"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content = {
    Text = "Запись"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content = {
    Text = "Награда"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content = {
    Text = "Количество ходов"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content = {Text = "Отряд"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content = {
    Text = "Список VIP-гостей"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content = {
    Text = "Больше"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content = {
    Text = "Награда"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content = {
    Text = "Меньше или равно"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content = {
    Text = "Инструкция по игре"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content = {
    Text = "Спайролл"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content = {
    Text = "Стандартный режим"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content = {
    Text = "Ежедневный вызов"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content = {
    Text = "Спайролл"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content = {
    Text = "Жду свободного места"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost_Content = {
    Text = "Арифметика"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content = {
    Text = "Дополнительный бонус"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content = {
    Text = "Ключесвет"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content = {
    Text = "Ручной бой"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content = {
    Text = "Алиемус"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard_Content = {
    Text = "Выложить карту"
  },
  PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content = {
    Text = "Счет суммируется до"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content = {
    Text = "Количество звёзд в этом уровне составляет"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content = {
    Text = "Звёздный рейтинг за этот Уровень получен"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content = {
    Text = "Нет состава"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content = {
    Text = "Бой: данные передаются"
  },
  PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content = {
    Text = "Сегодняшняя награда: дополнительно +50%, неограниченное количество раз"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content = {
    Text = "Сегодня в два раза больше наград"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content = {
    Text = "Количество раз, которые можно получить на этой неделе"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content = {
    Text = "Воссоздать"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_1_Content = {Text = "Хаос"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content = {
    Text = "Ультра"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_3_Content = {Text = "Каро"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_4_Content = {Text = "Эквор"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content = {
    Text = "Количество раз, которые можно получить на этой неделе"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content = {
    Text = "Детали врага"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content = {
    Text = "Награда за прохождение"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content = {
    Text = "Трансцендентное существо"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content = {
    Text = "Предпросмотр лидера"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty_Content = {
    Text = "Глубина погружения"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content = {
    Text = "Наивысший счёт за этот сезон"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content = {
    Text = "Усиление пробуждающего тела"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content = {
    Text = "Вознаграждение за персонажа"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content = {
    Text = "*В зоне поглощения катастрофы пробуждающие тела и Колесо Судьбы не смогут участвовать в боях в других зонах поглощения катастрофы."
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank_Content = {
    Text = "Рейтинговая таблица"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content = {
    Text = "Зона Р-эффекта"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content = {
    Text = "Текущий показатель тренировки"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content = {
    Text = "Награда за специальную тренировку"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content = {
    Text = "*После прохождения, пробуждающие тела, круг судьбы и ключевой приказ, задействованные в этом бою, не смогут участвовать в других зонах поглощения катастрофы."
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content = {
    Text = "Зона Р-эффекта"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content = {
    Text = "Текущий показатель тренировки"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content = {
    Text = "Награда за специальную тренировку"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content = {
    Text = "Дополнительный состав для прохождения"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content = {
    Text = "Очки за прохождение"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content = {
    Text = "Проходной состав"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content = {
    Text = "Предварительный просмотр монстра"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content = {
    Text = "Нет состава"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content = {
    Text = "Запись"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content = {
    Text = "Вызов не завершен"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content = {
    Text = "Значение прохождения тренировки"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content = {
    Text = "Проходной состав"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content = {
    Text = "Предварительный просмотр монстра"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Name_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content = {
    Text = "Вызов не завершен"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content = {Text = "Вызов"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content = {
    Text = "Уровень сложности выбора"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content = {
    Text = "Улучшения поезда"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content = {
    Text = "Безумие"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Normal_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content = {
    Text = "Список VIP-гостей"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Record_Content = {
    Text = "Придорожные снимки"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "Маленький« N »с помощью"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content = {
    Text = "Мчащийся экспресс наслаждений"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award2_Content = {
    Text = "Секреты правосудия"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content = {
    Text = "Детали врага"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content = {
    Text = "Требования к команде"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content = {
    Text = "Запись"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content = {
    Text = "Правила тайного царства"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content = {
    Text = "Детали врага"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content = {
    Text = "Требования к команде"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content = {
    Text = "Звездный прогресс"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content = {
    Text = "Сегодняшняя награда: дополнительно +50%, неограниченное количество раз"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content = {
    Text = "Сегодня в два раза больше наград"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content = {
    Text = "Ультра"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Hd_Content = {Text = "Хаос"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Sh_Content = {Text = "Эквор"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Special_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Xr_Content = {Text = "Каро"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content = {
    Text = "Воссоздать"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content = {
    Text = "Выберите Колесо Судьбы"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content = {
    Text = "Нажмите слева, чтобы выбрать"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content = {
    Text = "*одному пробуждающему телу можно установить только один SSR судьбы"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Выберите Колесо Судьбы"
  },
  PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content = {
    Text = "Как стать сильнее"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Награда предпросмотр за звезды"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_En_Content = {
    Text = "Может получить"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content = {
    Text = "Статистика оценок"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content = {
    Text = "Общая текущая оценка"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content = {
    Text = "Недостаточно валюты"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content = {
    Text = "Правила"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content = {
    Text = "Количество повторений"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Text_Content = {Text = "Нужно"},
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content = {
    Text = "Разблокируется после достижения трёх звёзд в оценке расследования"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content = {
    Text = "Подтверждение воспроизведения"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content = {
    Text = "Воспроизвести затраты"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content = {
    Text = "Количество повторений"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content = {
    Text = "Расследовательская команда"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content = {
    Text = "Подтверждение воспроизведения"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content = {
    Text = "Ключевой приказ запрещён на этом уровне"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Skill_Content = {
    Text = "Навык Хранителя Тайн"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content = {
    Text = "Команда вызова"
  },
  PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Награда за первый проход"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content = {
    Text = "Награда за первый проход"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content = {
    Text = "Накопительные награды"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content = {
    Text = "Накопительные награды"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content = {
    Text = "Сбросить вызов"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая граница мира"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content = {
    Text = "Ультра"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Hd_Content = {Text = "Хаос"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content = {
    Text = "Предварительный просмотр монстра"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Sh_Content = {Text = "Эквор"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Title_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Xr_Content = {Text = "Каро"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content = {
    Text = "Сбросить вызов"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content = {
    Text = "Детали вознаграждения"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content = {
    Text = "Область тьмы"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content = {
    Text = "Событие окончено, получение прекращено"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Full_Content = {
    Text = "Достигнут лимит хранения"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content = {
    Text = "Получить предметы"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content = {
    Text = "Скорость хранения:"
  },
  PanelText_UI_Event_Activity_Castor_Text_None_Content = {
    Text = "Нет ресурсов"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content = {
    Text = "Мероприятие завершено"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content = {
    Text = "Лимит ресурсов достигнут"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content = {
    Text = "Пожертвованные ресурсы отсутствуют"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content = {
    Text = "Инвентарь"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Получить скорость"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content = {
    Text = "Мероприятие завершено"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Full_Content = {
    Text = "Текущий хранилище достигло максимума"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content = {
    Text = "Хранение информации"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content = {
    Text = "Скорость хранения"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content = {
    Text = "Событие окончено, получение прекращено"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content = {
    Text = "Достигнут лимит хранения"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content = {
    Text = "Получить предметы"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content = {
    Text = "Скорость хранения:"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_None_Content = {
    Text = "Нет ресурсов"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Label_Content = {
    Text = "Флорин миссис Грей"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Mail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Title_Content = {
    Text = "Благотворительная ярмарка церкви"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content = {
    Text = "Событие окончено, получение прекращено"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content = {
    Text = "Достигнут лимит хранения"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content = {
    Text = "Получить предметы"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content = {
    Text = "Получить скорость"
  },
  PanelText_UI_Event_Activity_Miriam_Text_None_Content = {
    Text = "Нет ресурсов"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content = {
    Text = "Событие окончено, получение прекращено"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content = {
    Text = "Достигнут лимит хранения"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content = {
    Text = "Получить предметы"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content = {
    Text = "Скорость хранения:"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_None_Content = {
    Text = "Нет ресурсов"
  },
  PanelText_UI_Event_Activity_Pollux_Text_None_Content = {
    Text = "Нет ресурсов"
  },
  PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content = {
    Text = "Список благотворительной распродажи"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_C_Name_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_Name_Content = {
    Text = "Все обменять"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content = {
    Text = "Нажмите на пустое место, чтобы возврат"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content = {
    Text = "Особенные семена"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content = {
    Text = "Результат обмена"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content = {
    Text = "Сегодня Носитель тоже пришёл помочь Карен с уборкой? Замечательно, это небольшой жест от Карен, не могли бы вы, пожалуйста, принять это!"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content = {
    Text = "Благодарность Карен"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content = {
    Text = "Солнце, песчаный пляж, волны и бесчисленные улыбающиеся лица — в летнем фантастическом сне, сыграй в оживляющий волейбол!"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_Title_Content = {
    Text = "Летний карнавал"
  },
  PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content = {
    Text = "Бесплатный призыв"
  },
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Sold_Out_Content = {Text = "Иссяк"},
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Special_Tips_Content = {
    Text = "Специальный"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content = {
    Text = "Мероприятие завершено, хранение прекращено"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content = {
    Text = "Объем хранения веществ достиг максимума"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content = {
    Text = "Хранение веществ"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content = {
    Text = "Скорость хранения:"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Пограничное хранение"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_None_Content = {
    Text = "Нет ресурсов"
  },
  PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content = {
    Text = "Оставшиеся попытки пробуждения"
  },
  PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content = {
    Text = "Последний раз прошёл"
  },
  PanelText_UI_Event_Item_Return_Text_C_Close_Content = {
    Text = "Нажмите на экран, чтобы закрыть"
  },
  PanelText_UI_Event_Item_Return_Text_C_Finish_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Got_Content = {
    Text = "Получено"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content = {
    Text = "Ожидает получения"
  },
  PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content = {
    Text = "Святая дева дева дева дева зала"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content = {
    Text = "Шшш... глубокий вдох, расслабь свои щупальца. Сейчас ты погрузишься в сознание \"24\", чтобы исследовать скрытую память.."
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Кодировка памяти"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content = {
    Text = "Пробуждающее тело"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content = {
    Text = "Предпросмотр лидера"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content = {Text = "Вызов"},
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content = {
    Text = "Цель с звездным рейтингом"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content = {
    Text = "Спланированная тайна"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content = {
    Text = "Уровень создания"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content = {
    Text = "Двойной вызов"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_FristCreation_Content = {
    Text = "Начальное творение"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content = {
    Text = "Предпросмотр лидера<WordSize20:>"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content = {
    Text = "Р-прилив"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content = {
    Text = "Предварительный просмотр монстра"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content = {Text = "Вызов"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content = {
    Text = "Количество остаточных клонов"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content = {
    Text = "Запись"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content = {
    Text = "Очистка"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content = {
    Text = "Спланированная тайна"
  },
  PanelText_UI_Event_Panel_Challenge_Text_Career_Content = {
    Text = "Требование границы 1"
  },
  PanelText_UI_Event_RewardGroup_Text_C_Reset_Content = {
    Text = "Оставшиеся разы сброса"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Not_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Receive_Content = {
    Text = "Получить"
  },
  PanelText_UI_Event_Task_Item_Text_C_Not_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Event_Task_Item_Text_C_Receive_Content = {
    Text = "Получить"
  },
  PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content = {
    Text = "Оставшиеся попытки пробуждения"
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content = {
    Text = "Приди, воспевай эту реквием, Сверкающий между звёзд, нотами безумия, убийства и страдания. \n Это безумное высшее существо не должно пробуждаться, ни сейчас, ни в будущем."
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Title_Content = {
    Text = "Реквием утренней звезды"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content = {
    Text = "Обет бога уже близко.\nТысячелетия ожидания скоро принесут радостный Конец, обетованная земля поднимется Из моря.\nБог возродится из груди божественной матери, в конце семи дней новый мир будет явлен."
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content = {
    Text = "Сотворение семи дней"
  },
  PanelText_UI_Events_Item_Castor_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content = {
    Text = "Бесплатно"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_High_Content = {
    Text = "Бесплатно"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content = {
    Text = "Получить"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content = {
    Text = "Получено"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content = {
    Text = "Убийство!"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content = {
    Text = "Можно вызвать на бой"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Full_Content = {
    Text = "Позиции заполнены"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Have_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content = {
    Text = "После покупки получить"
  },
  PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content = {
    Text = "Всего поимок"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Career_Content = {
    Text = "Требования к команде"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Finish_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Kill_Content = {
    Text = "Поймано"
  },
  PanelText_UI_Events_Item_RAID_Text_CareerLimit_Content = {
    Text = "Не ограничено"
  },
  PanelText_UI_Events_Item_RAID_Text_Lock_Content = {
    Text = "Ещё не открыто"
  },
  PanelText_UI_Events_Item_Rome_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content = {
    Text = "Получено"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Stage_Text_C_Undone_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content = {
    Text = "Обычная Сложный не пройдена"
  },
  PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Events_Item_Tab_Text_C_Return_Content = {
    Text = "Вернуться активности"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content = {
    Text = "Требования к команде"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_CareerLimit_Content = {
    Text = "Не ограничено"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content = {
    Text = "Завершите этапы Оперативной записи для разблокировки"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content = {
    Text = "Уничтожено!"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content = {
    Text = "Количество остаточных клонов"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "Откажись от тела, откажись от разума, в этом pure воле почувствуй его существование.\nОн — твой единственный. Он также — всё твоё."
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content = {
    Text = "Неспокойный морской прилив"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content = {
    Text = "Раскройте рот пошире, крупно укусить.\nПоедание и быть съеденным, это правила боя, это Колесо Судьбы зверей."
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content = {
    Text = "Звериная амбиция"
  },
  PanelText_UI_Events_OriHelot_Text_C_Fall_Content = {
    Text = "Просмотр выпадения"
  },
  PanelText_UI_Events_OriHelot_Text_C_LockTips_Content = {
    Text = "Уведомление о разблокировке"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge_Content = {
    Text = "Реквием утренней звезды"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Мировой прогресс убийств"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content = {
    Text = "Обычное путешествие"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content = {
    Text = "Продвижение в Журнале путешествий"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content = {
    Text = "Премиальные архивы"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content = {
    Text = "Объяснение мероприятия"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content = {
    Text = "Текущая цена представлена в валюте по умолчанию и предназначена только для справки. При оплате следует учитывать фактическую валюту и цену."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content = {
    Text = "Свет зажигается. Возглас стихают. Зрители ждут.\nПришло время выйти на сцену, мои дорогие дети. Выходите, играйте, разрывайте свои души и выставляйте напоказ самые сокровенные тайны. Превратите свои жесточайшие раны в лакомство на потеху публике. Жадно упивайтесь лучом света, зажжённым на сцене лишь для вас, пока Занавес опускается не погребёт вас вместе со зрителями.\nЭто сцена, предначертанная вам судьбой – взойдите на неё! Не бойтесь, не робейте."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Title_Content = {
    Text = "Сцена марионеток"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Challenge_Content = {
    Text = "Сцена марионеток"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content = {
    Text = "Сувенирная лавка театра"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content = {
    Text = "Ткач в собственных путах"
  },
  PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content = {
    Text = "Завершите задание, чтобы получить купон на обмен одеждой"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content = {
    Text = "Иллюзорное Вдаль от берегов"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_Content = {
    Text = "Иллюзорное Вдаль от берегов"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Over_Content = {
    Text = "Сегодняшний опыт Хранителя тайн уже получен"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Title_Content = {
    Text = "Сегодняшний опыт Хранителя тайн уже получен"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Shop_Content = {
    Text = "Продвинутая тема"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content = {
    Text = "Путь к святилищу"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content = {
    Text = "(Дистанция до верхнего предела хранилища:)"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fundraising_Content = {
    Text = "Гражданин"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content = {
    Text = "<Gray:не разблокировано>"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content = {
    Text = "цвет крови"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content = {
    Text = "Резонанс: Перекресток души"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content = {
    Text = "Благотворительная ярмарка церкви"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content = {
    Text = "Пастух душ·Ремейк"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Award_Content = {
    Text = "Ограниченное предложение награды"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content = {
    Text = "Награда за расследование"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Over_Content = {
    Text = "Все награды получено"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content = {
    Text = "Награда за прохождение"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Title_Content = {
    Text = "Награда предпросмотр"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content = {
    Text = "♪~~♫~~♪~~♫~~♪~~♫~~\nПод снежными горами все проводники помнят это, все дети поют об этом. Это воплощение воли величественных снежных гор, это милосердная богиня Умапати.\nЕё божественная сила рассеяна по миру, её сокровища невозможно найти — они совсем рядом, и всё же их нигде нет. Откажись от чего-то, держись за что-то.\nТот, чьё сердце нечисто перед истинным обликом богини, навеки упокоится в снежных горах вместе с угасшими вершинами."
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content = {
    Text = "Сокровище Умапати"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content = {
    Text = "Сокровище Умапати"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content = {
    Text = "Специальная операция"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content = {
    Text = "Церемония феи"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content = {
    Text = "Новолуние и Глубокий Снег"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content = {
    Text = "Жизнь птицы предопределена свободой. Ты должен увидеть момент, когда она вылупляется, возвращая свободу жизни из рук смерти. Ты должен увидеть, как она учится летать, возвращая свободу самостоятельного существования из уютного гнезда. Если сейчас бросить ключ свободы в бездну смерти, она, без сомнений, прыгнет вниз, выбирая столкновение со штормом смерти между узкой жизнью и бесконечной свободой."
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content = {
    Text = "Прыжок через ясное небо"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content = {
    Text = "Прыжок через ясное небо"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Record_Content = {
    Text = "Мир чуждых снов"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content = {
    Text = "Жажда знаний"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content = {
    Text = "Узник зеркал"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content = {
    Text = "С тех пор она больше не пролила ни одной слезы.\nОдна она скитается и блуждает, блуждает в мире, полном чужеземцев.\nНачинается грандиозный план, как её прощальный Выход на сцену.\nОна - самый успешный психотерапевт, и это её самое успешное лечение."
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content = {
    Text = "Исцеление страха"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content = {
    Text = "Исцеление страха"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content = {
    Text = "Резонанс: нет"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content = {
    Text = "Кабинет неврологии"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content = {
    Text = "Погребённое воспоминание"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content = {
    Text = "Все награды получено"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Lottery_Content = {
    Text = "Взять один раз"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content = {
    Text = "Пояснение вероятности"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content = {
    Text = "<color=#e3c96e>Премиальный наряд</color>можно получить, начиная с<color=#e3c96e>5</color>-й попытки"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content = {
    Text = "Пастырь душ"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content = {
    Text = "Бесплатно"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content = {
    Text = "В этом прибрежном городке есть оживлённая торговая улица. Морская торговля собрала здесь множество современных товаров, и, заплатив достаточное количество Лэофангов, вы всегда сможете получить удовлетворительные товары. \n Единственное исключение — это небольшая лавка на углу, полная волшебных антикварных вещей, где хозяйка в широкополой шляпе медленно улыбнётся вам сквозь дым, вырывающийся из её трубки. \n «Добро пожаловать в магазин \"Решение забот\", здесь мы можем удовлетворить все ваши потребности, просто заплатите соответствующую цену...» \n «Конечно, конечно, цены разумные, мы честны с клиентами.»"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Title_Content = {
    Text = "Магазинчик ведьмы"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Challenge_Content = {
    Text = "Магазинчик ведьмы"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content = {
    Text = "Шкатулка ковенанта ведьмы"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content = {
    Text = "Призрак дождливого города"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content = {
    Text = "Струнные инструменты уже поднялись на небесах, и тринадцатый звон уже раздался.\nЭтой ночью нож поэта будет распевать для нас.\nЭтой ночью глотка матери встретит нас."
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content = {
    Text = "Пир пожирания духов"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content = {
    Text = "Пир пожирания духов"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content = {
    Text = "Записи заданий"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content = {
    Text = "Столовая королевской резиденции"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content = {
    Text = "Эстетика некромантии"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content = {
    Text = "Обычное путешествие"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content = {
    Text = "Продвижение в Журнале путешествий"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content = {
    Text = "Премиальные архивы"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content = {
    Text = "Объяснение мероприятия"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content = {
    Text = "Гулкий звук звучит на конце его посоха.\nВ глубоком сне, до финальной главы уничтожения."
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content = {
    Text = "Гулкий звук"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content = {
    Text = "Гулкий звук"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content = {
    Text = "Резонанс: нет"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content = {
    Text = "Цитадель сна"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content = {
    Text = "бесформенная симфония"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content = {
    Text = "В ветхой оранжерее заточена одинокая роза."
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content = {
    Text = "Сад воспоминаний"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content = {
    Text = "Сад воспоминаний"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content = {
    Text = "Резонанс: Элегия сада"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Shop_Content = {
    Text = "Оранжерея Колетт"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Topic_Content = {
    Text = "Перед тем как весна увянет"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content = {
    Text = "Субсидия на очистку"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content = {
    Text = "Благодарность Карен"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Task_Content = {
    Text = "Очистить прогресс"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content = {
    Text = "Швабра и чудо"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content = {
    Text = "Она вновь встала на Земле, месть, уничтожающая всё, пришла, как и ожидалось. \n\nЭто бесконечное Погоня, это пылающий Искра Господина Взрывного Пламени. \n\nОна пройдет через каждый уголок, убивая всех, кто подписал контракт со Смертью. \n\nБеги, беги, убегай в более глубокую тьму, убегай в место, где ты думаешь, что тебя не найдут. \n\nХотя это бессмысленно, потому что Он в конечном итоге пройдет через каждый мир. \n\nОн будет охотиться на всех, пока всё не сгорит в Пепел."
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content = {
    Text = "Погоня за тлеющими углями"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content = {
    Text = "Погоня за тлеющими углями"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content = {
    Text = "(Дистанция до верхнего предела хранилища:)"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content = {
    Text = "Тайная база"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content = {
    Text = "Нисхождение множества светил"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content = {
    Text = "Вы стали свидетелем не только выбора души, но и её переменчивого пути."
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content = {
    Text = "Путь к святилищу"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content = {
    Text = "Задания, которые поручает Долл, никогда не бывают простыми. \n Даже если она многократно напоминает всем \"хорошо повеселиться\", как Страж может не испытывать тревоги, впервые выводя группу пробуждённых на улицу? \n Но не забывайте \"хорошо повеселиться\"."
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content = {
    Text = "Спланированная тайна"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content = {
    Text = "Спланированная тайна"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content = {
    Text = "Резонанс:код режиссёра"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content = {
    Text = "Магазин магических либретто"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content = {
    Text = "Магия историй · Ремейк"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content = {
    Text = "Сила, власть, деньги, свобода… На землях Левиафана Он дарует тебе всё, чего ты жаждешь.\nПока ты сможешь остаться последним стоящим."
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content = {
    Text = "Кровавое Побоище"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content = {
    Text = "Кровавое Побоище"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content = {
    Text = "Жертвенный Алтарь Арены"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content = {
    Text = "Игра Левиафана"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content = {
    Text = "Спланированная тайна"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content = {
    Text = "Задачи, которые ставит Долл, никогда не бывают простыми. \n Хотя она несколько раз напоминала всем \"получать удовольствие\", как Страж может не испытывать страха, впервые выводя группу пробуждённых на улицу? \n Но не забывайте \"получать удовольствие\"."
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content = {
    Text = "Текущее владение"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content = {
    Text = "Резонанс: режиссёрский код"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content = {
    Text = "Магазин магических либретто"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Topic_Content = {
    Text = "Магия историй"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content = {
    Text = "Коридор воспоминаний"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content = {
    Text = "Коридор воспоминаний"
  },
  PanelText_UI_Events_Panel_Main_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content = {
    Text = "Семидневная регистрация"
  },
  PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content = {
    Text = "Объяснение мероприятия"
  },
  PanelText_UI_Events_Panel_Main_Text_Title_Content = {Text = "Акция"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content = {
    Text = "Вступи на этот трудный и Освящение путь. В конце пути тебя ждёт последняя Ворота, готовая распахнуться."
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content = {
    Text = "Нисхождение божественного царства"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content = {
    Text = "Нисхождение божественного царства"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content = {
    Text = "Мир чуждых снов"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content = {
    Text = "Резонанс: ритуал глубин"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content = {
    Text = "Отклик пучины"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content = {
    Text = "Жертвоприношение бездне"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content = {
    Text = "Небо~ясно~море~спокойно~\nМосс~Близкий Близкий друг~маленький угольный шарик~в путь!\nШторм, не страшно, молния, не страшно, Моск, Близкий Близкий друг, маленький угольный шарик~\nЗа свободу, нужно·в·путь"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content = {
    Text = "Моск и море"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content = {
    Text = "Моск и море"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Record_Content = {
    Text = "Вдаль от берегов"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content = {
    Text = "Шкатулка ковенанта Моск"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content = {
    Text = "Призыв Мальстрёма"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content = {
    Text = "Вдруг в один день ты обнаруживаешь, что стал другим. \n Никто не замечает этого, потому что у тебя те же манеры, те же прекрасные черты лица. \n Но ты хорошо понимаешь, что то красное сердце, которое было раньше, теперь покрыто маской из тумана. \n «Если я смогу продолжать притворяться, буду ли я по-прежнему тем же самым человеком?» \n К счастью, этот вопрос не задерживается в твоем мозгу более чем на секунду, ведь прежде чем снять эту маску, никто не знает твоих истинных мыслей. \n «Что ж, пора отправляться ~»"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Title_Content = {
    Text = "Потерянное я"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Challenge_Content = {
    Text = "Потерянное я"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content = {
    Text = "Многомерное соединение"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Shop_Content = {
    Text = "Домик Мося"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content = {
    Text = "Сжигание в туманном краю"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content = {
    Text = "От Него @1 тёмного @2, великий @3 Нисхождение в мир"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content = {
    Text = "Тёмная матка"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content = {
    Text = "Тёмная матка"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content = {
    Text = "Во время акции все способы получения согласованности дают двойной Эффект!"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content = {
    Text = "Воспевание розы"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content = {
    Text = "Инкубация священного плода"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content = {
    Text = "Звёзды на своих местах·правильная позиция"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content = {
    Text = "Неспокойный морской прилив"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content = {
    Text = "Завершите задание, чтобы получить купон на обмен одеждой"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content = {
    Text = "Прогресс убийства аномальных морских приливов"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content = {
    Text = "Всплытие Лемурии"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content = {
    Text = "Она смотрела на ту большую Ворота в конце света и, ни разу не колеблясь, сделала шаг вперёд. \n Щелк, она повернула ручку и с нетерпением заглянула за Ворота. \n Однако За дверью не было ничего, и она оступилась, упав в Пустоту. \n Она давно должна была знать, что Подарок приходит слишком прямо, всегда имеет высокую цену."
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content = {
    Text = "Ворота небытия"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content = {
    Text = "Ворота небытия"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content = {
    Text = "Резонанс: нет"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content = {
    Text = "Наставление учителя"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Topic_Content = {
    Text = "Разница в полшага"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content = {
    Text = "Звериная амбиция"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content = {
    Text = "Горная пасть"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content = {
    Text = "Снежная гора таяния · Ремейк"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content = {
    Text = "Обет бога уже близко.\nТысячелетия ожидания скоро принесут радостный Конец, обетованная земля поднимется Из моря.\nБог возродится из груди божественной матери, в конце семи дней новый мир будет явлен."
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content = {
    Text = "Сотворение семи дней"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content = {
    Text = "Сотворение семи дней"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content = {
    Text = "Спальня Матери богов"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content = {
    Text = "Жертвоприношение бога"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content = {
    Text = "Ограниченное сотрудничество"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content = {
    Text = "Мой ход"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Shop_Content = {
    Text = "Название магазина"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content = {
    Text = "Призрак дождливого города"
  },
  PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content = {
    Text = "Оставшаяся награда"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content = {
    Text = "Между разумом и сбоем хитрая картина медленно разворачивается. \n Отвергнутый тобой фантазм рисует яркие цвета, \n А Страх перед утратой контроля формирует Верность. \n Здесь сумасшествие — это инстинкт искусства, Генезис мира, \n единственная настоящая Правда, которая не лжет."
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content = {
    Text = "Свиток иного мира"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content = {
    Text = "Свиток иного мира"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content = {
    Text = "Мастерская Пикмана"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content = {
    Text = "Свиток иного мира"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content = {
    Text = "Те Досаждение и любовь, нежность и боль, то, что мы имели и то, что упустили, уже переплетены так, что неразрывны.\n Пусть наша общая кровь течет, она соберется в одно место, составив нашу неразрывную судьбу."
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Title_Content = {
    Text = "Смешанная горькая кровь"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Challenge_Content = {
    Text = "Смешанная горькая кровь"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content = {
    Text = "За гранью небес · Часть II"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content = {
    Text = "Ритуал благословения"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content = {
    Text = "Вечный полярный день"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content = {
    Text = "Когда зловещий белый свет вновь пронзает окна высокого дома, он уже направил тебе приглашение.\nОбъять, поглотить, увлечь, стеснить… \nОтветь на Призыв из глубин Океана, вступи в эту нескончаемую Охоту с высот — твоё прошлое, твоё «я», всё это уже не имеет значения."
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content = {
    Text = "Охота с высот"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content = {
    Text = "Охота с высот"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content = {
    Text = "Бескрайние угодья"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content = {
    Text = "Вечный Эпоянс"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content = {
    Text = "Кошачья охота за серебром"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Rank_Content = {
    Text = "Рейтинг поимок"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content = {
    Text = "Записи о поимке чёрного кота"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content = {
    Text = "«Благодарность» кота"
  },
  PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content = {
    Text = "Поезд отправляется"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "Поезд отправляется"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content = {
    Text = "Список VIP-гостей"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "Маленький« N »с помощью"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content = {
    Text = "Маршрут спецпоезда"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content = {
    Text = "Мчащийся экспресс наслаждений"
  },
  PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Events_Panel_Reward_Text_Title_Content = {
    Text = "Награда за задание"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content = {
    Text = "Мы - хищники, мы - потомки волков. Те вкусные, кровавые куски мяса в конечном итоге упадут в наши животы."
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content = {
    Text = "Священная охота"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content = {
    Text = "Священная охота"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Record_Content = {
    Text = "Мир чуждых снов"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content = {
    Text = "Почтительно поднести дань"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content = {
    Text = "Рим! Специальное мероприятие"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content = {
    Text = "Верно, сейчас уже не в моде обычные детективы. \nЕсли ты не можешь ни летать, ни исчезать под землёй и у тебя нет ассистента-учёного, подумай о смене профессии."
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content = {
    Text = "Легенда лунной ночи"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content = {
    Text = "Легенда лунной ночи"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content = {
    Text = "Во время акции все способы получения согласованности дают двойной Эффект!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content = {
    Text = "Удачная охота!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content = {
    Text = "Клуб удачи"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content = {
    Text = "Руководство знаменитого детектива · реплика"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content = {
    Text = "Наука — неважна.\nЭтика — неважна.\nМораль — неважна.\nЖизнь, смерть, надежда, отчаяние… В конце концов, в самом конце, в тетради в подвале двумя разными почерками записан один и тот же вывод.\nОни говорят: «Смотри, любовь — единственная и вечная тема.»"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content = {
    Text = "Записки из тёмной комнаты"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content = {
    Text = "Записки из тёмной комнаты"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Record_Content = {
    Text = "Забытое семя любви"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content = {
    Text = "Сад одуванчиков"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content = {
    Text = "Перевёрнутое перерождение"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content = {
    Text = "Спустя много лет, биограф подошёл к её дому и постучал в Ворота в один из вечеров. \n В тот день они много говорили, от агата до увядающего особняка роз... \n Теперь писатель собрал эти разрозненные слова в книгу и посвятил её всем присутствующим."
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content = {
    Text = "Воспоминания розы"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content = {
    Text = "Воспоминания розы"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content = {
    Text = "Во время акции все способы получения согласованности дают двойной Эффект!"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content = {
    Text = "Воспевание розы"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content = {
    Text = "Золотисто-красное торжество"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content = {
    Text = "Послание розы"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content = {
    Text = "Награда за расследование"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Over_Content = {
    Text = "Все условия для получения награды достигнуто"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content = {
    Text = "Награда за прохождение"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Title_Content = {
    Text = "После завершения испытания пробуждающего тела вы получите награду"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content = {
    Text = "Старинный Секстант определяет угол между звездами, древняя морская Карта прокладывает ожидаемый маршрут, старый компас указывает направление движения...\nДаже в глубоком холодном Черном море все еще есть исследователи, которые с помощью обыкновенной меди и железа указывают путь толпе.\nПусть все проводники не впадут в замешательство."
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title_Content = {
    Text = "Потерянный в глубинах моря"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Challenge_Content = {
    Text = "Потерянный в глубинах моря"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content = {
    Text = "Последнее штурманство"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content = {
    Text = "Сокровище моряка"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content = {
    Text = "Колеблясь под ливнем"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content = {
    Text = "Дружба на первом месте, соревнование на втором——да не один раз! \nПод палящим солнцем пускаем пот, стремимся к победе!"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content = {
    Text = "Пляжный волейбол"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content = {
    Text = "Пляжный волейбол"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content = {
    Text = "Мир чуждых снов"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content = {
    Text = "Прибрежная гостиница"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content = {
    Text = "Летний карнавал"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content = {
    Text = "Летние специальные события·верх"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content = {
    Text = "Под тёплым солнцем всё выглядит так уютно и счастливо.\n Ты смотришь на небо, такое же ярко-синее, как в сказочной книге, и решаешь Разрыв холст, вырваться из ложного мира."
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content = {
    Text = "Звездный прогресс"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Title_Content = {
    Text = "Под солнечным светом всё ново"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Challenge_Content = {
    Text = "Под солнечным светом всё ново"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content = {
    Text = "Мир чуждых снов"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content = {
    Text = "Здание студенческого совета"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Topic_Content = {
    Text = "Если б жизнь была как прежде"
  },
  PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content = {
    Text = "Награда за возвращение в школу"
  },
  PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Events_Panel_Task_Text_Title_Content = {
    Text = "Очистить прогресс"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content = {
    Text = "Пересеките Ворота предела и достигните области бесконечной мудрости.\nВстретьте Осквернение лицом к лицу и осознайте, что такое «самость».\nЭто «итоговый тест», данный вам Им."
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content = {
    Text = "итоговый тест"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content = {
    Text = "итоговый тест"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Shop_Content = {Text = "Эхо"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content = {
    Text = "Ворота всех явлений"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content = {
    Text = "Танец кошек"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content = {
    Text = "Каждый день открываются разные Уровни с учебной кошкой, успешное прохождение вызова принесет богатую награду!"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content = {
    Text = "Уса Ня Ня Рейт"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content = {
    Text = "Время течёт и возвращается, цветы, что увяли, снова расцветают."
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content = {
    Text = "Беспорядочная страсть"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content = {
    Text = "Беспорядочная страсть"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content = {
    Text = "Во время акции все способы получения согласованности дают двойной Эффект!"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content = {
    Text = "Ограниченное предложение разблокировать"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Record_Content = {
    Text = "Безумие размножения"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Shop_Content = {
    Text = "Разрастание греховных желаний"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content = {
    Text = "Плотские желания"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Fail_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Summon_Content = {
    Text = "Перейти к пробуждению"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content = {
    Text = "Текст молитвы, посвящение, жертва, глубина людей для Него — всего лишь надоедливая комедия.\nНо эта комедия изредка оставляет след в глазах... или в сердце Царя Богов."
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content = {
    Text = "Взгляд бездны"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content = {
    Text = "Взгляд бездны"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Record_Content = {
    Text = "День коронации"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content = {
    Text = "Резонанс: Поглощение горы"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content = {
    Text = "Пучина осознания"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content = {
    Text = "воскрешение бога-короля"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content = {
    Text = "Кодировка памяти"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content = {
    Text = "(Дистанция до верхнего предела хранилища:)"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content = {
    Text = "<Gray:не разблокировано>"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content = {
    Text = "Тихая фрагментация"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content = {
    Text = "Резонанс: разделение синдром"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Shop_Content = {
    Text = "Анализ личности"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content = {
    Text = "Множественное исцеление·Воспроизведение"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content = {
    Text = "Исару, Город в озере, считается родиной Ванды.\nНа этот раз ты пересечешь врата сновидения и окажешься у древних башен, полных язычков колоколов.."
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content = {
    Text = "Резонанс"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Title_Content = {
    Text = "Город в озере"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content = {
    Text = "Доступно"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Challenge_Content = {
    Text = "Город в озере"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content = {
    Text = "(расстояние до полного заполнения:)"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Pv_Content = {
    Text = "Воспроизвести видеозапись"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content = {
    Text = "До получения:"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content = {
    Text = "Пламенное пиршество"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content = {
    Text = "Резонанс:секретное приказание"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content = {
    Text = "Шкатулка диковин Ванды"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content = {
    Text = "Пламенное пиршество"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Challenge_Content = {
    Text = "Реквием утренней звезды"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Прогресс битвы с первоначальным врагом"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content = {
    Text = "Список почетных наград"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content = {
    Text = "Особая операция"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content = {
    Text = "Решающая битва: Изначальная Чёрная Чёрная Чёрная Чёрная тень"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content = {
    Text = "Из любви рождается Досаждение, из ненависти рождается Досаждение, вязкая, непрерывная, мрачная...\nПрошу неба, но оно не отвечает, скрываюсь от земли, но нет выхода, и тогда тот смех, скрытый в ночном тумане, откликнулся на твой зов, и ты не должен платить никакой цены. \nСмотри на неё, следуй за ней, сливайся с ней, становись ею."
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content = {
    Text = "Обсидиановая матриарх"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content = {
    Text = "Режим игры доступен ограниченное время"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content = {
    Text = "Обсидиановая матриарх"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content = {
    Text = "Ограниченный свободный доступ"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Record_Content = {
    Text = "Погружение в сознание"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content = {
    Text = "Награда за достижения"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Shop_Content = {
    Text = "Опустошённое подношение"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content = {
    Text = "Шёпот Хуанпу"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content = {
    Text = "Награда"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content = {
    Text = "Текущая вероятность"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content = {
    Text = "Начальная вероятность"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content = {
    Text = "Награда предметом"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content = {
    Text = "Вероятность"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content = {
    Text = "Описание мероприятия"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content = {
    Text = "Обзор мероприятия"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content = {
    Text = "Просмотреть все доступные Колесо судьбы"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content = {
    Text = "Только в течение 24 часов! \n Выберите один из постоянных пробуждающих тел!"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content = {
    Text = "Оставшийся"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content = {
    Text = "Текущая цена представлена в валюте по умолчанию и предназначена только для справки. При оплате следует учитывать фактическую валюту и цену."
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content = {
    Text = "Просмотреть подробности"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content = {
    Text = "Получить"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Title_Content = {
    Text = "Выбор колеса судьбы"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content = {
    Text = "Роль помощника в бою"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content = {
    Text = "Помощь в бою раз"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content = {
    Text = "Рейтинг по помощи"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content = {
    Text = "Всего поимок"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content = {
    Text = "Рейтинг по поимкам"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist_Content = {Text = "Ранг"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill_Content = {Text = "Ранг"},
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content = {
    Text = "Список почетных наград"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content = {
    Text = "Чёрное, чёрное, чёрное…\nЧёрные чудовища рычат, ревут, неистово пляшут, накатывая на тебя подобно приливу.\n «Пфф—»\n«В этом серебряном ядре так мало, в следующий раз не забудь принести побольше.»"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content = {
    Text = "Кошачья охота за серебром"
  },
  PanelText_UI_Events_Stage_Tip_Text_C_Title_Content = {
    Text = "Награда за расследование"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content = {
    Text = "Чёрный, чёрная волна не перестаёт катиться.\nБезумие котов окружили тебя, они приходят к тебе из бесчисленных размерностей."
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content = {
    Text = "Танец кошек"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "Смотрите в лицо своему исходному отчаянию. Смотрите в лицо своему исходному страху. \nВстаньте рядом, невидимые Близкий Близкий Близкий Близкий друг для друга, и победите Его."
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Title_Content = {
    Text = "Реквием утренней звезды"
  },
  PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content = {
    Text = "Описание пробуждающего тела"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content = {
    Text = "Материалы собраны"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Goto_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content = {
    Text = "Получить Генезис"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content = {
    Text = "Воссоздать"
  },
  PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content = {
    Text = "Получить"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Goto_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content = {
    Text = "Получить Генезис"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content = {
    Text = "Воссоздать"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content = {
    Text = "Заменить"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content = {
    Text = "Нажмите, чтобы выбрать Пробуждённого"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content = {
    Text = "Детали"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content = {
    Text = "Талант"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content = {
    Text = "Уровень"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_More_Content = {
    Text = "Дополнительные улучшения"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content = {
    Text = "Выберите Пробуждённого"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Skill_Content = {
    Text = "Умение"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content = {
    Text = "Талант"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss_Content = {Text = "Ранг"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content = {
    Text = "Оставшаяся награда"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content = {Text = "Очки"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content = {Text = "Очки"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content = {
    Text = "Прогресс сезона"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content = {Text = "Очки"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content = {
    Text = "Зона поглощения катастрофы"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content = {
    Text = "Фантазийное Вдаль от берегов"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content = {
    Text = "Фазовая партия – Режим подбора"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content = {
    Text = "Мчащийся экспресс наслаждений"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content = {
    Text = "Фазовая партия – Режим ротации"
  },
  PanelText_UI_GuideNote_PermTrainBase_Text_C_Goto_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Goto_Content = {
    Text = "Перейти"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content = {
    Text = "Предпросмотр оставшихся ресурсов"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content = {
    Text = "Нет оставшихся ресурсов"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content = {
    Text = "Прогресс"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content = {
    Text = "Исследование"
  },
  PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content = {Text = "Гриф"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content = {
    Text = "Подпись"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content = {
    Text = "Подпись"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Myself_Content = {
    Text = "Ваше имя"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Return_Content = {
    Text = "Вернуться долга к выбору пола"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Tips_Content = {
    Text = "Введите Ваше имя"
  },
  PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content = {Text = "Гриф"},
  PanelText_UI_Home_Panel_Main_Text_C_Title_Content = {
    Text = "Исследовательский центр"
  },
  PanelText_UI_Homeland_Item_Building_Text_C_Done_Content = {
    Text = "Полностью заполнено"
  },
  PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content = {
    Text = "Обзор бонусов"
  },
  PanelText_UI_InvitationCode_Item_Player_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content = {
    Text = "Привязка к проводнику-хранителю, во Вселенной, где сверкают бесчисленные серебряные ключи, ты не одинок."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content = {
    Text = "Связывание аккаунта"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content = {
    Text = "Связывание аккаунта"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Clean_Content = {
    Text = "Очистить"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content = {
    Text = "Приглашённый Страж может получить награду в виде Глиммера серебряного ключа после достижения 5/10/15/20 уровня."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content = {
    Text = "Копировать"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content = {
    Text = "Скопируйте код приглашения и поведите души в бесконечной Вселенной в путешествие растворения."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content = {
    Text = "Введите персональный код приглашения друга, чтобы немедленно получить"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content = {
    Text = "Количество приглашённых людей"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content = {
    Text = "Приглашение на акцию"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content = {
    Text = "Приглашение на акцию"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InvitedCount_Content = {Text = "300!"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content = {
    Text = "Мой код приглашения"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content = {
    Text = "Вставить"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Share_Content = {
    Text = "Поделиться"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content = {
    Text = "Введите код приглашения"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content = {
    Text = "Серебряное сияние"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content = {
    Text = "Объяснение мероприятия"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content = {
    Text = "Приглашение на акцию"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content = {
    Text = "Нет приглашённых Хранителей тайн, достигших 5-го уровня"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title2_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content = {
    Text = "Список приглашений"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content = {
    Text = "Получен новый ключевой приказ"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content = {
    Text = "Нажмите на экран, чтобы закрыть"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content = {
    Text = "Текущее использование"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content = {
    Text = "Невозможно использовать"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content = {Text = "Выбор"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_2_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content = {
    Text = "Нет ключевого приказа"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content = {
    Text = "Выбор сервера"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content = {
    Text = "Объявление об акции"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content = {
    Text = "Исправление проблемы"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Game_Content = {
    Text = "Объявление"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title2_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_Content = {
    Text = "Нет объявлений"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_En_Content = {
    Text = "Входящие пусты"
  },
  PanelText_UI_Login_Popup_Tips_Text_Title_Content = {
    Text = "Объявление"
  },
  PanelText_UI_Login_Text_C_Announcement_Content = {
    Text = "Объявление"
  },
  PanelText_UI_Login_Text_C_Deal_Content = {
    Text = "Протокол"
  },
  PanelText_UI_Login_Text_C_Enter_Content = {
    Text = "Войти в Мисаг"
  },
  PanelText_UI_Login_Text_C_Fight_Content = {Text = "Бой 2.0"},
  PanelText_UI_Login_Text_C_Plot_Content = {
    Text = "Тестирование сюжета AVG"
  },
  PanelText_UI_Login_Text_C_Quit_Content = {Text = "Выход"},
  PanelText_UI_Login_Text_C_Repair_Content = {
    Text = "Исправление"
  },
  PanelText_UI_Login_Text_C_Service_Content = {
    Text = "Служба поддержки клиентов"
  },
  PanelText_UI_Login_Text_C_Set_Content = {
    Text = "Настройки"
  },
  PanelText_UI_Login_Text_C_Setting_Content = {
    Text = "Настройки"
  },
  PanelText_UI_Login_Text_C_Sweep_Content = {
    Text = "Сканировать код"
  },
  PanelText_UI_Login_Text_C_Title1_Content = {
    Text = "Канун забвения"
  },
  PanelText_UI_Login_Text_C_User_Content = {
    Text = "Центра пользователей"
  },
  PanelText_UI_Mail_Text_C_All_Content = {
    Text = "Все получить"
  },
  PanelText_UI_Mail_Text_C_Collection_Content = {
    Text = "Сохраненные письма"
  },
  PanelText_UI_Mail_Text_C_Delete01_Content = {
    Text = "Удалить"
  },
  PanelText_UI_Mail_Text_C_Delete_Content = {
    Text = "Удалить прочитанное"
  },
  PanelText_UI_Mail_Text_C_Empty_Content = {
    Text = "Нет новых писем"
  },
  PanelText_UI_Mail_Text_C_Mail_Content = {
    Text = "Количество писем"
  },
  PanelText_UI_Mail_Text_C_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Mail_Text_C_NoTask1_Content = {
    Text = "Нет писем"
  },
  PanelText_UI_Mail_Text_C_Select_Letter_Content = {
    Text = "Выбор письма"
  },
  PanelText_UI_Mail_Text_C_Time_Content = {Text = "Время"},
  PanelText_UI_Mail_Text_C_Tips_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Mail_Text_C_Title_Content = {
    Text = "Почтовый ящик"
  },
  PanelText_UI_Mail_Text_Time2_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Mail_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Close_Content = {
    Text = "Нажмите на экран, чтобы закрыть"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content = {
    Text = "Ежедневное задание"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Finish_Content = {
    Text = "Сегодня завершено"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content = {
    Text = "Получено"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content = {
    Text = "Завершение награды"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content = {
    Text = "Пути расследования"
  },
  PanelText_UI_Main_Favor_Tip_Text_C_Name_Content = {
    Text = "Связать"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content = {
    Text = "Дата пробуждения"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content = {
    Text = "Текущий Уровень согласованности"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content = {
    Text = "После приглашения пробуждающего тела, спустя определённый период времени это пробуждающее тело может получить Связать"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Title_Content = {
    Text = "Общежитие"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content = {
    Text = "Пригласить гостя"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_Name_2_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content = {
    Text = "Стандартная музыка"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Not_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content = {
    Text = "Доверенность"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content = {
    Text = "Получить"
  },
  PanelText_UI_Main_Panel_1_Text_Abyss_Content = {
    Text = "Зона поглощения катастрофы"
  },
  PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content = {
    Text = "Хорошая оценка"
  },
  PanelText_UI_Main_Panel_1_Text_C_Activity_Content = {Text = "Акция"},
  PanelText_UI_Main_Panel_1_Text_C_Awaker_Content = {
    Text = "Пробуждённый"
  },
  PanelText_UI_Main_Panel_1_Text_C_Bag_Content = {
    Text = "Инвентарь"
  },
  PanelText_UI_Main_Panel_1_Text_C_Close_1_Content = {
    Text = "Закрывается"
  },
  PanelText_UI_Main_Panel_1_Text_C_Close_Content = {
    Text = "Закрывается"
  },
  PanelText_UI_Main_Panel_1_Text_C_Collection_Content = {
    Text = "Библиотека тайных писаний"
  },
  PanelText_UI_Main_Panel_1_Text_C_Community_Content = {
    Text = "Сообщество"
  },
  PanelText_UI_Main_Panel_1_Text_C_Daily_Content = {
    Text = "Ежедневное задание"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dbg_Content = {
    Text = "Интерлюдия"
  },
  PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content = {
    Text = "Тайный класс"
  },
  PanelText_UI_Main_Panel_1_Text_C_Formation_Content = {Text = "Отряд"},
  PanelText_UI_Main_Panel_1_Text_C_Full_Content = {
    Text = "Завершено"
  },
  PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content = {
    Text = "Хроники Хранителя"
  },
  PanelText_UI_Main_Panel_1_Text_C_Lesson_Content = {
    Text = "Семестровые задания"
  },
  PanelText_UI_Main_Panel_1_Text_C_Main_Content = {
    Text = "Расследование"
  },
  PanelText_UI_Main_Panel_1_Text_C_Mission_Content = {
    Text = "Личное дело"
  },
  PanelText_UI_Main_Panel_1_Text_C_Pvp_Content = {
    Text = "Фазовый поединок\n"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recall_Content = {
    Text = "Коридор воспоминаний"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Content = {
    Text = "Пробудить"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content = {
    Text = "Пробудить"
  },
  PanelText_UI_Main_Panel_1_Text_C_Store_Content = {
    Text = "Магазин Мисаг"
  },
  PanelText_UI_Main_Panel_1_Text_C_Welfare_Content = {
    Text = "Огромное количество бонусов, ограниченное время для получения"
  },
  PanelText_UI_Main_Panel_1_Text_Diving_Content = {
    Text = "Фантазийное Вдаль от берегов"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content = {
    Text = "Регулярные задания"
  },
  PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content = {
    Text = "Нажмите на пустое место, чтобы закрыть"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Consume_Content = {
    Text = "расход"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content = {
    Text = "Всего пожертвовано"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content = {
    Text = "Фонд пожертвований выпускников"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Least_Content = {
    Text = "Минимум"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Title_Content = {
    Text = "Донорская сыворотка"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Utmost_Content = {
    Text = "Максимальный"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content = {
    Text = "Пожертвование «источной жидкости», накопление вклада, ваши добрые дела будут вознаграждены. Ваш «Общий вклад» — это сумма пожертвованной «источной жидкости»."
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content = {
    Text = "Общий текущий вклад"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Title_Content = {
    Text = "Фонд пожертвований выпускников"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content = {
    Text = "Правила"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_All_Content = {
    Text = "Восстановить всё:"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content = {
    Text = "Автоматическое восстановление"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_1_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Next_Content = {
    Text = "Следующее восстановление"
  },
  PanelText_UI_Other_Physical_Tips_Text_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Energy_Content = {
    Text = "Расход энергии"
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content = {
    Text = "Нажмите на пустое место, чтобы закрыть"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content = {
    Text = "Расход сердечника из серебра"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content = {
    Text = "Текущее сердечное серебро кристаллическое ядро"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content = {
    Text = "Хотите получить ключ?"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content = {
    Text = "Ключ изматывания"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content = {
    Text = "Держать ключ"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content = {
    Text = "Получение ключа"
  },
  PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content = {
    Text = "Усиление успешно"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_HP_Content = {
    Text = "Количество крови"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content = {
    Text = "Ожидание отображения информации о выборе колеса"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Attack_Content = {
    Text = "Сначала ходит"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content = {
    Text = "Ход соперника"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content = {
    Text = "Нажмите, чтобы изменить позиции пробуждённых тел"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content = {
    Text = "Готово!"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content = {
    Text = "Готово!"
  },
  PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content = {Text = "Выбор"},
  PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content = {
    Text = "Выбор полученных наград"
  },
  PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content = {
    Text = "Повысить Уровень"
  },
  PanelText_UI_Passport_Exchange_Text_C_Cost_Tips_Content = {Text = "Нужно"},
  PanelText_UI_Passport_Exchange_Text_C_Title_Content = {
    Text = "Повышение уровня темы"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_En_Content = {
    Text = "Повысить Уровень."
  },
  PanelText_UI_Passport_Instructions_Text_C_Remainder_Content = {
    Text = "Оставшееся время в текущем периоде"
  },
  PanelText_UI_Passport_Instructions_Text_C_Title_Content = {
    Text = "Семестровые задания"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content = {
    Text = "Разблокируйте, чтобы немедленно получить"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content = {
    Text = "Выполнив все задания, можно суммарно получить"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_1_Content = {
    Text = "Немедленно повысить"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content = {
    Text = "Уровень"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content = {
    Text = "Уровень темы"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content = {
    Text = "Немедленно повысить <color=#5EF2FF><size=32>10</size> Уровень</color> предмета"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content = {
    Text = "Разблокируйте продвинутую тему и повысьте её до 40 уровня, чтобы выбрать одно колесо судьбы или 5 ядер света в качестве награды в сундуке тем исследования"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content = {
    Text = "Порядок проведения тренировок"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content = {
    Text = "Тройная награда\nза базовую активность"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content = {
    Text = "Раунд битвы  \nОткат"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content = {
    Text = "Фазовая ловушка\nПолная игра с картами"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content = {
    Text = "Привилегия на время текущего курса"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content = {
    Text = "Пожалуйста, развлекайтесь умеренно и разумно тратьте деньги"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content = {
    Text = "Куплено"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content = {
    Text = "Куплено"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content"] = {
    Text = "Улучш."
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content = {
    Text = "Сложная тема"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content"] = {
    Text = "Специальный класс"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content = {
    Text = "Премиум тема"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content = {
    Text = "Мгновенно получите эксклюзивные награды основного задания"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content = {
    Text = "Выполнив все задания, можно суммарно получить"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Condition_Content = {
    Text = "Доступно для получения после улучшения"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_1_Content = {
    Text = "Немедленно повысить"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content = {
    Text = "Уровень"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content = {
    Text = "Уровень темы для получения"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content = {
    Text = "Изысканный подарочный ящик, содержащий ценное колесо судьбы, изготовленный вручную.\nРазблокируйте продвинутую тему и повысьте её до 40 уровня, чтобы выбрать одно колесо судьбы или «ядро света» ×5 в качестве награды."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Name_Content = {
    Text = "Конспект чести"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content = {
    Text = "Пожалуйста, развлекайтесь умеренно и разумно тратьте деньги"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content = {
    Text = "Куплено"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content = {
    Text = "Куплено"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content"] = {
    Text = "Улучш."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Senior_Content = {
    Text = "Сложная тема"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content"] = {
    Text = "Специальный класс"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Super_Content = {
    Text = "Премиум тема"
  },
  PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content = {
    Text = "Содержит всё содержание текущей Сложной темы"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content = {
    Text = "Семестровые задания"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content = {
    Text = "Опыт темы исследования"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Full_Content = {
    Text = "Уже максимальный Уровень"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content = {
    Text = "Уровень темы"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Name_Content = {
    Text = "Повысить Уровень"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Online_Content = {
    Text = "Максимум опыта за эту неделю"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Title_Content = {
    Text = "Семестровые задания"
  },
  PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content = {
    Text = "Уровень темы повышается"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Cancel_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Title_Content = {
    Text = "Подтверждение покупки"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Content_Content = {
    Text = "Изысканный подарочный ящик, содержащий ценное колесо судьбы, изготовленный вручную.\nРазблокируйте продвинутую тему и повысьте её до 40 уровня, чтобы выбрать одно колесо судьбы или «ядро света» ×5 в качестве награды."
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Title_Content = {
    Text = "Конспект чести"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content = {
    Text = "Опыт темы исследования"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content = {
    Text = "Уже максимальный Уровень"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content = {
    Text = "Получить опыт"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content = {
    Text = "Уровень покупки"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content = {
    Text = "Недельный лимит"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content = {
    Text = "Базовая тема"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content = {
    Text = "Экстра конспект"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content = {
    Text = "Сложная тема"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Timing_Content = {
    Text = "Этот выпуск"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content = {
    Text = "Разблокируйте, чтобы немедленно получить"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content = {
    Text = "Опыт темы исследования"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Full_Content = {
    Text = "Уже максимальный Уровень"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content = {
    Text = "Уровень покупки"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Online_Content = {
    Text = "Недельный лимит"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content = {
    Text = "Базовая тема"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content = {
    Text = "Экстра конспект"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content = {
    Text = "Сложная тема"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content = {
    Text = "Улучш."
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content = {
    Text = "Оставшееся время в текущем периоде"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content = {
    Text = "Разблокируйте продвинутую тему и повысьте её до 40 уровня, чтобы выбрать одно колесо судьбы или 5 ядер света в качестве награды в сундуке тем исследования"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Reward_Content = {
    Text = "Предварительный просмотр подарочной коробки этого выпуска"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content = {
    Text = "Оставшееся время текущей акции"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Double_Content = {
    Text = "двойной опыт"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content = {Text = "Акция"},
  PanelText_UI_Passport_Task_Description_Text_C_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content = {Text = "Акция"},
  PanelText_UI_Passport_Task_Item_Text_C_Experience_Content = {
    Text = "Опыт темы исследования"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Full_Content = {
    Text = "Уже максимальный Уровень"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content = {
    Text = "Уровень покупки"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Online_Content = {
    Text = "Недельный лимит"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Time_Content = {
    Text = "Оставшееся время в текущем периоде"
  },
  PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content = {
    Text = "Правила"
  },
  PanelText_UI_Pocket_Mail_Text_C_Del_Content = {
    Text = "Удалить"
  },
  PanelText_UI_Pocket_Mail_Text_C_Time_Content = {Text = "Время"},
  PanelText_UI_Pocket_Mail_Text_C_Tips_Content = {
    Text = "Количество раритетных предметов"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title2_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title_Content = {
    Text = "Нет писем"
  },
  PanelText_UI_Pocket_Mail_Text_C_select_Title_Content = {
    Text = "Выбор письма"
  },
  PanelText_UI_Popup_DonationBox_Text_C_Reward_Content = {
    Text = "Инвентарь"
  },
  PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Получить скорость"
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content = {
    Text = "Текущий"
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content = {
    Text = "Не получено"
  },
  PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content = {
    Text = "Кликните, чтобы освободить"
  },
  PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content = {
    Text = "Заменить"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content = {
    Text = "Подписался на меня"
  },
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content = {
    Text = "Текущий ранг"
  },
  PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content = {
    Text = "Конфликт позиционирования"
  },
  PanelText_UI_Pvp_Item_List_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content = {
    Text = "Вдвое больше бонусов"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content = {
    Text = "Тематическое привилегия"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content = {
    Text = "Текущая награда"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content = {
    Text = "Колода"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content = {
    Text = "Алиемус"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content = {
    Text = "Победы"
  },
  PanelText_UI_Pvp_Panel_Battle_Text_High_Content = {
    Text = "Сдаться"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content = {
    Text = "Нет комментариев"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content = {
    Text = "Оставьте первый комментарий"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content = {
    Text = "Колода"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Effect_Content = {
    Text = "Эффект"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Hoist_Content = {
    Text = "Расход арифметики"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content = {
    Text = "Алиемус"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content = {
    Text = "Общее количество побед"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "Побед за месяц"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content = {
    Text = "Вознесение"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content = {
    Text = "Источник"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content = {
    Text = "Общее количество побед"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content = {
    Text = "Победы в этом сезоне"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content = {
    Text = "Нет связанных избранных"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content = {
    Text = "Эта граница в Фазовая игра не доступна"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content = {
    Text = "Пробуждённый"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content = {
    Text = "Детали"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2_Content = {Text = "Ранг"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content = {
    Text = "Комментарий"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content = {
    Text = "Пробуждающее тело"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content = {
    Text = "Колесо Судьбы"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content = {
    Text = "Побед за месяц"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content = {
    Text = "Общее количество побед"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content = {
    Text = "Колода"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Effect_Content = {
    Text = "Эффект"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content = {
    Text = "Алиемус"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content = {
    Text = "Победы"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content = {
    Text = "Победы"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content = {
    Text = "Пожалуйста, выберите появление слева"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content = {
    Text = "Пожалуйста, выберите появление слева"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content = {
    Text = "Пожалуйста, выберите появление слева"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content = {
    Text = "Детали"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_None2_Content = {
    Text = "Пока нет материалов"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content = {
    Text = "Нет соответствующих результатов фильтрации"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content = {
    Text = "Доступно определенными способами"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content = {
    Text = "Награда за победу"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content = {
    Text = "Предсобранный Отряд"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content = {
    Text = "Закрыть"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content = {
    Text = "Закрыть"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Collection_Content = {
    Text = "Избранное"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content = {
    Text = "Уровень выбора"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content = {
    Text = "Эмодзи фазовой игры"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content = {
    Text = "Очки сезона"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content = {
    Text = "Начать матч"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content = {
    Text = "Включить"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content = {
    Text = "Включить"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content = {
    Text = "Парольная битва"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content = {
    Text = "Уровень предгруппировки"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content = {
    Text = "Награда за ранг"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content = {
    Text = "Режим предварительной сборки"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content = {Text = "Очки"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Ranking_Content = {
    Text = "Рейтинговая таблица"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content = {
    Text = "Запись о противостоянии"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content = {
    Text = "Достигайте более высоких рангов, чтобы получить больше наград"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content = {
    Text = "Матч с ИИ"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content = {
    Text = "Разброс колеса"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content = {Text = "Очки"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content = {
    Text = "Правила"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Speed_Content = {
    Text = "Точный подбор"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Store_Content = {
    Text = "Магазин"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content = {
    Text = "Осталось времени в сезоне"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content = {
    Text = "Победы подряд"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content = {
    Text = "Награда недели"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_list_Content = {Text = "Ранг"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content = {Text = "Конец"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content = {Text = "Конец"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content = {
    Text = "Общий Урон"
  },
  PanelText_UI_Pvp_Panel_Match_Text_C_Second_Content = {
    Text = "Секунда"
  },
  PanelText_UI_Pvp_Panel_Match_Text_C_Win_Content = {
    Text = "Успешное сопоставление"
  },
  PanelText_UI_Pvp_Panel_Match_Text_Name_Content = {
    Text = "Начать матч"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Получено в результате расчета"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content = {
    Text = "Очки сезона"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Show_Content = {
    Text = "Следующий шаг"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content = {
    Text = "Повышение уровня синхронизации пробуждающего тела"
  },
  PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content = {
    Text = "Переключитьперспектива"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content = {
    Text = "Похвала"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content = {
    Text = "Спасибо за комплимент! Пожалуйста, предоставьте текст для перевода, и я выполню перевод в соответствии с требованиями"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content = {Text = "Враг"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content = {
    Text = "Неудача"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content = {Text = "Урон"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Ourside_Content = {Text = "Мы"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content = {
    Text = "Победа"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content = {
    Text = "Уважаемый Противник!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_01_Content = {Text = "Часть"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_02_Content = {Text = "Часть"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content = {
    Text = "Уважаемый Противник!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content = {Text = "Щит"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content = {
    Text = "Лечение"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content = {
    Text = "Победа"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content = {
    Text = "Добавить ключевую команду"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Position_Content = {Text = "Сдвиг"},
  PanelText_UI_Pvp_Panel_Train_Text_C_Reset_Content = {
    Text = "Стопка сброса"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content = {
    Text = "Выбор создания"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content = {
    Text = "Добавить колесо судьбы"
  },
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_01_Content = {Text = "Часть"},
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_02_Content = {Text = "Часть"},
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content = {
    Text = "Ссылка с сервером прервана"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content = {
    Text = "Вернуться на страницу входа"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content = {
    Text = "Колода"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Effect_Content = {
    Text = "Эффект"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content = {
    Text = "Алиемус"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "Победы"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content = {
    Text = "Победы"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content = {
    Text = "Сезонное Усиление"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content = {
    Text = "Нажмите, чтобы продолжить"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content = {
    Text = "Победная серия"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content = {
    Text = "Озарение"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content = {
    Text = "Текущее использование"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content = {
    Text = "Озарение"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Content = {
    Text = "Управление выражениями лица"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Content = {
    Text = "Истории эмодзи"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel_Content = {
    Text = "Истории эмодзи"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel_Content = {
    Text = "Управление выражениями лица"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Title_Content = {
    Text = "Управление выражениями лица"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content = {
    Text = "Эмодзи фазовой игры"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content = {
    Text = "Нажмите на пустое место, чтобы продолжить"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content = {
    Text = "Нажмите, чтобы продолжить"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content = {
    Text = "Неудача"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content = {
    Text = "Бой проигран"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content = {
    Text = "Награда за боевой стиль"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content = {
    Text = "Создать бой"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content = {
    Text = "Присоединиться к бою"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_Title_Content = {
    Text = "Парольная битва"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content = {
    Text = "Импортировать состав команды"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content = {
    Text = "Введите 6-значное <color=#5EF2FF>значение фазы</color>"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content = {
    Text = "Введите значение фазы"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content = {
    Text = "Копировать значение фазы"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Wait_Content = {
    Text = "Ожидание…"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content = {
    Text = "Парольная битва"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content = {
    Text = "Подписался на меня"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content = {
    Text = "готовиться"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content = {
    Text = "Отказаться"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content = {
    Text = "Ожидание готовности противника…"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content = {
    Text = "Копировать"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content = {
    Text = "Просмотр повтора"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content = {
    Text = "Выбор ракурса"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Initial_Content = {
    Text = "Начальная рука"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content = {
    Text = "Нажмите, чтобы заменить нежелательные рука"
  },
  PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content = {
    Text = "Награда за ранг"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content = {
    Text = "Выберите 1 создание"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content = {
    Text = "Нажмите на пустое место, чтобы продолжить"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content = {
    Text = "Победа"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content = {
    Text = "Максимальное количество очков в истории"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content = {
    Text = "Запись о противостоянии"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content = {
    Text = "Сезонный рейтинг"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content = {
    Text = "Награда за рейтинг"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content = {
    Text = "Награда"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content = {
    Text = "Рейтинг за неделю"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content = {
    Text = "Рейтинг за неделю"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Grade_Content = {Text = "Ранг"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content = {
    Text = "Победа в одном матче в этом сезоне позволит получить награду по итогам сезона."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content = {
    Text = "Участие в одном матче в этом сезоне позволит вам войти в «Рейтинг сезона»."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content = {
    Text = "Режим предварительной сборки"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content = {
    Text = "Разброс колеса"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content = {
    Text = "Макс. очки за сезон"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content = {
    Text = "Диапазон рангов"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content = {
    Text = "Звание в сражении"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content = {
    Text = "Звание в сражении"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content = {
    Text = "Неудача"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content = {
    Text = "Нажмите, чтобы продолжить"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content = {
    Text = "Победа"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content = {
    Text = "Нажмите, чтобы продолжить"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Title_Content = {
    Text = "Рейтинговая таблица"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content = {
    Text = "Экипировать мандалу"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content = {
    Text = "Снаряжение ключевой приказ"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content = {
    Text = "Пробуждающее тело позиции №4"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content = {
    Text = "Пробуждающее тело позиции 3"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content = {
    Text = "Позиция 2 пробуждающее тело"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content = {
    Text = "Позиция 1 пробуждающее тело"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content = {
    Text = "Снаряжение ключевой приказ"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content = {
    Text = "Экипировать мандалу"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content = {
    Text = "Экипировать мандалу"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content = {
    Text = "Экипировать мандалу"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_Content = {
    Text = "Быстрая группировка"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content = {
    Text = "Граница не активирована"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Title_Content = {
    Text = "Предсобранный Отряд"
  },
  PanelText_UI_Pvp_Team_Main_Text_Name_Content = {
    Text = "Быстрая группировка"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content = {
    Text = "Копировать"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content = {
    Text = "Подписался на меня"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content = {
    Text = "Общее количество побед"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content = {
    Text = "Редактировать"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content = {
    Text = "Удалить"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content = {
    Text = "Подробности комментария"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content = {
    Text = "Дополнительный Подарок"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle_Content = {
    Text = "Сверхценность"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Sellout_Content = {Text = "Иссяк"},
  PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content = {
    Text = "Количество обменять Серебро"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Cost_Tips_Content = {
    Text = "расход"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Least_Content = {
    Text = "Минимум"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content = {
    Text = "Накоплено обменять:"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Utmost_Content = {
    Text = "Максимальный"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content = {
    Text = "Недостаточно валюты"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content = {
    Text = "Подтвердить обмен"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Recharge_Instructions_Text_C_Title_Content = {
    Text = "Семестровые задания"
  },
  PanelText_UI_Recharge_Instructions_Text_Name_Content = {
    Text = "Перейти"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content = {
    Text = "Итоговое потребление"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content = {
    Text = "Можно выбрать и удалить ненужные предметы, которые не нужно покупать"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content = {
    Text = "Подтверждение покупки"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content = {
    Text = "За каждое первое пополнение предоставляется дополнительный Подарок в виде «источной жидкости» в равном размере, единоразово"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law1_Content = {
    Text = "Специальный закон"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content = {
    Text = "Метод расчета средств"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content = {
    Text = "Свяжитесь с службой поддержки клиентов"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Title_Content = {
    Text = "Извлечение премиального серебра"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content = {
    Text = "Текущая цена представлена в валюте по умолчанию и предназначена только для справки. При оплате следует учитывать фактическую валюту и цену."
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content = {
    Text = "Описание мероприятия"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content = {
    Text = "Только в течение 24 часов! \n Выберите один из постоянных пробуждающих тел!"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content = {
    Text = "Оставшийся"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content = {
    Text = "Текущая цена представлена в валюте по умолчанию и предназначена только для справки. При оплате следует учитывать фактическую валюту и цену."
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content = {
    Text = "Каждое первое пополнение удваивается, только один раз"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips_Content = {
    Text = "расход"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content = {
    Text = "Срок действия истек"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Flushed_Content = {
    Text = "обновить"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content = {
    Text = "Немедленно получить"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content = {
    Text = "Ежедневный Подарок"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content = {
    Text = "Накапливается при покупке"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content = {
    Text = "Одним кликом купить"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content = {
    Text = "Свяжитесь с службой поддержки клиентов"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content = {
    Text = "*Всего можно получить 300 кристаллов сердечника из серебра + 3000 сердечников из серебра"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content = {
    Text = "Сегодняшний бонус уже получен"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2_Content = {
    Text = "(30 дней)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content = {
    Text = "При первом пополнении каждого уровня вы получите равное количество «источной жидкости» в Подарок. Только один раз"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content = {
    Text = "Покупка"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "расход"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content = {
    Text = "Дополнительно"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content = {
    Text = "Срок действия истек"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content = {
    Text = "Дополнительно"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Flushed_Content = {
    Text = "обновить"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_NumName_Content = {
    Text = "Премиальное серебро"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content = {
    Text = "Немедленно получить"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content = {
    Text = "Серебро"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title2_Content = {
    Text = "(30 дней)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content = {
    Text = "Ежедневный Подарок"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content = {
    Text = "Накапливается при покупке"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Need_Content = {Text = "Нужно"},
  PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content = {
    Text = "Одним кликом купить"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content = {
    Text = "Свяжитесь с службой поддержки клиентов"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content = {
    Text = "Каждый день входа вы можете получить\n«Серебряные ядра» <color=#57F8FE><size=38>×6000</size></color>!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content = {
    Text = "Каждый день входа вы можете получить \n «Менофин» <color=#57F8FE><size=38>×6000</size></color> и «Перо памяти» <color=#57F8FE><size=38>×600</size></color>"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content = {
    Text = "Немедленно получить"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content = {
    Text = "Правила игры"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Need_Content = {Text = "Нужно"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content = {
    Text = "Каждый день отправляется по почте (30 дней)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content = {
    Text = "Пополнение в футляре"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content = {
    Text = "*итого можно получить «Серебро» × 300 + «Серебро» × 6000"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content = {
    Text = "Магазин Мисаг"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content = {
    Text = "Сегодняшний бонус уже получен"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content = {
    Text = "Пополнение"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root_Content = {
    Text = "Исходная пена"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content = {
    Text = "Пополнение"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root_Content = {
    Text = "Исходная пена"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Get2_Title2_Content = {
    Text = "(30 дней)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Name_Content = {
    Text = "Покупка"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Tips_Content = {
    Text = "*итого можно получить «Серебро» × 300 + «Серебро» × 6000"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content = {
    Text = "Пополнение"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_Content = {
    Text = "Исходная пена"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content = {
    Text = "Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content = {
    Text = "Пополнение"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Root_Content = {
    Text = "Исходная пена"
  },
  PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content = {
    Text = "Нажмите, чтобы забрать награду за Наблюдение Луны"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content = {
    Text = "Покупка"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content = {
    Text = "Покупка"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content = {
    Text = "Магазин Мисаг"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cancel_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content = {
    Text = "Покупка"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips_Content = {
    Text = "расход"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content = {
    Text = "Подтверждение покупки"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_En_Content = {Text = "Title"},
  PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content = {
    Text = "Первое пополнение"
  },
  PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content = {
    Text = "Дополнительно"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content = {
    Text = "Не получено это пробуждающее тело"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content = {
    Text = "Активировать талант"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content = {
    Text = "Обзор талантов"
  },
  PanelText_UI_Research_Panel_Challenge_Item_Text_C_Undone_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content = {
    Text = "Текущий прогресс"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content = {
    Text = "Всё достижения получены"
  },
  PanelText_UI_Research_Panel_Challenge_Text_Title_Content = {
    Text = "Достижение"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content = {
    Text = "Правила"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content = {
    Text = "\"дополнительно\""
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content = {
    Text = "Пока что нет новых задач на диспетчеризацию"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content = {
    Text = "Общий Уровень диспетчеризации, превышающий 20 уровней, дает право на получение 1 дополнительной награды"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content = {
    Text = "Условия выполнены"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_Underway_Content = {
    Text = "В процессе диспетчеризации.."
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content = {
    Text = "Ожидает получения"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content = {
    Text = "Не разблокировано"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content = {
    Text = "В процессе"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content = {
    Text = "Оставшийся"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal_Content = {
    Text = "расход"
  },
  PanelText_UI_Research_Panel_Dispatch_Text_Title_Content = {
    Text = "Назначение"
  },
  PanelText_UI_Research_Popup_Dispatch_Text_Title_Content = {
    Text = "Обзор бонусов назначения"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Agin_Content = {
    Text = "Снова отправить"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content = {
    Text = "Отправка пробуждающего тела"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content = {
    Text = "Награда за задание"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content = {
    Text = "Диспетчерский отчет"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Close_Content = {
    Text = "Закрыть"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Award_Content = {
    Text = "Награда за задание"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content = {
    Text = "Общий текущий Уровень"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content = {
    Text = "[дополнительно]"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Level_Content = {
    Text = "Общий Уровень диспетчеризации"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content = {
    Text = "За каждое превышение общего уровня диспетчеризации на 20 уровней вы можете получить 1 дополнительную награду"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special_Content = {
    Text = "Условия выполнены"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Title_Content = {
    Text = "Выбор пробуждающего тела для отправки"
  },
  PanelText_UI_Research_Popup_Report_Text_C_Title_Content = {
    Text = "Отчёт о расследовании"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content = {
    Text = "Позже вы сможете изменить в разделе \"Настройки — Язык\""
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content = {
    Text = "Выберите язык"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Clean_Content = {
    Text = "Очистить"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content = {
    Text = "Вставить"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content = {
    Text = "Введите код обмена"
  },
  PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content = {
    Text = "Ресурсы загружаются.."
  },
  PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content = {
    Text = "Выполняется проверка целостности игровых ресурсов"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Tips_Content = {
    Text = "Внутренний GM"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Title_Content = {
    Text = "Настройки"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content = {
    Text = "Получить"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content = {
    Text = "Получить"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content = {
    Text = "Награда за Вход"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content = {
    Text = "Не достигнуто"
  },
  PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content = {
    Text = "Аватар"
  },
  PanelText_UI_Shop_Item_Commodity_Text_C_Value_Content = {
    Text = "Сверхценность"
  },
  PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content = {
    Text = "Рекомендовать"
  },
  PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content = {
    Text = "Недостаточно валюты"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content = {
    Text = "Помощь в бою раз"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content = {
    Text = "Ссылка пробуждающее тело"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Birthday_Content = {
    Text = "День рождения"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content = {
    Text = "Достижение достигнуто"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content = {
    Text = "Исследование"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content = {
    Text = "Иллюзорное Вдаль от берегов"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content = {
    Text = "Последователь"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content = {
    Text = "Наивысший рекорд"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content = {
    Text = "Область тьмы·Промежуток между сменами"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content = {
    Text = "Область тьмы"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content = {
    Text = "Страж изменил настройки расследования обстоятельств на конфиденциальные"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content = {
    Text = "Дней входа"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content = {
    Text = "Принадлежит гильдии"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content = {
    Text = "Расследовать обстоятельства"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content = {
    Text = "Пожалуйста, введите краткое описание о себе"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content = {
    Text = "Зона Р-эффекта"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content = {
    Text = "Помощь в бою раз"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content = {
    Text = "Ссылка пробуждающее тело"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Ban_Content = {
    Text = "Заблокировать"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Birthday_Content = {
    Text = "День рождения"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content = {
    Text = "Прогресс коллекции"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content = {
    Text = "Достижение достигнуто"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content = {
    Text = "Исследование"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content = {
    Text = "Иллюзорное Вдаль от берегов"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content = {
    Text = "Последователь"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content = {Text = "Пол"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content = {
    Text = "Наивысший рекорд"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content = {
    Text = "Область тьмы·Промежуток между сменами"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Normal_Content = {
    Text = "Обычный"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content = {
    Text = "Не настроено"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content = {
    Text = "Область тьмы"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content = {
    Text = "Страж изменил настройки расследования обстоятельств на конфиденциальные"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content = {
    Text = "Дней входа"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content = {
    Text = "Принадлежит гильдии"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content = {
    Text = "Расследовать обстоятельства"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content = {Text = "Итого"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content = {
    Text = "Наивысший рекорд"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content = {
    Text = "Примечание :"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content = {
    Text = "Тело пробуждения для помощи в бою"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content = {
    Text = "Пробуждающее тело помощи в бою не настроено"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content = {
    Text = "Скрыть пробуждающее тело"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Squiggle_Content = {
    Text = "Серебро порождает знание."
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content = {
    Text = "Демонстрация пробуждающего тела"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Accept_Content = {
    Text = "Принять"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Cancel_Content = {
    Text = "Отменено"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content = {
    Text = "Подписался на меня"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content = {
    Text = "Отклонено"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content = {
    Text = "Отказаться"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content = {
    Text = "Время истекло"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Fail_Content = {
    Text = "Неудача"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Victory_Content = {
    Text = "Победа"
  },
  PanelText_UI_Social_Item_PvpData_Text_C_Point_01_Content = {Text = "Часть"},
  PanelText_UI_Social_Item_PvpData_Text_Fail_Content = {
    Text = "Неудача"
  },
  PanelText_UI_Social_Item_PvpData_Text_Victory_Content = {
    Text = "Победа"
  },
  PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content = {
    Text = "Неудача"
  },
  PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content = {
    Text = "Победа"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content = {
    Text = "Открыть запись о бою"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Input_Content = {
    Text = "Введите«Боевая запись», чтобы посмотреть повтор"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content = {
    Text = "Нет записей о фазовых поединках"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content = {
    Text = "Исследование"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content = {
    Text = "Исследование"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content = {
    Text = "Фазовая игра"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Search_Content = {
    Text = "Просмотр повтора"
  },
  PanelText_UI_Social_Item_Pvp_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Attention_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Following_Content = {
    Text = "Подписано"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content = {
    Text = "Подписаны Близкий Близкий Близкий Близкий друг на друга"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Assist_Content = {
    Text = "Помощь в бою раз"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content = {
    Text = "Ссылка пробуждающее тело"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Birthday_Content = {
    Text = "День рождения"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content = {
    Text = "Достижение достигнуто"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content = {
    Text = "Сложный"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Dream_Content = {
    Text = "Иллюзорное Вдаль от берегов"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Fans_Content = {
    Text = "Последователь"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Help_Content = {
    Text = "Тело пробуждения для помощи в бою"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content = {
    Text = "Неописуемый"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Not_Content = {
    Text = "Пробуждающее тело помощи в бою не настроено"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content = {
    Text = "Скрыть пробуждающее тело"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content = {
    Text = "Башня тьмы"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content = {
    Text = "Страж изменил настройки расследования обстоятельств на конфиденциальные"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Register_Content = {
    Text = "Дней входа"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Society_Content = {
    Text = "Принадлежит гильдии"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Squiggle_Content = {
    Text = "Серебро порождает знание."
  },
  PanelText_UI_Social_Panel_Data_Text_C_Survey_Content = {
    Text = "Расследовать обстоятельства"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Team_Content = {
    Text = "Демонстрация пробуждающего тела"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Title_Content = {
    Text = "Архив Хранителя"
  },
  PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content = {
    Text = "Выбрано"
  },
  ["PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content"] = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content = {
    Text = "Часто используемая помощь"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content = {
    Text = "Конфликт границ"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content = {
    Text = "Последователь"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content = {
    Text = "Подписано"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content = {
    Text = "Недавние боевые помощники"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content = {
    Text = "Рекомендовать внимание"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content = {
    Text = "Часто используемая помощь"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_1_Content = {
    Text = "обновить"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content = {
    Text = "Выход на сцену"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_1_Content = {
    Text = "обновить"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content = {
    Text = "Выход на сцену"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content = {
    Text = "Пока нет подходящего пробуждающего тела для помощи в бою, рекомендуется изменить «Фильтр пробуждающих тел»"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content = {
    Text = "Можно использовать пробуждающее тело Хранителя тайн, с которым у вас взаимное внимание, для совместного боя"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content = {
    Text = "Выберите помощника в бою"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content = {
    Text = "Подписался на меня"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content = {
    Text = "Подписано"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content = {
    Text = "Взаимное внимание"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Unblock_Content = {
    Text = "Отменить блокировку"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content = {
    Text = "Отписаться"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Concern_Content = {
    Text = "Добавить"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content = {
    Text = "Пока никого не отслеживаю"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content = {
    Text = "Нет результатов поиска"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content = {
    Text = "Все подписки"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Concern_Content = {
    Text = "Добавить"
  },
  PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content = {
    Text = "Нет внимания"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Stranger_Content = {
    Text = "Незнакомец"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content = {
    Text = "Введите имя для поиска"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content = {
    Text = "Введите имя для поиска"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Interaction_Content = {
    Text = "Взаимодействие"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content = {
    Text = "Достижение"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Rank_Content = {Text = "Ранг"},
  PanelText_UI_Social_Panel_RankList_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Social_Panel_Rank_Text_C_All_Content = {Text = "Всё"},
  PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content = {
    Text = "Внимание"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content = {
    Text = "Взаимодействие"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content = {
    Text = "Информация о Хранителе тайн"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Rank_Content = {Text = "Ранг"},
  PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content = {
    Text = "Краткое описание"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Social_Popup_Birthday_Text_C_Day_Content = {
    Text = "Солнце"
  },
  PanelText_UI_Social_Popup_Birthday_Text_C_Month_Content = {Text = "Луна"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content = {
    Text = "Редактировать день рождения"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content = {
    Text = "Нет партнеров по битве"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content = {
    Text = "Введите UID для поиска Хранителя тайн"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Search_Content = {Text = "Поиск"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content = {
    Text = "Часто используемая помощь"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_Time_Content = {
    Text = "Можешь посмотреть в другом месте"
  },
  PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content = {
    Text = "Приглашение на дружеский матч"
  },
  PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content = {
    Text = "Пожалуйста, введите краткое описание о себе"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content = {Text = "Выбор"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content = {
    Text = "<size=25>Базовый режим фазовой дуэли: обе стороны используют заранее подготовленные команды для сражения.</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content = {
    Text = "Режим предварительной сборки"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content = {Text = "Выбор"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content = {
    Text = "<size=25>Премиум режим фазовой дуэли: обе стороны поочерёдно выбирают карты из случайного пула, формируя колоду для сражения.</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content = {
    Text = "Разброс колеса"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_Title_Content = {
    Text = "Выберите режим"
  },
  PanelText_UI_Social_Popup_Match_Text_C_Waiting_Content = {
    Text = "Ожидание"
  },
  PanelText_UI_Social_Popup_Match_Text_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Social_Popup_Match_Text_Title_Content = {
    Text = "Товарищеский матч"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content = {
    Text = "Рамка аватара"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content = {
    Text = "Рамка аватара"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content = {
    Text = "Аватар"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content = {
    Text = "Аватар"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Using_Content = {
    Text = "Использование"
  },
  PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content = {
    Text = "Расследовать обстоятельства"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_C_Cost_Content = {
    Text = "расход"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_Cancel_Name_Content = {
    Text = "Отмена"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content = {
    Text = "Переключить пол"
  },
  PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content = {
    Text = "Нет добавленных последователей"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content = {
    Text = "Все подписки"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Tip_Content = {
    Text = "Можно просмотреть недавних 100 добавленных последователей"
  },
  PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content = {
    Text = "Товарищеский матч"
  },
  PanelText_UI_Story_Panel_Main_Text_C_High_Content = {
    Text = "Сбросить фон входа"
  },
  PanelText_UI_Story_Panel_Main_Text_C_Normal_Content = {
    Text = "Установить как фон входа"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content = {
    Text = "Продолжить путь"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content = {
    Text = "Архив памяти"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Close_Content = {
    Text = "Закрыть"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content = {
    Text = "Скрыть"
  },
  PanelText_UI_Summon_Btn_Jump_Text_C_Look_Content = {
    Text = "Просмотреть"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content = {
    Text = "Уровень сложности овладения"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content = {
    Text = "Текущая ориентация"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content = {Text = "Выбор"},
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content = {
    Text = "Позиции заполнены"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content = {
    Text = "Имеется"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Name_Content = {Text = "Имя"},
  PanelText_UI_Summon_Item_Probability_Text_C_Role_Content = {
    Text = "Совокупная вероятность"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Time_Content = {Text = "Имя"},
  PanelText_UI_Summon_Item_Probability_Text_C_Type_Content = {Text = "Тип"},
  PanelText_UI_Summon_Item_Probability_Text_Limit_Content = {
    Text = "Ограничение"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content = {
    Text = "Завершите задание, чтобы получить купон на обмен одеждой"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1_Content = {
    Text = "Обязательно получите двоих"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2_Content = {
    Text = "Обязательно получите все три"
  },
  PanelText_UI_Summon_Panel_Main_Text_Award_Content = {
    Text = "Дополнительное вознаграждение"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content = {
    Text = "Начать выбор"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content = {
    Text = "Уровень сложности овладения"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FirstLimit_Content = {
    Text = "Промо-версия"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content = {
    Text = "Бесплатно"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content = {
    Text = "Можно нажать здесь, чтобы сменить регион"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content = {
    Text = "Очнувшись Часть 5 раз"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Limited_Content = {
    Text = "Ограниченная по времени роль"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Look_Content = {
    Text = "Просмотреть"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Name_Content = {
    Text = "Постоянный"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content = {
    Text = "Избранный мир"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content = {
    Text = "Рекомендуемый Пробудивший"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_School_Intro_Title_Content = {
    Text = "Характеристики границы ——"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content = {
    Text = "Очнувшись 5 раз"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content = {
    Text = "Пробудить"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content = {
    Text = "Пробуждающее тело"
  },
  PanelText_UI_Summon_Panel_Main_Text_Desc_2_Content = {
    Text = "Описание"
  },
  PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content = {
    Text = "Бесплатно"
  },
  PanelText_UI_Summon_Panel_Main_Text_Recommend_Content = {
    Text = "Очнувшись начинающего"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content = {
    Text = "Начать выбор"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content = {
    Text = "Уже указан пробуждённый"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content = {
    Text = "Правила"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content = {
    Text = "Список предметов"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Name_Content = {Text = "Имя"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content = {
    Text = "Вы можете Требование записи о пробуждении за последние 6 месяцев на данной странице, возможна задержка данных примерно на 1 час."
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content = {
    Text = "История записей"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content = {
    Text = "Тип пробуждения"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content = {
    Text = "Время пробуждения"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content = {
    Text = "Тип пробуждения"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content = {Text = "Тип"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Up_Content = {
    Text = "UP предмета"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Name_Content = {Text = "Имя"},
  PanelText_UI_Summon_Popup_Main_Text_C_Not_Content = {
    Text = "Нет записей"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content = {
    Text = "Вы можете Требование записи о пробуждении за последние 6 месяцев на данной странице, возможна задержка данных примерно на 1 час."
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Role_Content = {
    Text = "Тип пробуждения"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Time_Content = {
    Text = "Время пробуждения"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Title_Content = {
    Text = "Очнувшись журнала истории"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Type_Content = {Text = "Тип"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content = {
    Text = "Выбрать заново"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content = {
    Text = "Начать выбор"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content = {
    Text = "Инструкция по игре"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content = {
    Text = "Завершить выбор"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content = {
    Text = "Долгое нажатие на пробуждающее тело для просмотра деталей"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content = {
    Text = "Завершить выбор"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content = {
    Text = "Долгое нажатие на пробуждающее тело для просмотра деталей"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content = {
    Text = "Подарок Колеса Судьбы"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content = {
    Text = "Бонус за пробуждение"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content = {
    Text = "После каждых 150 выполнений \"Исследование царств\" пробуждения, можно дополнительно получить одно из вышеупомянутых: пробуждающее тело или судьбу"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content = {
    Text = "Прогресс"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content = {
    Text = "Просмотреть подробности"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content = {
    Text = "Получить"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content = {
    Text = "Подробное описание"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content = {
    Text = "Список предметов"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Up_Content = {
    Text = "UP предмета"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content = {
    Text = "После выбора границы пробуждение обязательно даст персонажа данного пробуждающего тела, и его можно будет изменить в любое время."
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Title_Content = {
    Text = "Указанный мир"
  },
  PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content = {
    Text = "Вы можете Требование записи о пробуждении за последние 6 месяцев на данной странице, возможна задержка данных примерно на 1 час."
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content = {
    Text = "Начать выбор"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content = {
    Text = "Инструкция по игре"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Summon_Popup_Share_Text_C_Share_Content = {
    Text = "Поделиться с"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content = {
    Text = "Автоматический наложенный Эффект"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content = {
    Text = "Проснись один раз"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content = {
    Text = "Автоматический наложенный Эффект"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content = {
    Text = "Проснись один раз"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content = {
    Text = "Автоматический наложенный Эффект"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content = {
    Text = "Проснись один раз"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_C_Share_Content = {
    Text = "Получите за первый раз поделившись"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content = {
    Text = "Подтвердить"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content = {
    Text = "Перезапустить"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content = {
    Text = "Очнувшись 5 раз"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content = {
    Text = "Быстрое пробуждение"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Name_Content = {
    Text = "Проснись один раз"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Share_Content = {
    Text = "Получите за первый раз поделившись"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content = {
    Text = "Автоматически получить рекомендованное колесо судьбы"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content = {
    Text = "Подтвердить выбор"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content = {
    Text = "Инструкция по игре"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content = {
    Text = "Получить"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Achievement_Content = {
    Text = "Карьерные достижения"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content = {
    Text = "Отчёт о миссии"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content = {
    Text = "Запись о росте"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Master_Content = {
    Text = "Мастерство царства"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips2_Content = {
    Text = "Список задач пуст"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content = {
    Text = "Ежедневные задачи Завершено"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content = {
    Text = "Пока нет заданий"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_C_Undone_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_1_Content = {
    Text = "Текущий прогресс"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content = {
    Text = "Завершение награды"
  },
  PanelText_UI_Task_Popup_Career_Text_C_1_Content = {
    Text = "Текущий прогресс"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Award_Content = {
    Text = "Завершение награды"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Get_Content = {
    Text = "Награда получено"
  },
  PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content = {
    Text = "Все получить"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content = {
    Text = "Достижение \"всё\" разблокировано"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content = {
    Text = "Повышение уровня расследования принесет награду"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content = {
    Text = "Уровень"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Undone1_Content = {
    Text = "Не завершено"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content = {
    Text = "Повышение уровня расследования принесет награду"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content = {
    Text = "Уровень"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content = {
    Text = "Получить"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_1_Content = {Text = "Страж"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content = {
    Text = "Время ввода"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content = {
    Text = "Уровень расследования"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content = {
    Text = "Разблокировать достижение"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_1_Content = {Text = "Страж"},
  PanelText_UI_Task_Popup_Challenge_Text_C_2_Content = {
    Text = "Время ввода"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_3_Content = {
    Text = "Уровень расследования"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content = {
    Text = "Одним кликом получить"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content = {
    Text = "Да направит нас Серебряный ключ"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content = {
    Text = "Ученический сертификат"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content = {
    Text = "Вознаграждение за задание"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Special_Content = {
    Text = "Условия отправки"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Disable_Content = {
    Text = "Запретить"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content = {
    Text = "Тело пробуждения для помощи в бою"
  },
  PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content = {
    Text = "Текущий бой"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content = {
    Text = "Рекомендовать"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content = {
    Text = "*На одно пробуждающее тело можно установить только одну SSR судьбу"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content = {
    Text = "Рекомендовать"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content = {
    Text = "Одним нажатием снять"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Save_Content = {
    Text = "Удержание"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content = {
    Text = "Одним нажатием снять"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content = {
    Text = "Уровень прогресса"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content = {
    Text = "Прогресс транскрипции"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content = {
    Text = "Нет активных Наборных эффектов"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content = {
    Text = "Наборный Эффект"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Added_Content = {
    Text = "Добавить сценарий мистерии"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_2_Content = {Text = "Снять"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content = {
    Text = "Усиление"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content = {
    Text = "Снаряжение"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content = {
    Text = "Текущая часть тела: нет доступных мистерий"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content = {
    Text = "Количество вариантов"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Save_Content = {
    Text = "Добавить сценарий мистерии"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content = {
    Text = "Нет доступных сценариев"
  },
  PanelText_UI_Team_Item_Suit_Text_C_Current_Content = {
    Text = "Текущее использование"
  },
  PanelText_UI_Team_Item_Talent_Text_C_Activate_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content = {
    Text = "Уровень прогресса"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content = {
    Text = "Прогресс транскрипции"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content = {
    Text = "Нет активных Наборных эффектов"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content = {
    Text = "Наборный Эффект"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content = {
    Text = "Выберите Колесо Судьбы снаряжения"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Not_Content = {
    Text = "Не вступило в силу"
  },
  PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content = {
    Text = "Боевая Огромная Огромная Огромная Огромная сила"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content = {
    Text = "Рекомендовать"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content = {
    Text = "Одним нажатием снять"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Save_Content = {
    Text = "Удержание"
  },
  PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content = {
    Text = "Информация о команде"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Activated_Content = {
    Text = "Активировано"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content = {
    Text = "Рекомендуемая область"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "Требования к команде"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Empty_Content = {
    Text = "Не экипирован ключевой приказ"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content = {Text = "Раз"},
  PanelText_UI_Team_Panel_Main_Text_C_Hint_Content = {
    Text = "*После прохождения, пробуждающие тела, круг судьбы и ключевой приказ, задействованные в этом бою, не смогут участвовать в других зонах поглощения катастрофы."
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content = {
    Text = "Осталось применений: экстренный Гнозис"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Name_1_Content = {Text = "Снять"},
  PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content = {
    Text = "Помощь в бою"
  },
  PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content = {
    Text = "Не активировано"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content = {
    Text = "Ключевой приказ запрещён на этом уровне"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Skill_Content = {
    Text = "Призыв"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content = {
    Text = "Информация о команде"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content = {
    Text = "Помощь в бою"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content = {
    Text = "Помощь в бою"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_Content = {
    Text = "Отменить помощь в бою"
  },
  PanelText_UI_Team_Panel_Main_Text_Career_Content = {
    Text = "Требование границы"
  },
  PanelText_UI_Team_Panel_Main_Text_Madness_Content = {
    Text = "Сложность безумия позволяет получить только награду за первый проход"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content = {
    Text = "Удалить план"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content = {
    Text = "План редактирования"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content = {
    Text = "Рекомендуемое снаряжение"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content = {
    Text = "Одним нажатием снять"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content = {
    Text = "Удержание как план"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content = {
    Text = "Рекомендовать"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content = {
    Text = "*На одно пробуждающее тело можно установить только одну SSR судьбу"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_2_Content = {Text = "Снять"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content = {
    Text = "Наложение"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content = {
    Text = "В настоящее время колесо судьбы отсутствует"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content = {
    Text = "Выберите Колесо Судьбы"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content = {
    Text = "Одним нажатием снять"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content = {
    Text = "Свойства"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content = {
    Text = "Информация о пробуждающем теле"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Выберите тело пробуждения"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content = {
    Text = "Подробная информация"
  },
  PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content = {Text = "Выбор"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name01_Content = {Text = "Хаос"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name02_Content = {Text = "Эквор"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name03_Content = {Text = "Каро"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content = {
    Text = "Ультра"
  },
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Профессиональные таланты"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content = {
    Text = "Автоматически получено после первого завершения события"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content = {
    Text = "Награда за первый проход"
  },
  PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content = {
    Text = "Дополнительный ход"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content = {
    Text = "Сортировка с наложением"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content = {
    Text = "Сортировка с наложением"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content = {
    Text = "Порядок"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content = {
    Text = "Порядок"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content = {
    Text = "Нет доступных для экипировки мандалы"
  },
  PanelText__Text_C_Dress_Content = {
    Text = "Переодевание"
  },
  PanelText__Text_C_Dressing_Content = {
    Text = "В одежде"
  },
  PanelText__Text_C_Empty_Content = {
    Text = "Снято с продажи"
  },
  PanelText__Text_C_Goto_Content = {
    Text = "Отправляйся на покупку"
  },
  PanelText__Text_C_Have_Content = {
    Text = "Имеется"
  },
  PanelText__Text_C_Reveal_Content = {
    Text = "Скрыть"
  }
})
return Text_PanelText
