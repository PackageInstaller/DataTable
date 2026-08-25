__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "账户"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "最高伤害"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "最高层数"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "完成时间"
  },
  CommonID_AchieveType0_Desc = {
    Text = "全部成就"
  },
  CommonID_AchieveType1_Desc = {
    Text = "成长故事"
  },
  CommonID_AchieveType2_Desc = {
    Text = "调查印记"
  },
  CommonID_AchieveType3_Desc = {
    Text = "作战记录"
  },
  CommonID_AchieveType4_Desc = {
    Text = "守密生涯"
  },
  CommonID_Add_State_Desc = {
    Text = "添加状态"
  },
  CommonID_All_Desc = {Text = "所有"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "任务完成条件：触发过任一剧情节点"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "任务完成条件：分组下任一图鉴条目解锁"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "任务完成条件：触发过任一事件"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "任务完成条件：获得过任一道具"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "任务完成条件：触发过任一节点类型"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "任务完成条件：获得过任一造物"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "任务完成条件：列表中任一关卡首次通关"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "委派增加奖励"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "属性提升"
  },
  CommonID_AwakerDied_Desc = {
    Text = "唤醒体死亡"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "唤醒体首领"
  },
  CommonID_BN_Desc = {
    Text = "孟加拉语 (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "不可上阵"
  },
  CommonID_Battle_Desc = {Text = "战斗"},
  CommonID_Blue_Desc = {Text = "蓝色"},
  CommonID_Boss_Desc = {Text = "首领"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "按键绑定"
  },
  CommonID_CN_Desc = {
    Text = "简体中文"
  },
  CommonID_CardBorder_Desc = {
    Text = "卡牌外观"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "升级槽位"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "高级意象"
  },
  CommonID_Card_AttachPost_Desc = {Text = "追击"},
  CommonID_Card_Awake_Desc = {
    Text = "灵知觉醒"
  },
  CommonID_Card_Curse_Desc = {Text = "症状卡"},
  CommonID_Card_Defend_Desc = {Text = "防御卡"},
  CommonID_Card_Developing_Desc = {Text = "开发中"},
  CommonID_Card_Extend_Desc = {Text = "衍生卡"},
  CommonID_Card_Fraud_Desc = {Text = "欺诈"},
  CommonID_Card_Imagery_Desc = {Text = "意象"},
  CommonID_Card_KeeperSkill_Desc = {Text = "钥令卡"},
  CommonID_Card_Potion_Desc = {Text = "药水卡"},
  CommonID_Card_Skill_Desc = {Text = "技能卡"},
  CommonID_Card_State_Desc = {Text = "状态卡"},
  CommonID_Card_Strike_Desc = {Text = "打击卡"},
  CommonID_Card_Weapon_Desc = {Text = "命轮卡"},
  CommonID_CastSkillLevel_Desc = {
    Text = "施法技能等级"
  },
  CommonID_Challenge_Desc = {Text = "调查"},
  CommonID_Change_Skill_Desc = {
    Text = "替换技能"
  },
  CommonID_Chinese_Desc = {Text = "汉语"},
  CommonID_ChooseHandCard_Desc = {
    Text = "选择手牌"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "点击退出"
  },
  CommonID_ClickToView_Desc = {
    Text = "点击查看"
  },
  CommonID_Click_Desc = {
    Text = "点击跳转"
  },
  CommonID_Close_Desc = {Text = "关"},
  CommonID_ComingSoon_Desc = {
    Text = "敬请期待"
  },
  CommonID_CommonAttr_Desc = {
    Text = "通用属性加成"
  },
  CommonID_Common_Desc = {Text = "普通"},
  CommonID_ContinuousSound_Desc = {
    Text = "持续播放"
  },
  CommonID_CopperAchieve_Desc = {Text = "铜"},
  CommonID_CountingStart_Desc = {
    Text = "我方回合中倒计时开始"
  },
  CommonID_Custom_Desc = {Text = "自定义"},
  CommonID_DE_Desc = {
    Text = "德语 (alpha)"
  },
  CommonID_DPS_Desc = {Text = "伤害型"},
  CommonID_DepressionHit_Desc = {
    Text = "受击抑郁"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "禁用主角技能"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "禁用密契"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "禁用命轮"
  },
  CommonID_Display_Desc = {Text = "画面"},
  CommonID_DropdownList_Desc = {
    Text = "下拉列表"
  },
  CommonID_EN_Desc = {
    Text = "English (beta)"
  },
  CommonID_ES_Desc = {
    Text = "西班牙语 (alpha)"
  },
  CommonID_Elite_Desc = {Text = "精英"},
  CommonID_EmojiType_10_Desc = {
    Text = "小小弥萨格"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "逆转回合"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "弥萨格日常"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "快乐弥萨格"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "不高兴弥萨格"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "校园生活篇"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "和平的一天"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "课余时间篇"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "比心弥萨格"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "弥萨格假期"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "软软弥萨格"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "冬渡弥萨格"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "姜饼派对"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "校园趣闻"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "弥萨格调查员"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "弥萨格幕间剧"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "沙耶之歌"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "团团前夜"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "尘世百相"
  },
  CommonID_EmojiType_4_Desc = {Text = "忘Q前夜"},
  CommonID_EmojiType_5_Desc = {
    Text = "相位通讯"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "闪耀弥萨格"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "发疯弥萨格"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "轻松弥萨格"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "智慧弥萨格"
  },
  CommonID_Enchant_Desc = {Text = "刻印"},
  CommonID_Entrance_Desc = {
    Text = "弹窗入口"
  },
  CommonID_FALSE_Desc = {Text = "否"},
  CommonID_FR_Desc = {
    Text = "法语 (alpha)"
  },
  CommonID_Forged_Desc = {Text = "强化"},
  CommonID_FreeBattlePos_Desc = {
    Text = "自由上阵"
  },
  CommonID_FullScreen_Desc = {Text = "全屏"},
  CommonID_Gender_Boy_Desc = {Text = "男"},
  CommonID_Gender_Girl_Desc = {Text = "女"},
  CommonID_GetLikeLevel_Desc = {Text = "函数"},
  CommonID_GmaeVoice_Desc = {Text = "游戏音"},
  CommonID_GoldAchieve_Desc = {Text = "金"},
  CommonID_Hall_Desc = {Text = "大厅"},
  CommonID_HarvestAdd_Desc = {
    Text = "家园增加奖励"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "任务完成条件：拥有列表中任一唤醒体"
  },
  CommonID_HeadType_1_Desc = {
    Text = "以银钥之名"
  },
  CommonID_HeadType_2_Desc = {
    Text = "呆呆档案照"
  },
  CommonID_HeadType_3_Desc = {
    Text = "永不褪色的昨天"
  },
  CommonID_HeadType_4_Desc = {
    Text = "典藏邮票"
  },
  CommonID_High_Desc = {Text = "高"},
  CommonID_Holy_Desc = {Text = "圣化"},
  CommonID_ID_Desc = {
    Text = "印尼语 (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "意大利语 (alpha)"
  },
  CommonID_Image_Desc = {Text = "图像"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "怪物意图攻击和强化"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "怪物意图攻击和削弱"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "怪物意图攻击和削弱"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "怪物意图攻击和防御"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "怪物意图攻击"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "怪物意图强化"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "怪物意图狂气非攻击"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "怪物意图超级狂气"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "怪物意图释放终结"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "怪物意图狂气"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "怪物意图强化"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "怪物意图强化"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "怪物意图削弱"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "怪物意图防御和强化"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "怪物意图防御和削弱"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "怪物意图防御"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "怪物意图眩晕"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "怪物意图重攻击"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "怪物意图重攻击"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "怪物意图强力强化"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "怪物意图强力削弱"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "怪物意图不明"
  },
  CommonID_ItemManagement_Desc = {Text = "物品"},
  CommonID_JP_Desc = {
    Text = "日语 (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "韩语 (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "主角技能"
  },
  CommonID_KeyType_1_Desc = {Text = "忘却篇"},
  CommonID_KeyType_2_Desc = {
    Text = "混沌界域"
  },
  CommonID_KeyType_3_Desc = {
    Text = "深海界域"
  },
  CommonID_KeyType_4_Desc = {
    Text = "血肉界域"
  },
  CommonID_KeyType_5_Desc = {
    Text = "超维界域"
  },
  CommonID_Key_Desc = {Text = "按键"},
  CommonID_Language_Desc = {Text = "语言"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "等级上限提升"
  },
  CommonID_Low_Desc = {Text = "低"},
  CommonID_Management_Desc = {
    Text = "前往管理"
  },
  CommonID_ManiaHit_Desc = {
    Text = "受击狂躁"
  },
  CommonID_MasterVolume_Desc = {
    Text = "整体控制"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "返还消耗资源"
  },
  CommonID_MessagePush_Desc = {
    Text = "消息推送"
  },
  CommonID_Middle_Desc = {Text = "中"},
  CommonID_Modify_Desc = {
    Text = "点击修改"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "一档小怪"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "二档小怪"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "丰穰母树"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "多倍经验强化"
  },
  CommonID_Mute_Desc = {Text = "静音"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "非唤醒体首领"
  },
  CommonID_Open_Desc = {Text = "开"},
  CommonID_OperationImpossible_Desc = {
    Text = "玩家由于各种原因（算力不足、非己方回合、被封印或石化等）操作不成功（出牌、狂气爆发）"
  },
  CommonID_OperationStop_Desc = {
    Text = "我方回合思考时长累积到达最大值（配置在常量表中）"
  },
  CommonID_Orange_Desc = {Text = "黄金"},
  CommonID_PT_Desc = {
    Text = "葡萄牙语 (alpha)"
  },
  CommonID_PVP_Desc = {
    Text = "相位对弈"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "被动技能"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "个人档案"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "游戏开始，玩家选完牌后"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "守密人档案"
  },
  CommonID_Potency_Desc = {Text = "启灵"},
  CommonID_Privacy_Desc = {Text = "隐私"},
  CommonID_Purple_Desc = {Text = "时灵摆"},
  CommonID_RU_Desc = {
    Text = "俄语 (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "红色光效"
  },
  CommonID_Red_Desc = {Text = "诅咒"},
  CommonID_Redeem_Desc = {
    Text = "前往兑换"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "对方阵营中的唤醒体和我方唤醒体有关系对话"
  },
  CommonID_Relic_Desc = {Text = "造物"},
  CommonID_Repair_Desc = {
    Text = "前往修复"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "需求资源减少"
  },
  CommonID_SUP_Desc = {Text = "辅助型"},
  CommonID_SellCard_Desc = {Text = "卖卡"},
  CommonID_ShortcutKey_Desc = {Text = "快捷键"},
  CommonID_SilverAchieve_Desc = {Text = "银"},
  CommonID_Sin_Desc = {Text = "原罪"},
  CommonID_SkillReady_Desc = {
    Text = "狂气槽满并可以点击进行狂气爆发的瞬间"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "升级技能"
  },
  CommonID_Slider_Desc = {
    Text = "数值滑块"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "原始槽位等级"
  },
  CommonID_SoundBalance_Desc = {
    Text = "声音平衡"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "任务完成条件：已触发指定通讯器对话"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "副本增加产出"
  },
  CommonID_Switch_Desc = {Text = "开关"},
  CommonID_System_Desc = {Text = "系统"},
  CommonID_TH_Desc = {
    Text = "泰语 (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "是"},
  CommonID_TR_Desc = {
    Text = "土耳其语 (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "繁体中文"
  },
  CommonID_T_Desc = {Text = "防御型"},
  CommonID_TaskCount_Desc = {Text = "计数"},
  CommonID_TaskInProgress_Desc = {Text = "进行中"},
  CommonID_TaweiMonster_Desc = {Text = "暗塔薇"},
  CommonID_Through1_Desc = {
    Text = "被动技能1"
  },
  CommonID_Through2_Desc = {
    Text = "被动技能2"
  },
  CommonID_Tips_Desc = {Text = "提示"},
  CommonID_TranslationLabel_Desc = {
    Text = "正式翻译标识"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "狂气爆发"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "超限狂气爆发"
  },
  CommonID_VN_Desc = {
    Text = "越南语 (alpha)"
  },
  CommonID_VeryHigh_Desc = {Text = "极高"},
  CommonID_VeryLow_Desc = {Text = "极低"},
  CommonID_View_Desc = {
    Text = "前往查看"
  },
  CommonID_Voice_Desc = {Text = "声音"},
  CommonID_Web_Desc = {
    Text = "网页跳转"
  },
  CommonID_White_Desc = {Text = "白银"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "窗口未聚焦音效"
  },
  CommonID_Window_Desc = {Text = "窗口"},
  CommonID_YellowGlow_Desc = {
    Text = "黄色光效"
  }
})
return Text_CommonID
