--[[
-- added by wsh @ 2017-11-30
-- UI窗口名字定义，手动添加
--]]

UIWindowNames = {
	-- 登陆模块
	UILogin = "UILogin",
	UILoginServer = "UILoginServer",
	UILoginStatute = "UILoginStatute",
	UILoginStatuteDetail = "UILoginStatuteDetail",
	UILoginChoose = "UILoginChoose",
	UILoginGenerateCode = "UILoginGenerateCode",
	UILoginSetLang = "UILoginSetLang",

	UISsLogin = "UISsLogin",
	UISsLoginServer = "UISsLoginServer",
	UIBattleShowRound="UIBattleShowRound",
	UIBattleAwake="UIBattleAwake",
	UIBossEffect="UIBossEffect",
	UIBattlePause = "UIBattlePause",
	UIBattleRevive = "UIBattleRevive",

	UIEditor="UIEditor",
	
	UICompetition="UICompetition",
	-- 场景加载模块
	UILoading = "UILoading",
	UIBlack = "UIBlack",
	-- Tip窗口
	UINoticeTip = "UINoticeTip",
	-- TestMain
	UITestMain = "UITestMain",
	-- BattleMain
	UIBattleMain = "UIBattleMain",
	--初始信息
	UIPlayerInceptionInfo = "UIPlayerInceptionInfo",
	--大厅
	UIHome = "UIHome", --大厅
	
	UIComTop = "UIComTop", --顶部
	
	UILaunchAtk = "UILaunchAtk",--出击面板

	UITestLaunchAtk = "UITestLaunchAtk",
	
	UISelect = "UISelect", --选择面板

	UIThingsDetail = "UIThingsDetail", --  详情界面（角色 物品 装备 敌人）
	UIThingsDetailItem = "UIThingsDetailItem", --  详情界面 物品
	UIThingsDetailBagItem = "UIThingsDetailBagItem", --  详情界面 物品 
	UIThingsDetailCard = "UIThingsDetailCard", --  详情界面 角色
	UIThingsDetailSkin = "UIThingsDetailSkin", --  详情界面 皮肤
	UIThingsDetailFightSoul = "UIThingsDetailFightSoul", --  详情界面 战魂

	UIFormatNew = "UIFormatNew",

	UIFormationChooseCard = "UIFormationChooseCard", -- 编队选择页面

	UIFormationChooseFightSoul = "UIFormationChooseFightSoul", -- 编队选择战魂页面

	UIFormationChooseSupport = "UIFormationChooseSupport", -- 编队选择助战页面

	UIFormationChooseFightSoulProperty = "UIFormationChooseFightSoulProperty", -- 编队选择战魂属性页面
	UISupportCard = "UISupportCard", -- 助战角色详情页面

	UITeamIntens = "UITeamIntens", --队伍强化

	UISummon = "UISummon",--召唤界面

	UIFungusBg = "UIFungusBg",

	UITestTool = "UITestTool",
	UITestBattleLevel = "UITestBattleLevel",
	UITestCurrency = "UITestCurrency",

	UILoad = "UILoad",
    UISkillSkip="UISkillSkip",
	
	UIDialog = "UIDialog",
	UIActivity ="UIActivity",--活动
	UIActivityPop = "UIActivityPop",
	UIShowStarLightList = "UIShowStarLightList",
	UIActivityFightSoulelist = "UIActivityFightSoulelist",
	UIBattleExWei = "UIBattleExWei",
	UIBattleExWeiAtkInfo = "UIBattleExWeiAtkInfo",
	UIGuideGift = "UIGuideGift",

	UISkinGuide = "UISkinGuide",
	
	-- 商店模块
	UIShop = "UIShop", --商店主界面
	UIAllShop = "UIAllShop", --星石商店
	UIGeneralShop = "UIGeneralShop", --通用商店
	UIMagicShop = "UIMagicShop", --魔晶商店
	UIMonthCardShop = "UIMonthCardShop", --月卡商店
	UIPropsForShop = "UIPropsForShop", --道具兑换
	UISandShop = "UISandShop", --星砂商店
	UISkinShop = "UISkinShop", --皮肤商店
	UIStarKingShop = "UIStarKingShop", --星皇点商店
	UITestShop = "UITestShop", --测试商店
	UIStarLightStoneShop = "UIStarLightStoneShop", --星光石商店
	UIActivityWeiShop = "UIActivityWeiShop",
	UIUseItem = "UIUseItem", --使用道具
	UIUseOptionalItem = "UIUseOptionalItem", --使用自选道具
	UIMoreItem = "UIMoreItem", --更多道具
	UIOptionalSkin = "UIOptionalSkin", -- 自选皮肤
	UIRechargePopUp = "UIRechargePopUp", --充值弹窗
	UIShowSkin = "UIShowSkin", --皮肤展示
	UICharacterFragExchange = "UICharacterFragExchange", -- 角色碎片转换
	
	--强化模块
	UIMainIntens = "UIMainIntens",--强化主界面
	UICardIntens = "UICardIntens", --角色强化
	UIEquipIntens = "UIEquipIntens",--装备强化
	UISkin = "UISkin",
	UIBattleArrayIntens = "UIBattleArrayIntens",

	UIEquipInfo = "UIEquipInfo",
	
	--图鉴模块
	UIHandBookMain = "UIHandBookMain",
	UICardHandBook = "UICardHandBook",
	UICardHandBookDetail = "UICardHandBookDetail",
	UIEquipHandBook = "UIEquipHandBook",
	UIFightSoulHandBook = "UIFightSoulHandBook",
	UIFightSoulHandBookDetail = "UIFightSoulHandBookDetail",
	UIRecallHandBook = "UIRecallHandBook",
	UIEnemyHandBook = "UIEnemyHandBook",
	UIEnemyHandBookDetail = "UIEnemyHandBookDetail",
	UIHandBookCG = "UIHandBookCG",
	UIMusicHandBook = "UIMusicHandBook",
	UIStoryHandBook = "UIStoryHandBook",
	UIStoryList = "UIStoryList",
	UIHandBookProperty = "UIHandBookProperty", -- 显示属性
	
	--物品栏
	UIShowProp = "UIShowProp",
	
	--角色选择
	UIShowCard = "UIShowCard",
	UIShowEquip = "UIShowEquip",
	UICardList = "UICardList",

	--提示框
	ToolTipFirst = "ToolTipFirst",
	ToolTipFirstStarLight = "ToolTipFirstStarLight",
	ToolTipFirstPlus ="ToolTipFirstPlus",
	ToolTipSecond = "ToolTipSecond",
	ToolTipThird = "ToolTipThird",
	ToolTipFive="ToolTipFive",
	ToolTipSkin = "ToolTipSkin",
	ToolTipSeven = "ToolTipSeven",
	ToolTipEight = "ToolTipEight",
	ToolTipAddFriend = "ToolTipAddFriend",
	ToolTipGiftBag = "ToolTipGiftBag",
	ToolTipGetItem = "ToolTipGetItem",
	RiskEnter = "RiskEnter",
	ToolTipAddPower = "ToolTipAddPower",
	ToolTipLogin = "ToolTipLogin",
	FastBattle = "FastBattle",
	ToolTipBuffDetail = "ToolTipBuffDetail",
	ToolTipFirstChooseCount = "ToolTipFirstChooseCount",
	
	--描述
	UIDetail = "UIDetail",

	UICardMsg = "UICardMsg",

	UICardFace = "UICardFace",

	UISetting = "UISetting",
	UICodeSetting = "UICodeSetting",
	UIRedeemCode = "UIRedeemCode",

	UITransition = "UITransition",

	UIBattleSettle = "UIBattleSettle",

	UISupport = "UISupport",

	UIBuffGlances = "UIBuffGlances",
	UIBuffDetails = "UIBuffDetails",
	UISkillToast = "UISkillToast",
	UISkillFightSoul = "UISkillFightSoul",
	UIBattlePlayerInfo = "UIBattlePlayerInfo",
	UIBattleStatus = "UIBattleStatus",

	UIRisk = "UIRisk",
	
	UIRoom = "UIRoom",

	UIFriend = "UIFriend",

	UIDailyReward = "UIDailyReward", -- 每日签到奖励页面

	UITask = "UITask",

	UIPostBox = "UIPostBox",

	UIInform = "UIInform",

	UIProp = "UIProp",
	UIBattleMode = "UIBattleMode",
	UISevenStar = "UISevenStar",
	UINoviceGuide="UINoviceGuide",
	UILordMode = "UILordMode",
	UILordRoad = "UILordRoad",
	UILordTower = "UILordTower",
	UILordLand = "UILordLand",
	UIBattleLose = "UIBattleLose",
	UISummonTip = "UISummonTip",
	UILaunchAtkBg = "UILaunchAtkBg",
	
	UISummonStage1 = "UISummonStage1",
	UISummonStage2 = "UISummonStage2",
	UISummonStage3 = "UISummonStage3",
	UISummonFormula = "UISummonFormula",
	
	UIPlayerInfo = "UIPlayerInfo",
	UIRoleInfo = "UIRoleInfo",
	UISoundSet = "UISoundSet",
	UINameEdit = "UINameEdit",
	UISetIcon = "UISetIcon",
	UICardSort = "UICardSort",
	UIEquipSort1 = "UIEquipSort1",
	UIEquipSort2 = "UIEquipSort2",
	UIChallenge = "UIChallenge",
	UIChallenge1 = "UIChallenge1",
	UIChallenge2 = "UIChallenge2",
	UIChallenge3 = "UIChallenge3",
	UIChallenge4 = "UIChallenge4",
	UIChallengeSectionInfo = "UIChallengeSectionInfo",

	UIStoryChapter = "UIStoryChapter",

	UIHelpText = "UIHelpText",
	UICompetitionPlayerInfo = "UICompetitionPlayerInfo",
	UIEquipState = "UIEquipState",
	UIReward = "UIReward",
	UIShowPaint = "UIShowPaint",
	
	UIEquipChangeState1 = "UIEquipChangeState1",
	UIEquipChangeState2 = "UIEquipChangeState2",
	
	UIEquipLvUpState1 = "UIEquipLvUpState1",
	UIEquipLvUpState2 = "UIEquipLvUpState2",
	UIEquipResolveProp = "UIEquipResolveProp",

	UIEquipLevelUp = "UIEquipLevelUp",
	UIEquipScrap = "UIEquipScrap",
	UIChooseEquip = "UIChooseEquip",

	UIOriginalPainting = "UIOriginalPainting",

	UILive2d = "UILive2d",

	UIGetMarried = "UIGetMarried",

	UICardEvolve = "UICardEvolve",

	UICardLvUp = "UICardLvUp",

	UICardLimit = "UICardLimit",

	UICardLvUpStage1 = "UICardLvUpStage1",

	UICardEvolveStage1 = "UICardEvolveStage1",

	UICardEvolveStage2 = "UICardEvolveStage2",

	UICardEvolveStage3 = "UICardEvolveStage3",

	UICardLimitStage1 = "UICardLimitStage1",

	UICardLimitStage2 = "UICardLimitStage2",

	UICardFriendlyMax = "UICardFriendlyMax",

	UISkipHint = "UISkipHint",

	UIEquipRecastFormula = "UIEquipRecastFormula",

	UIStorySectionInfo = "UIStorySectionInfo",

	UISevenStarSectionInfo = "UISevenStarSectionInfo",

	UILordRoadSectionInfo = "UILordRoadSectionInfo",

	UILordTowerSectionInfo = "UILordTowerSectionInfo",
	UILordLandSectionInfo = "UILordLandSectionInfo",

	UIEquipProp = "UIEquipProp",

	UIEchoChromeSettle = "UIEchoChromeSettle",

	UIExpedition = "UIExpedition",

	UIExpeditionTip = "UIExpeditionTip",

	UIExpeditionSelectCard = "UIExpeditionSelectCard",

	UIMoreSetting = "UIMoreSetting",

	UIFightSoulMain = "UIFightSoulMain",
	UIFightSoulLevelUp = "UIFightSoulLevelUp",
	UIFightSoulIntens = "UIFightSoulIntens",
	UIFightSoulDecompose = "UIFightSoulDecompose", -- 战魂分解
	UIFightSoulMergeMaterials = "UIFightSoulMergeMaterials", -- 融合材料选择
	UIFightSoulInfo = "UIFightSoulInfo", -- 无预制体 准备删除
	UIFightSoulState = "UIFightSoulState", -- 状态(是否装备 是否锁定 查看星级)
	UIFightSoulSort = "UIFightSoulSort", -- 筛选弹窗
	UIFightSoulFilter = "UIFightSoulFilter", -- 筛选弹窗
	UIFightSoulMerge = "UIFightSoulMerge", -- 融合
	UIFightSoulList = "UIFightSoulList", -- 列表 (左边列表, 右边信息 就是那个选择页面)
	UIFightSoulChangeState1 = "UIFightSoulChangeState1", -- 替换页面
	UIFightSoulChangeState2 = "UIFightSoulChangeState2", -- 确认替换
	UIFightSoulFuse = "UIFightSoulFuse", -- 战魂融合动画1
	UIFightSoulFuseStage1 = "UIFightSoulFuseStage1", -- 融合动画2
	UIFightSoulFuseStage2 = "UIFightSoulFuseStage2", -- 融合动画3
	UIFightSoulFormula = "UIFightSoulFormula",   -- 融合介绍
	UIShowFightSoulProp = "UIShowFightSoulProp",

	---通用关卡
	UICommonLevel = "UICommonLevel",

	UIGameEventMain = "UIGameEventMain",

	-- 通行证
	UIBattlePass = "UIBattlePass",
	UIBattlePassLevelUp = "UIBattlePassLevelUp",
	UIBattlePassBuyLevel = "UIBattlePassBuyLevel",
	UIBattlePassBuyPass = "UIBattlePassBuyPass",
	UIBattlePassReward = "UIBattlePassReward",


	-- 总力战
	UIBossraid = "UIBossraid",
	UIBossraidTeamInfo = "UIBossraidTeamInfo",
	UIBossraidSectionInfo = "UIBossraidSectionInfo",
	UIBossraidChooseCard = "UIBossraidChooseCard",

	-- 剧情活动
	UIGameEventLevelMain = "UIGameEventLevelMain",
	UIGameEventLevel2Main = "UIGameEventLevel2Main",
	UIGameEventLevelTask = "UIGameEventLevelTask",
	UIGameEventLevelExLevel = "UIGameEventLevelExLevel",
	UIGameEventLevelStore = "UIGameEventLevelStore",
	UIGameEventLevelRateUp = "UIGameEventLevelRateUp",
}

--return ConstClass("UIWindowNames", UIWindowNames)
