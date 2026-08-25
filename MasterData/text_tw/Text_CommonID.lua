__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "帳戶"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "最高傷害"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "最高層數"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "完成時間"
  },
  CommonID_AchieveType1_Desc = {
    Text = "成長故事"
  },
  CommonID_AchieveType2_Desc = {
    Text = "調查印記"
  },
  CommonID_AchieveType3_Desc = {
    Text = "作戰記錄"
  },
  CommonID_Add_State_Desc = {
    Text = "添加狀態"
  },
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "任務完成條件：觸發過任一劇情節點"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "任務完成條件：分組下任一圖鑒條目解鎖"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "任務完成條件：觸發過任一事件"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "任務完成條件：獲得過任一道具"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "任務完成條件：觸發過任一節點類型"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "任務完成條件：獲得過任一造物"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "任務完成條件：清單中任一關卡首次通關"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "委派增加獎勵"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "屬性提升"
  },
  CommonID_AwakerDied_Desc = {
    Text = "喚醒體死亡"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "喚醒體首領"
  },
  CommonID_BN_Desc = {
    Text = "孟加拉語 (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "不可上陣"
  },
  CommonID_Battle_Desc = {Text = "戰鬥"},
  CommonID_Blue_Desc = {Text = "藍色"},
  CommonID_Boss_Desc = {Text = "首領"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "按鍵綁定"
  },
  CommonID_CN_Desc = {
    Text = "簡體中文"
  },
  CommonID_CardBorder_Desc = {
    Text = "卡牌外觀"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "升級槽位"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "高級意象"
  },
  CommonID_Card_AttachPost_Desc = {Text = "追擊"},
  CommonID_Card_Awake_Desc = {
    Text = "靈知覺醒"
  },
  CommonID_Card_Curse_Desc = {Text = "症狀卡"},
  CommonID_Card_Defend_Desc = {Text = "防禦卡"},
  CommonID_Card_Developing_Desc = {Text = "開發中"},
  CommonID_Card_Fraud_Desc = {Text = "欺詐"},
  CommonID_Card_KeeperSkill_Desc = {Text = "鑰令卡"},
  CommonID_Card_Potion_Desc = {Text = "藥水卡"},
  CommonID_Card_State_Desc = {Text = "狀態卡"},
  CommonID_Card_Strike_Desc = {Text = "打擊卡"},
  CommonID_Card_Weapon_Desc = {Text = "命輪卡"},
  CommonID_CastSkillLevel_Desc = {
    Text = "施法技能等級"
  },
  CommonID_Challenge_Desc = {Text = "調查"},
  CommonID_Change_Skill_Desc = {
    Text = "替換技能"
  },
  CommonID_Chinese_Desc = {Text = "漢語"},
  CommonID_ChooseHandCard_Desc = {
    Text = "選擇手牌"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "點擊退出"
  },
  CommonID_ClickToView_Desc = {
    Text = "點擊查看"
  },
  CommonID_Click_Desc = {
    Text = "點擊跳轉"
  },
  CommonID_Close_Desc = {Text = "關"},
  CommonID_ComingSoon_Desc = {
    Text = "敬請期待"
  },
  CommonID_CommonAttr_Desc = {
    Text = "通用屬性加成"
  },
  CommonID_ContinuousSound_Desc = {
    Text = "持續播放"
  },
  CommonID_CopperAchieve_Desc = {Text = "銅"},
  CommonID_CountingStart_Desc = {
    Text = "我方回合中倒計時開始"
  },
  CommonID_Custom_Desc = {Text = "自訂"},
  CommonID_DE_Desc = {
    Text = "德語 (alpha)"
  },
  CommonID_DPS_Desc = {Text = "傷害型"},
  CommonID_DepressionHit_Desc = {
    Text = "受擊抑鬱"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "禁用命輪"
  },
  CommonID_Display_Desc = {Text = "畫面"},
  CommonID_DropdownList_Desc = {
    Text = "下拉清單"
  },
  CommonID_ES_Desc = {
    Text = "西班牙語 (alpha)"
  },
  CommonID_EmojiType_10_Desc = {
    Text = "小小彌薩格"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "逆轉回合"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "彌薩格日常"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "快樂彌薩格"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "不高興彌薩格"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "校園生活篇"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "課餘時間篇"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "比心彌薩格"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "彌薩格假期"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "軟軟彌薩格"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "冬渡彌薩格"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "薑餅派對"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "校園趣聞"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "彌薩格調查員"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "彌薩格幕間劇"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "團團前夜"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "塵世百相"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "相位通訊"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "閃耀彌薩格"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "發瘋彌薩格"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "輕鬆彌薩格"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "智慧彌薩格"
  },
  CommonID_Entrance_Desc = {
    Text = "彈窗入口"
  },
  CommonID_FR_Desc = {
    Text = "法語 (alpha)"
  },
  CommonID_Forged_Desc = {Text = "強化"},
  CommonID_FreeBattlePos_Desc = {
    Text = "自由上陣"
  },
  CommonID_GetLikeLevel_Desc = {Text = "函數"},
  CommonID_GmaeVoice_Desc = {Text = "遊戲音"},
  CommonID_Hall_Desc = {Text = "大廳"},
  CommonID_HarvestAdd_Desc = {
    Text = "家園增加獎勵"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "任務完成條件：擁有清單中任一喚醒體"
  },
  CommonID_HeadType_1_Desc = {
    Text = "以銀鑰之名"
  },
  CommonID_HeadType_2_Desc = {
    Text = "呆呆檔案照"
  },
  CommonID_HeadType_4_Desc = {
    Text = "典藏郵票"
  },
  CommonID_Holy_Desc = {Text = "聖化"},
  CommonID_ID_Desc = {
    Text = "印尼語 (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "義大利語 (alpha)"
  },
  CommonID_Image_Desc = {Text = "圖像"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "怪物意圖攻擊和強化"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "怪物意圖攻擊和削弱"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "怪物意圖攻擊和削弱"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "怪物意圖攻擊和防禦"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "怪物意圖攻擊"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "怪物意圖強化"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "怪物意圖狂氣非攻擊"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "怪物意圖超級狂氣"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "怪物意圖釋放終結"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "怪物意圖狂氣"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "怪物意圖強化"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "怪物意圖強化"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "怪物意圖削弱"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "怪物意圖防禦和強化"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "怪物意圖防禦和削弱"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "怪物意圖防禦"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "怪物意圖眩暈"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "怪物意圖重攻擊"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "怪物意圖重攻擊"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "怪物意圖強力強化"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "怪物意圖強力削弱"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "怪物意圖不明"
  },
  CommonID_JP_Desc = {
    Text = "日語 (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "韓語 (alpha)"
  },
  CommonID_KeyType_1_Desc = {Text = "忘卻篇"},
  CommonID_KeyType_5_Desc = {
    Text = "超維界域"
  },
  CommonID_Key_Desc = {Text = "按鍵"},
  CommonID_Language_Desc = {Text = "語言"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "等級上限提升"
  },
  CommonID_ManiaHit_Desc = {
    Text = "受擊狂躁"
  },
  CommonID_MasterVolume_Desc = {
    Text = "整體控制"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "返還消耗資源"
  },
  CommonID_Modify_Desc = {
    Text = "點擊修改"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "一檔小怪"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "二檔小怪"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "豐穰母樹"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "多倍經驗強化"
  },
  CommonID_Mute_Desc = {Text = "靜音"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "非喚醒體首領"
  },
  CommonID_Open_Desc = {Text = "開"},
  CommonID_OperationImpossible_Desc = {
    Text = "玩家由於各種原因（算力不足、非己方回合、被封印或石化等）操作不成功（出牌、狂氣爆發）"
  },
  CommonID_OperationStop_Desc = {
    Text = "我方回合思考時長累積到達最大值（配置在常量表中）"
  },
  CommonID_Orange_Desc = {Text = "黃金"},
  CommonID_PT_Desc = {
    Text = "葡萄牙語 (alpha)"
  },
  CommonID_PVP_Desc = {
    Text = "相位對弈"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "被動技能"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "個人檔案"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "遊戲開始，玩家選完牌後"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "守密人檔案"
  },
  CommonID_Potency_Desc = {Text = "啟靈"},
  CommonID_Privacy_Desc = {Text = "隱私"},
  CommonID_Purple_Desc = {Text = "時靈擺"},
  CommonID_RU_Desc = {
    Text = "俄語 (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "紅色光效"
  },
  CommonID_Red_Desc = {Text = "詛咒"},
  CommonID_Redeem_Desc = {
    Text = "前往兌換"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "對方陣營中的喚醒體和我方喚醒體有關係對話"
  },
  CommonID_Repair_Desc = {
    Text = "前往修復"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "需求資源減少"
  },
  CommonID_SUP_Desc = {Text = "輔助型"},
  CommonID_SellCard_Desc = {Text = "賣卡"},
  CommonID_ShortcutKey_Desc = {Text = "快捷鍵"},
  CommonID_SilverAchieve_Desc = {Text = "銀"},
  CommonID_SkillReady_Desc = {
    Text = "狂氣槽滿並可以點擊進行狂氣爆發的瞬間"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "升級技能"
  },
  CommonID_Slider_Desc = {
    Text = "數值滑塊"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "原始槽位等級"
  },
  CommonID_SoundBalance_Desc = {
    Text = "聲音平衡"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "任務完成條件：已觸發指定通訊器對話"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "副本增加產出"
  },
  CommonID_Switch_Desc = {Text = "開關"},
  CommonID_System_Desc = {Text = "系統"},
  CommonID_TH_Desc = {
    Text = "泰語 (alpha)"
  },
  CommonID_TR_Desc = {
    Text = "土耳其語 (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "繁體中文"
  },
  CommonID_T_Desc = {Text = "防禦型"},
  CommonID_TaskCount_Desc = {Text = "計數"},
  CommonID_TaskInProgress_Desc = {Text = "進行中"},
  CommonID_Through1_Desc = {
    Text = "被動技能1"
  },
  CommonID_Through2_Desc = {
    Text = "被動技能2"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "正式翻譯標識"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "狂氣爆發"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "超限狂氣爆發"
  },
  CommonID_VN_Desc = {
    Text = "越南語 (alpha)"
  },
  CommonID_VeryHigh_Desc = {Text = "極高"},
  CommonID_VeryLow_Desc = {Text = "極低"},
  CommonID_Voice_Desc = {Text = "聲音"},
  CommonID_Web_Desc = {
    Text = "網頁跳轉"
  },
  CommonID_White_Desc = {Text = "白銀"},
  CommonID_YellowGlow_Desc = {
    Text = "黃色光效"
  }
})
return Text_CommonID
