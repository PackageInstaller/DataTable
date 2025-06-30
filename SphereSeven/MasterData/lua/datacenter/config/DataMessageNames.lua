--[[
-- added by wsh @ 2017-12-05
-- 数据消息定义，手动添加
--]]

DataMessageNames = {
	ON_ACCOUNT_INFO_CHG = "DataOnAccountInfoChg",
	ON_LOGIN_SERVER_ID_CHG = "DataOnLoginServerIDChg",
	ON_SERVER_LIST_CHG = "DataOnServerListChg",
	
	ON_ENTER_GAME_INFO_CHG = "OnEnterGameInfoChg",

	ON_LOGIN_ACCOUNT_SERVER_SUCCEED = "OnLoginAccountServerSucceed",
	ON_Guide_CHG = "ON_Guide_CHG",--引导状态改变
	ON_Guide_Click = "ON_Guide_Click", --点击事件
	ON_Guide_CHG_MIN = "ON_Guide_CHG_MIN", --引导在步骤内改变
	
	--主界面
	ON_HOME_CARD_RECT_CHG = "OnHomeCardRectChg",--设置主界面角色位置 大小
	ON_SCENE_CHG = "OnSceneChg",--界面变动

	--个人信息变动
	ON_PLAYER_INFO_CHG = "OnPlayerInfoChg",
	ON_ROLE_INFO_UPDATE = "OnRoleInfoUpdate", -- 新版 个人信息变动

	ON_NAME_CHANGED = "OnNameChanged", --名字改变

	--ON_UI_TOP_CHG = "OnUITopChg",

	ON_PLAY_TOP_FADE = "OnPlayerTopFade",

	ON_MAIN_UI_CARD_CHG = "OnMainUICardChg",

	--寝宫信息变动
	ON_ROOM_INFO_CHG = "OnRoomInfoChg",
	--抽卡信息变动
	ON_SUMMON_INFO_CHG = "OnSummonInfoChg",
	ON_SUMMON_COMPONENT_CHG = "OnSummonComponentChg",

	ON_READY_TO_RECRUIT = "OnReadyToRecruit", --召唤结果界面点击继续召唤
	ON_RECRUIT_UPDATE = "OnRecruitUpdate", -- 抽卡更新

	ON_BD_INFO_CHG = "OnBdInfoChg",--魑魅幽魂碎片兑换
	ON_ACTIVITY_FIGHTSOULE_CHG = "ON_ACTIVITY_FIGHTSOULE_CHG",--开服战魂活动兑换奖励
	ON_PAID_STARSTONE_CHG = "ON_PAID_STARSTONE_CHG",--星光石获取总数改变
	ON_ACTIVITY_LOGIN_CHG = "OnActivityLoginChg",--限时每日登录活动

	ON_GAME_EVENT_UPDATE = "OnGameEventUpdate", -- 活动更新

	--月卡信息变动
	ON_MONTH_CARD_INFO_CHG = "OnMonthCardInfoChg",
	
	--星光石购买信息变动
	ON_STAR_LIGHT_INFO_CHG = "OnStarLightInfoChg",
	--星光石返利活动
	ON_STAR_LIGHT_REBATE_CHG = "OnStarLightRebateChg",
	
	--日限购变动
	ON_DAY_PURCHASE_INFO_CHG = "OnDayPurchaseInfoChg",

	--周限购变动
	ON_WEEK_PURCHASE_INFO_CHG = "OnWeekPurchaseInfoChg",

	--月限购变动
	ON_MONTH_PURCHASE_INFO_CHG = "OnMonthPurchaseInfoChg",

	--争霸信息
	ON_COMPETITION_INFO_CHG = "OnCompetitionInfoChg",

	ON_CHALLENGER_UPDATE = "OnChallengerUpdate", --挑战者更新

	ON_ARENA_RECORD_UPDATE = "OnArenaRecordUpdate", --竞技场记录更新
	ON_ARENA_UPDATE = "OnArenaUpdate", --竞技场数据更新
	--角色信息变动
	ON_CARD_INFO_CHG = "OnCardInfoChg",
	ON_CHARACTER_UPDATE_PUSH = "OnCharacterUpdatePush",

	--装备信息变动
	ON_EQUIP_INFO_CHG = "OnEquipInfoChg",
	
	ON_EQUIP_UPDATE = "OnEquipUpdate", --装备更新

	--物品信息变动
	ON_ITEM_INFO_CHG = "OnItemInfoChg",

	ON_ITEM_DATA_UPDATE = "OnItemDataUpdate",
	
	--皮肤变动
	ON_SKIN_INFO_CHG = "OnSkinInfoChg",
	
	--战魂变动
	ON_FIGHTSOUL_INFO_CHG = "OnFightSoulChg", 

	ON_FIGHTSOUL_DATA_UPDATE = "OnFightSoulDataUpdate", --战魂更新
	
	--出击界面  
	ON_MAIN_STORY_CHG = "OnMainStoryChg",
	ON_STORY_DIFF_CHG = "OnStoryDiffcultyChg", --难度改变
	ON_STORY_SECTION_CHG = "OnStorySectionChg", --

	ON_TEST_COMPLETED_CHG = "OnTestCompletedChg",

	--七星模式
	ON_SEVEN_STAR_MODE_CHG = "OnSevenStarChg",
	ON_SEVEN_STAR_COUNT_CHG = "ONSevenStarCountChg",
	
	--编成界面
	ON_FORMAT_ARRAY_CHG = "OnFormatArrayChg", --队伍改变
	ON_FORMAT_DATA_CHG = "OnFormatDataChg", --数据改变  -- gh: 准备删掉
	ON_FORMATION_DATA_UPDATE = "OnFormationDataUpdate",

	ON_SUPPORT_CHG = "OnSupportChg",
	
	--选择战阵
	ON_SELECT_BATTLE_ARRAY_DATA_CHG = "OnSelectBattleArrayDataChg",

	ON_BATTLE_ARRAY_CHG = "OnBattleArrayChg",
	ON_ENHANCETYPE_CHG = "OnEnhanceTypeChg",

	ON_FUNGUS_CHG = "OnFungusChng",
	
	
	ON_BGM_VOLUME_CHG = "OnBgmVolumeChg",
	ON_SOUND_VOLUME_CHG = "OnSoundVolumeChg",
	ON_CARD_VOLUME_CHG="ON_CARD_VOLUME_CHG",

	ON_BuffGlances_CHG = "ON_BuffGlances_CHG",

	ON_SLEEP_BUFF_CHG = "OnSleepBuffChg", --侍寝buff
	ON_REST_BUFF_CHG = "OnRestBuffChg", -- 休息buff
	
	ON_TASK_DATA_CHG = "OnTaskDataChg", --任务数据

	ON_TASK_UPDATE = "OnTaskUpdate", --任务更新
	ON_REFRESH_TASK = "OnRefreshTask", --刷新任务界面

	ON_POST_BOX_CHG = "OnPostBoxChg",

	ON_LORD_TOWER_DIFF_CHG = "OnLordTowerDiffChg",
	ON_CHALLENGE_DIFF_CHG = "OnChallengeDiffChg",

	ON_FRIEND_UPDATE = "OnFriendUpdate", --好友更新
	ON_FRIEND_REQUEST_UPDATE = "OnFriendRequestUpdate", --好友申请更新

	ON_AFFICHE_INFO_CHG = "OnAfficheInfoChg", --公告

	ON_UI_TRANSIT = "OnUITransit",
	LAUNCHATK_BLUR = "LaunchAtkBlur",

	--界面变动消息
	ON_READY_OPEN = "OnReadyOpen",
	ON_LAUNCH_OPEN = "OnLaunchOpen",
	ON_FORMAT_OPEN = "OnFormatOpen",

	ON_LANG_TYPE_CHG = "OnLangTypeChg",--更改语言
	
	--每日0点
	ON_TIME_RESET = "OnTimeReset",

	-- 猫呢
	ON_RISK_PLAY_POS = "OnRiskPlayPOS",

	-- 跑马灯推送
	ON_DMBANNER_PUSH = "OnDMBannerPush",

	-- 远征选择卡
	ON_EXP_SELECTCARD = "OnExpSelectCard",

	-- 图鉴系统
	ON_ENCYCLOPEDIA_UPDATE = "OnEncyclopediaUpdate",

	--- 每日签到
	ON_DAILY_REWARD_UPDATE = "OnDailyRewardUpdate",

	--- 通用签到(check in)
	ON_CHECK_IN_UPDATE = "OnCheckInUpdate",

	--- 每天刷新
	ON_DAILY_UPDATE_PUSH = "OnDailyUpdatePush",

	ON_PASS_UPDATE_PUSH = "OnPassUpdatePush", -- 通行证更新

	ON_BOSSRAID_UPDATE_PUSH = "OnBossRaidUpdatePush", -- bossraid 更新
}

--return ConstClass("DataMessageNames", DataMessageNames)