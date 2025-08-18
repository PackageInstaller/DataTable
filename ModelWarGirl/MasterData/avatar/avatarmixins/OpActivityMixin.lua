-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivityMixin.lua

local OpActivityObject = require("Avatar/AvatarMixins/OpActivity/OpActivityObject")
local EventConst = require("EventConst")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResActivityMainTabConfig = require("ClientData/ResActivityMainTabConfig")
local ResActivityMainConfig = require("ClientData/ResActivityMainConfig")
local ResOpActivityDetail = require("ClientData/ResOpActivityDetail")
local ResItem = require("ClientData/ResItem")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local ResActivityClientNewOpen = require("ClientData/ResActivityClientNewOpen")
local ResActivityArtifactNewOpen = require("ClientData/ResActivityArtifactNewOpen")
local ResOpActivityPrivilegeDetail = require("ClientData/ResOpActivityPrivilegeDetail")
local ResCardClient = require("ClientData/ResCardClient")
local ResRefluxOnceAward = require("ClientData/ResRefluxOnceAward")
local UserData = require("Helper/UserData")
local ResActivityRebackConfig = require("ClientData/ResActivityRebackConfig")
local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResActivityPlayNodeConfig = require("ClientData/ResActivityPlayNodeConfig")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local ResChannelHideActivityConfig = require("ClientData/ResChannelHideActivityConfig")
local ResActivityPushConfig = require("ClientData/ResActivityPushConfig")
local ResRecharge = require("ClientData/ResRecharge")
local ResRechargeGiftDraw = require("ClientData/ResRechargeGiftDraw")
local ResPushGiftPkg = require("ClientData/ResPushGiftPkg")
local ResActivityClientGiftCell = require("ClientData/ResActivityClientGiftCell")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local OpActivityMixin = {}
local ActivitySingleGiftPage = require("UI/OpActivity/ActivitySingleGiftPage")
local ActivityMonthCardGiftPage = require("UI/OpActivity/ActivityMonthCardGiftPage")
local ActivityAchieveCapPage = require("UI/OpActivity/ActivityAchieveCapPage")
local ActivityAchieveStagePage = require("UI/OpActivity/ActivityAchieveStagePage")
local ActivityAchieveWithRechargePage = require("UI/OpActivity/ActivityAchieveWithRechargePage")
local ActivityAchieveDicPage = require("UI/OpActivity/ActivityAchieveDicPage")
local ActivitySignInPage = require("UI/OpActivity/ActivitySignInPage")
local ActivityMainBannerPage = require("UI/OpActivity/ActivityMainBannerPage")
local ActivityPushGiftPage = require("UI/OpActivity/ActivityPushGiftPage")
local ActFirstRecGiftPage = require("UI/OpActivity/ActFirstRecGiftPage")
local ActivityShopPage = require("UI/OpActivity/ActivityShopPage")
local ActivityShopLevelPage = require("UI/OpActivity/ActivityShopLevelPage")
local ActivitySimpleShowPage = require("UI/OpActivity/ActivitySimpleShowPage")
local ActivityNewHeroShowPage = require("UI/OpActivity/ActivityNewHeroShowPage")
local ActivityNmlSigninPage = require("UI/OpActivity/ActivityNmlSigninPage")
local ActivitDoubleGiftPage = require("UI/OpActivity/ActivitDoubleGiftPage")
local ActivitRelatedHeroGiftPage = require("UI/OpActivity/ActivitRelatedHeroGiftPage")
local ActivityAchieveMaxRound = require("UI/OpActivity/ActivityAchieveMaxRound")
local ActivityLotteryPage = require("UI/OpActivity/ActivityLotteryPage")
local ActivitySimpleAchievePage = require("UI/OpActivity/ActivitySimpleAchievePage")
local ActivityAchieveChristmas = require("UI/OpActivity/ActivityAchieveChristmas")
local ActivityHatsuneMikuShare = require("UI/OpActivity/ActivityHatsuneMikuShare")
local ActivityFireplacePage = require("UI/OpActivity/ActivityFireplacePage")
local ActivityTickSignInPage = require("UI/OpActivity/ActivityTickSignInPage")
local ActivityBPGiftPage = require("UI/OpActivity/ActivityBPGiftPage")
local ActivityShowSkinPage = require("UI/OpActivity/ActivityShowSkinPage")
local ActivityShowBadgePage = require("UI/OpActivity/ActivityShowBadgePage")
local ActivityChangePackagePage = require("UI/OpActivity/ActivityChangePackagePage")
local ActivityShopPanel = require("UI/Welfare/ActivityShopPanel")
local ActivitySkinLotteryGiftPanel = require("UI/OpActivity/ActivitySkinLotteryGiftPanel")
local ActivityCollectWordsDlg = require("UI/OpActivity/ActivityCollectWordsDlg")
local ActivityMutiAchieveObjPage = require("UI/OpActivity/ActivityMutiAchieveObjPage")
local ActivityBPPage = require("UI/OpActivity/ActivityBPPage")
local ActivityGiftAchieve = require("UI/OpActivity/Achieve/ActivityGiftAchieve")
local ActivityPredictAchieve = require("UI/OpActivity/Achieve/ActivityPredictAchieve")
local ActivityLuckyStarAchieve = require("UI/OpActivity/Achieve/ActivityLuckyStarAchieve")
local ActivityRelatedHeroGiftNewPage = require("UI/OpActivity/ActivityRelatedHeroGiftNewPage")
local ActivityMultiRoundLotteryPage = require("UI/OpActivity/ActivityMultiRoundLotteryPage")
local ActivityFullServerAchievePanel = require("UI/OpActivity/ActivityFullServerAchievePanel")
local ActivityBuyGiftDrawPanel = require("UI/OpActivity/ActivityBuyGiftDrawPanel")
local ActivityGiftCellPage = require("UI/OpActivity/ActivityGiftCellPage")
local ActivityNewcomerBPGiftPanel = require("UI/OpActivity/NewcomerBP/ActivityNewcomerBPGiftPanel")

UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER = 1
UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW = 2
UIConst.ACTIVITY_SHOW_GROUP = {
	SKIN = 1
}
UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG = {
	ActivityMainBannerPage = {
		ActivityMainBannerPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityAchieveStage = {
		ActivityAchieveStagePage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityAchiveCap = {
		ActivityAchieveCapPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityAchieveDice = {
		ActivityAchieveDicPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityAchieveMaxRound = {
		ActivityAchieveMaxRound,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityAchieveWithRechargePage = {
		ActivityAchieveWithRechargePage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityAchieveChristmas = {
		ActivityAchieveChristmas,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityHatsuneMikuShare = {
		ActivityHatsuneMikuShare,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityFireplace = {
		ActivityFireplacePage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityBPGift = {
		ActivityBPGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityMutiAchieveObj = {
		ActivityMutiAchieveObjPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityBPPage = {
		ActivityBPPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityNewcomerBPGift = {
		ActivityNewcomerBPGiftPanel,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityPredictAchieve = {
		ActivityPredictAchieve,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityGiftAchieve = {
		ActivityGiftAchieve,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityLuckyStarAchieve = {
		ActivityLuckyStarAchieve,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityFullServerAchieve = {
		ActivityFullServerAchievePanel,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivitySingleGift = {
		ActivitySingleGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityDoubleGift = {
		ActivitDoubleGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityRelatedHeroGift = {
		ActivitRelatedHeroGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityRelatedHeroGiftNew = {
		ActivityRelatedHeroGiftNewPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	PushGiftPage = {
		ActivityPushGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	FirstRechargePage = {
		ActFirstRecGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityMonthCardGift = {
		ActivityMonthCardGiftPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityGiftCellPage = {
		ActivityGiftCellPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityShopPage = {
		ActivityShopPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityShopLevelPage = {
		ActivityShopLevelPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivitySignIn = {
		ActivitySignInPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityNmlSignin = {
		ActivityNmlSigninPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityTickSignIn = {
		ActivityTickSignInPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityLottery = {
		ActivityLotteryPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityMultiRoundLottery = {
		ActivityMultiRoundLotteryPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityBuyGiftDrawPanel = {
		ActivityBuyGiftDrawPanel,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivitySimpleShowPage = {
		ActivitySimpleShowPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivitySimpleAchievePage = {
		ActivitySimpleAchievePage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityNewHeroShowPage = {
		ActivityNewHeroShowPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	MallDlg = {
		"mallDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityMallDlg = {
		"activityMallDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	PetMallDlg = {
		"petMallDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	MonopolyMain = {
		"activityMonopolyMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	MonopolyMain2 = {
		"activityMonopoly2MainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityBingo = {
		"activityBingoDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityPlot = {
		"activityPlotDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	DrawCard = {
		"drawCardMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	DrawCardReplace = {
		"drawCardMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	WorldBoss = {
		"worldBossMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityAchievePub = {
		"activityAchievePubDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	Arena = {
		"activityPvpMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityReturnSignin = {
		"activitySignInDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityWishSignIn = {
		"activityWishSignInDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivitySeasonTowerChooseDlg = {
		"activitySeasonTowerChooseDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityNewYearDinnerDlg = {
		"activityNewYearDinnerDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityHatsuneMikuDlg = {
		"activityHatsuneMikuDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityAIChannelDlg = {
		"activityAIChannelDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	CircleBattle = {
		"circleBattleMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ClanClear = {
		"activityClanClearDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivitySnowOrNightBPDlg = {
		"activitySnowOrNightBPDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	NewMazeChooseDlg = {
		"newMazeChooseDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	BPPvp = {
		"topPvpMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	SneakBattle = {
		"sneakBattleMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	PettyPay = {
		"activityPettyPayDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	EquipRecycle = {
		"activityEquipRecycleInitialDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	SeasonMain = {
		"seasonPlayMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	SeasonDrawCard = {
		"seasonPlaySkinPoolDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityShowSkin = {
		ActivityShowSkinPage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityShowBadge = {
		ActivityShowBadgePage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	ActivityChangePackagePage = {
		ActivityChangePackagePage,
		UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER
	},
	FashionLottery = {
		"activityFashionLotteryDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	CommonStoreDlg = {
		"activityCommonStoreDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	CommonGiftDlg = {
		"activitySpeGiftDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	CommonAchieveDlg = {
		"activityCommonAchieveDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityBattlePassDlg = {
		"activityBattlePassDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	BattlePassStoreDlg = {
		"activitySpeGiftDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	RebackAchieveDlg = {
		"rebackAchieveDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityCollectWordsDlg = {
		"activityCollectWordsDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	CollectWordsAchieveDlg = {
		"activityCollectWordsAchieveDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityCatRaceMainDlg = {
		"activityCatRaceMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	DrawOldRoleUpStoreDlg = {
		"drawOldRoleUpStoreDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	DrawHeroStrengthenRoleUpStoreDlg = {
		"drawHeroStrengthenRoleUpStoreDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	DrawNewbieCampStoreDlg = {
		"drawNewbieCampStoreDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityValentineDlg = {
		"activityValentineDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivitySendHeroDlg = {
		"activitySendHeroDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityCircleGuessDlg = {
		"activityFigureGuessMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	PetMazeDlg = {
		"petMazeMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	PetPoolMainDlg = {
		"petPoolMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ManagementMainDlg = {
		"managementMainDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityBPDlg = {
		"managementBattlePassDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	},
	ActivityEquipRefineDlg = {
		"activityEquipRefineDlg",
		UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW
	}
}

for _, actConfig in pairs(UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG) do
	if actConfig[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW then
		table.insert(UIConst.MAIN_NEED_BACK_DLG, actConfig[1])
	end
end

UIConst.ACTIVITY_RELATED_CONFIG = {}
UIConst.ACTIVITY_MUTIACHIEVE_RELATE_CONFIG = {}
UIConst.ACTIVITY_RED_DOT_CONFIG = {}

for actId, actInfo in pairs(ResOpActivityTemplate) do
	local newHintId = UIConst.generateDynamicRDEvent()

	UIConst.ACTIVITY_RED_DOT_CONFIG[actId] = newHintId
end

for actId, actInfo in pairs(ResOpActivityTemplate) do
	if actInfo.relate_act then
		local selfHintId = UIConst.ACTIVITY_RED_DOT_CONFIG[actId]

		for _, relateAct in ipairs(actInfo.relate_act) do
			local relateHintId = UIConst.ACTIVITY_RED_DOT_CONFIG[relateAct]

			if relateHintId then
				RedDotManager.setKeyRelation(relateHintId, selfHintId)
			end
		end
	end
end

UIConst.ACTIVITY_GROUP_MAIN_RED_DOT = UIConst.generateDynamicRDEvent()

for _, subTab in pairs(ResActivityMainTabConfig) do
	local act_id = subTab.act_id

	if act_id and UIConst.ACTIVITY_RED_DOT_CONFIG[act_id] and not subTab.jump_id and not subTab.fixed_client_template then
		RedDotManager.setKeyRelation(UIConst.ACTIVITY_RED_DOT_CONFIG[act_id], UIConst.ACTIVITY_GROUP_MAIN_RED_DOT)
	end
end

for rFlag, infos in pairs(ResActivityRebackConfig) do
	for index, rInfo in pairs(infos) do
		if rInfo.act_id and UIConst.ACTIVITY_RED_DOT_CONFIG[rInfo.act_id] then
			RedDotManager.setKeyRelation(UIConst.ACTIVITY_RED_DOT_CONFIG[rInfo.act_id], UIConst.RD_HINT_REBACK)
		end
	end
end

function OpActivityMixin:initBaseOpActivityMixin(baseData)
	self.opActivityObjs = {}
	self.activityObjs = {}
	self.newUnlockedActivity = {}
	self.disableActivityIds = {}
end

function OpActivityMixin:_initActivityHide()
	local logicChannelName = ChannelUtil.getLogicChannelName()

	if ResChannelHideActivityConfig[logicChannelName] then
		for _, actId in ipairs(ResChannelHideActivityConfig[logicChannelName].hide_activity or {}) do
			self.disableActivityIds[actId] = true
		end
	end
end

function OpActivityMixin:initOpActivityMixin(baseData, syncData)
	self.opActivityObjs = {}
	self.activityObjs = {}
	self.opActivityOpenedDic = {}

	self:initOpActivityObjs(syncData.other.opactivity)
	self:initResidentOpActivityObjs(syncData.other.resident_opactivity.resident_item, 1)

	self.slotOfOpActivityConditionLimit = Slot(self.onConditionUnlock, self)

	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfOpActivityConditionLimit)
	RPC.opActivityData("kOpActivitySyncMgrData", 1)
	RPC.opActivityData("kOpActivitySyncSysData", 1)
	self:initSeasonTowerScoreData(baseData.necessary.misc.opact_tower_achieve_awarded)
	self:initRebackData(baseData.necessary.misc.reflux)
	self:initSubscribeData(baseData.necessary.misc.subscribe_data)
	self:initCumulativeCountData(baseData.necessary.misc.count)

	if Const.SNEAK_BATTLE_OPEN then
		self:initSneakBattlePersistentData(baseData.necessary.misc.newpve_data)
	end
end

function OpActivityMixin:newDayActivity()
	local stAct = self:getSeasonTowerAct()

	if stAct and stAct.actData then
		stAct.actData:refreshTowerBuffData()
	end

	for _, actObj in pairs(self.activityObjs or {}) do
		if actObj.actData and actObj.actData.onNewDay then
			actObj.actData:onNewDay()
		end

		actObj:checkNew()
	end
end

function OpActivityMixin:destroyOpActivityMixin()
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfOpActivityConditionLimit)

	for _, opActObj in pairs(self.opActivityObjs) do
		opActObj:destroy()
	end
end

function OpActivityMixin:initOpActivityObjs(opactivity)
	for _, item in ipairs(opactivity.item) do
		self:updateActivityRoleData(item)
	end
end

function OpActivityMixin:initResidentOpActivityObjs(residentOpactivity)
	for _, Obj in ipairs(residentOpactivity) do
		self:updateActivityRoleData(Obj.item)
	end
end

function OpActivityMixin:updateActivityRoleData(roleOpActivityItem, fromDataUpdate)
	local opId = roleOpActivityItem.act_id
	local actId = roleOpActivityItem.commdata.tmpl_id

	if self.disableActivityIds[actId] then
		return
	end

	local actType = roleOpActivityItem.act_type
	local roleData = roleOpActivityItem.specdata

	if not self.opActivityObjs[opId] then
		self.opActivityObjs[opId] = OpActivityObject(opId, actId, actType)
	end

	self.opActivityObjs[opId]:updateRoleData(roleData, roleOpActivityItem.commdata, fromDataUpdate)
end

function OpActivityMixin:onOpActivityStateNotify(isall, data)
	for _, actData in pairs(data) do
		local obj = self.opActivityObjs[actData.activity_id]

		if obj then
			obj:onServerStateChange(actData.state)
			self:initActGiftData(obj)
		end
	end
end

function OpActivityMixin:onOpActSetFocusResp(opId, focus)
	local obj = self.opActivityObjs[opId]

	if obj then
		obj:onOpActSetFocusResp(focus)
		self:_refreshActivityUI()

		local activityMainDlg = UIManager.tryGetUI("activityMainDlg")

		if activityMainDlg then
			activityMainDlg:onRefreshMainBanner()
		end
	end
end

function OpActivityMixin:onOpActivityMgrDataNotify(mgrItems, isall)
	if self.opDataReady or isall == 1 then
		self.opDataReady = true

		for _, opActivityMgrItem in ipairs(mgrItems) do
			self:updateActivityMgrtemData(opActivityMgrItem.data, opActivityMgrItem.cross_data)
		end

		self:checkOpactPvpTopTenData()
		self:checkTopPvpTopData()

		for _, actObj in pairs(self.activityObjs) do
			actObj:checkNew()
		end
	end

	if isall == 1 and self.isReconnect then
		for _, uiName in ipairs(UIConst.RELINK_SAVE_DLG) do
			local ui = UIManager.getUI(uiName, nil, false)

			if ui and ui:isInShow() then
				ui:checkOnRelink()
			end
		end

		if GameFsm.isInState(Const.STATE_MAIN) then
			GameFsm.getState():onReconnect()
		end
	end
end

function OpActivityMixin:onResidentOpActivityMgrDataNotify(mgrItems)
	for _, opActivityMgrItem in ipairs(mgrItems) do
		self:updateActivityMgrtemData(opActivityMgrItem)
	end

	for _, actObj in pairs(self.activityObjs) do
		actObj:checkNew()
	end
end

function OpActivityMixin:updateActivityMgrtemData(data, cross_data)
	local crossData = cross_data
	local opActivityMgrItem = data
	local opId = opActivityMgrItem.act_id
	local actType = opActivityMgrItem.act_type
	local actId = opActivityMgrItem.tmpl_id

	if self.disableActivityIds[actId] then
		return
	end

	if opActivityMgrItem.state == Const.OPACT_STATE_CLOSE then
		self.opActivityObjs[opId] = nil

		if self.activityObjs[actId] and self.activityObjs[actId].opId == opId then
			self.activityObjs[actId] = nil
		end
	else
		if not self.opActivityObjs[opId] then
			self.opActivityObjs[opId] = OpActivityObject(opId, actId, actType)
		end

		self.activityObjs[actId] = self.opActivityObjs[opId]

		self.opActivityObjs[opId]:updateMgrData(actType, actId, opActivityMgrItem, crossData)
		self:_refreshActivityUI()
		self:initActGiftData(self.opActivityObjs[opId])
	end
end

function OpActivityMixin:_refreshActivityUI()
	local mainMenu = UIManager.tryGetUI("mainMenu")

	if mainMenu then
		mainMenu.panelRecommendBtn:onRefresh()
		mainMenu.panelBanner:onRefresh()
		mainMenu.panelPrivilege:onRefresh()
	end

	local mainStageDlg = UIManager.tryGetUI("mainStageDlg")

	if mainStageDlg then
		mainStageDlg.panelBanner:onRefresh()
		mainStageDlg.panelRecommendBtn:onRefresh()
		mainStageDlg.panelPrivilege:onRefresh()
	end

	local actGatherDlg = UIManager.tryGetUI("activityGatherMainDlg")

	if actGatherDlg then
		actGatherDlg:onBtnsRefresh()
	end

	local actMainDlg = UIManager.tryGetUI("activityMainDlg")

	if actMainDlg then
		actMainDlg:updateMgrDataRefreshBannerUI()
	end

	self:refreshCircleDetailDlg()
end

function OpActivityMixin:onOpActivitySysDataNotify(systemItems, opened_bit)
	for _, opActivitySystemItem in ipairs(systemItems) do
		local opId = opActivitySystemItem.act_id

		if self.opActivityObjs[opId] then
			self.opActivityObjs[opId]:updateSystemData(opActivitySystemItem)
		end
	end

	local bitList = ClientUtils.getBitsListFromByteString(opened_bit)

	for _, opActTypeId in pairs(bitList) do
		self.opActivityOpenedDic[opActTypeId] = true
	end

	for _, actObj in pairs(self.activityObjs) do
		actObj:checkOnInit()
	end
end

function OpActivityMixin:onResidentOpActivitySysDataNotify(datas, opened_bit)
	for _, data in ipairs(datas) do
		local opActivitySystemItem = data.item
		local opId = opActivitySystemItem.act_id

		if self.opActivityObjs[opId] then
			self.opActivityObjs[opId]:updateSystemData(opActivitySystemItem)
		end
	end

	local bitList = ClientUtils.getBitsListFromByteString(opened_bit)

	for _, opActTypeId in pairs(bitList) do
		self.opActivityOpenedDic[opActTypeId] = true
	end

	for _, actObj in pairs(self.activityObjs) do
		actObj:checkOnInit()
	end
end

function OpActivityMixin:opActivityIsOpened(actType)
	if Const.ACT_TYPE_ID_DIC[actType] then
		return self.opActivityOpenedDic[Const.ACT_TYPE_ID_DIC[actType]] ~= nil
	end
end

function OpActivityMixin:setActivityOpened(actType)
	if Const.ACT_TYPE_ID_DIC[actType] then
		self.opActivityOpenedDic[Const.ACT_TYPE_ID_DIC[actType]] = 1
	end
end

function OpActivityMixin:onOpActivityRoleDataNotify(roleItems)
	for _, roleOpActivityItem in ipairs(roleItems) do
		self:updateActivityRoleData(roleOpActivityItem, true)
	end
end

function OpActivityMixin:onResidentOpActivityRoleDataNotify(datas)
	for _, data in ipairs(datas) do
		local roleOpActivityItem = data.item

		self:updateActivityRoleData(roleOpActivityItem, true)
	end
end

function OpActivityMixin:onRechargeRebateAwardResp(code, cash, diamond, recharge_id)
	if cash ~= 0 and diamond ~= 0 then
		local attrs = {}
		local itemtable2 = {}

		itemtable2.type = "kRoleAttrResourceDiamond"
		itemtable2.value = diamond

		table.insert(attrs, itemtable2)

		local items = {}
		local itemtable1 = {}

		itemtable1.id = 510022
		itemtable1.num = cash

		table.insert(items, itemtable1)
		UIManager.getUI("rechargeResultBox", true):onShow(attrs, items, {}, {}, {}, Lang.get(338), Slot(self.callbackRecharge, self))

		self.recharge_id = recharge_id
	end
end

function OpActivityMixin:callbackRecharge()
	if self.cacherecharge == nil then
		return
	end

	local indexnum = #self.cacherecharge

	if indexnum > 0 then
		UIManager.getUI("monthCardResultBox", true):setData(self.recharge_id[indexnum], nil, self.cacherecharge[indexnum], Slot(self.callbackRecharge, self))
		table.remove(self.cacherecharge, indexnum)
		table.remove(self.recharge_id, indexnum)
	end
end

function OpActivityMixin:checkActivityGiftNew()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_GIFT then
			activityObj:checkNew()
		end
	end
end

function OpActivityMixin:onOpActivityStateChange(opActId, opActState)
	local activityObj = self:_getOpActObj(opActId)

	if activityObj then
		activityObj:onStateChange(opActState)

		if opActState == Const.OPACT_STATE_CLOSE then
			self.opActivityObjs[opActId] = nil

			if self.activityObjs[activityObj.actId] and self.activityObjs[activityObj.actId].opId == opActId then
				self.activityObjs[activityObj.actId] = nil
			end
		end

		self:_refreshActivityUI()
	end
end

function OpActivityMixin:onConditionUnlock(limitId)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.limitId == limitId and activityObj:isOpen() then
			activityObj:checkNew()
		elseif activityObj.limitIdGroup and activityObj.limitIdGroup[limitId] then
			activityObj:checkNew()
			activityObj:refreshUI()
		end
	end
end

function OpActivityMixin:_getOpActObj(opActId)
	local obj = self.opActivityObjs[opActId]

	if not obj then
		return
	end

	return obj
end

function OpActivityMixin:showActivityBonus(args, cb, titleName)
	if cb then
		args[9] = cb
	end

	if titleName then
		args[8] = titleName
	elseif args[1] == Const.LISTATTR_USETYPE_SHOP then
		args[8] = Lang.get(1714)
	else
		args[8] = nil
	end

	local cwAchieveDlg = UIManager.tryGetUI("activityCollectWordsAchieveDlg")

	if cwAchieveDlg then
		self:onGetBonusNotice("commonBonusCollectWordsDlg", "onShow", args)

		return
	end

	if args[1] == Const.LISTATTR_USETYPE_SHOP then
		local clientItems = ClientUtils.getAllClientItems(args[2], args[3], args[4], args[5], args[6], args[7])

		if #clientItems > 0 then
			self:onGetBonusNotice("commonBonusDlg", "onShow", args)
		end
	else
		self:showCommonBonus(args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9])
	end
end

function OpActivityMixin:onGetActivityBonus(actOpId, args)
	local actObj = self.opActivityObjs[actOpId]

	if actObj then
		local mainDlg = actObj:getActivityWindows()

		if mainDlg and mainDlg.onGetActivityBonus then
			mainDlg:onGetActivityBonus(actObj.actId, Functor(self.showActivityBonus, self, args))

			return
		end

		if not mainDlg then
			local relatedWindow, relatedInfo = actObj:getActivityRelatedWindows()

			if relatedWindow and relatedWindow.onGetRelatedActivityBonus then
				relatedWindow:onGetRelatedActivityBonus(actObj.actId, relatedInfo[2], Functor(self.showActivityBonus, self, args))

				return
			end
		end

		if args[1] == Const.LISTATTR_USETYPE_OPACT_ACHIEVE and actObj.actData.miscData then
			local hide_bonus_notice = actObj.actData.miscData.hide_bonus_notice

			if hide_bonus_notice then
				return
			end
		end
	end

	if not self.opDataReady then
		return
	end

	self:showActivityBonus(args)
end

function OpActivityMixin:onMonopolyRollResp(type, point, move_to, pass_award, index, opId, eventId, item_event, libCountList, item_count)
	local actObj = self.opActivityObjs[opId]

	if actObj then
		local mainDlg = actObj:getActivityWindows()

		if mainDlg then
			mainDlg:onMonopolyRollResp(type, point, move_to, pass_award, index)
		end

		actObj.actData:onMonopolyRollResp(move_to, index, eventId, item_event, libCountList, item_count)
	end
end

function OpActivityMixin:onMonopolyExchangeResp(activity_id, diceType, count, num)
	local actObj = self.opActivityObjs[activity_id]

	if actObj then
		actObj.actData:onMonopolyExchangeResp(diceType, count, num)

		local mainDlg = actObj:getActivityWindows()

		if mainDlg then
			mainDlg:onMonopolyRollResp(type, point, move_to, pass_award, index)
		end
	end
end

function OpActivityMixin:onOpActMonopolySetLibAwardResp(act_id, lib_id, index)
	local actObj = self.opActivityObjs[act_id]

	if actObj then
		actObj.actData:onOpActMonopolySetLibAwardResp(lib_id, index)

		local mainDlg = actObj:getActivityWindows()

		if mainDlg and mainDlg.onOpActMonopolySetLibAwardResp then
			mainDlg:onOpActMonopolySetLibAwardResp(lib_id, index)
		end
	end
end

function OpActivityMixin:onOpActMonopolyUseItemResp(act_id, item_event)
	local actObj = self.opActivityObjs[act_id]

	if actObj then
		actObj.actData:onOpActMonopolyUseItemResp(item_event.event_id, item_event.left_round)

		local mainDlg = actObj:getActivityWindows()

		if mainDlg and mainDlg.onOpActMonopolyUseItemResp then
			mainDlg:onOpActMonopolyUseItemResp()
		end
	end
end

function OpActivityMixin:getActivityObjByOpId(opId)
	if self.opActivityObjs then
		return self.opActivityObjs[opId]
	end
end

function OpActivityMixin:getActivityObj(actId)
	if self.activityObjs then
		return self.activityObjs[actId]
	end
end

function OpActivityMixin:getActivityClientDataByGroup(actId)
	if self.activityObjs then
		local groupObj = self.activityObjs[actId]

		if groupObj then
			local clientData = groupObj.actData.clientData
			local groupClientData = {}

			for _, v in pairs(clientData) do
				for _, cell in pairs(v) do
					local group = ResOpActivityConditionLimit[cell.limit_id] and ResOpActivityConditionLimit[cell.limit_id].param1 or nil

					if not group or group == self.rebackGroup then
						table.insert(groupClientData, cell)
					end
				end
			end

			return groupClientData
		end
	end

	return nil
end

function OpActivityMixin:getAllOpActObjs()
	return self.opActivityObjs
end

function OpActivityMixin:isActivityValid(actId)
	local activityObj = self.activityObjs[actId]

	if activityObj then
		return activityObj:isValid()
	else
		return false
	end
end

function OpActivityMixin:isActivityOpen(actId)
	local activityObj = self.activityObjs[actId]

	if activityObj then
		return activityObj:isOpen()
	else
		return false
	end
end

function OpActivityMixin:getValidActivityGroup()
	local lastOpenGroupId = 0
	local lastOpenGroupTime = 0

	for groupId, groupInfo in ipairs(ResActivityMainConfig) do
		local actId = groupInfo.relate_activity

		if self:isActivityOpen(actId) then
			local activityObj = self:getActivityObj(actId)
			local openTime = activityObj.startTime

			if lastOpenGroupId == 0 or lastOpenGroupTime < openTime then
				lastOpenGroupId = groupId
				lastOpenGroupTime = openTime
			end
		end
	end

	if lastOpenGroupId > 0 then
		return lastOpenGroupId
	end

	for groupId, groupInfo in ipairs(ResActivityMainConfig) do
		for _, extraActivity in ipairs(groupInfo.extra_activity or {}) do
			if self:isActivityOpen(extraActivity) then
				return groupId
			end
		end
	end
end

function OpActivityMixin:getRecommendActivityGroup()
	for groupId, groupInfo in ipairs(ResActivityMainConfig) do
		if self:isActivityValid(groupInfo.relate_activity) then
			return groupId
		end
	end
end

function OpActivityMixin:noActivityGroupOpened()
	for groupId, groupInfo in ipairs(ResActivityMainConfig) do
		if self:isActivityOpen(groupInfo.relate_activity) then
			return false
		end
	end

	for groupId, groupInfo in ipairs(ResActivityMainConfig) do
		for _, extraActivity in ipairs(groupInfo.extra_activity or {}) do
			if self:isActivityOpen(extraActivity) then
				return false
			end
		end
	end

	return true
end

function OpActivityMixin:isActivityGroupOpened(actGroupId)
	return self:getValidActivityGroup() == actGroupId
end

function OpActivityMixin:isActivityGroupNewOpend(actGroupId)
	for subId, subData in ipairs(ResActivityMainTabConfig) do
		if subData.act_id then
			local actId = subData.act_id
			local actObj = CurAvatar:getActivityObj(actId)

			if actObj and actObj:isValid() and actObj:isNewOpened() then
				return true
			end
		elseif subData.sub_type then
			return self:checkActGroupNewOpen(subData.sub_type)
		end
	end

	return false
end

function OpActivityMixin:getActivityState(actId)
	local activityObj = self.activityObjs[actId]

	if activityObj then
		return activityObj:getState()
	end
end

function OpActivityMixin:hasOpActivityOpen()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj:isOpen() then
			return true
		end
	end

	return false
end

function OpActivityMixin:hasOpActivityUI()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj:isValid() and activityObj:hasUI() then
			return true
		end
	end
end

local DEPOSIT_ACT_TYPE = {
	[Const.ACT_TYPE_DEPOSIT] = 1,
	[Const.ACT_TYPE_STAGE_DEPOSIT] = 1
}
local DEPOSIT_ACT_TYPE_ALL_TIME = {}

function OpActivityMixin:getActivityDepositBonus()
	local bonus = {}

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj:isValid() and DEPOSIT_ACT_TYPE[activityObj.actType] then
			activityObj.actData:getHookBonus(bonus)
		elseif DEPOSIT_ACT_TYPE_ALL_TIME[activityObj.actType] then
			activityObj.actData:getHookBonus(bonus)
		end
	end

	return bonus
end

function OpActivityMixin:getHookActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_DEPOSIT and activityObj:isValid() and not activityObj:inFreeze() and activityObj.actData and not activityObj.actData.isManual then
			return activityObj
		end
	end
end

function OpActivityMixin:refreshDepositActivity()
	if CurAvatar:getHookActivity() then
		RPC.opActDepositRefresh()
	end

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_DEPOSIT and activityObj:isValid() and activityObj.actData and activityObj.actData.isManual then
			activityObj:checkNew()
		end
	end
end

function OpActivityMixin:getStageAchieveActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_ACHIEVE and activityObj:isValid() and activityObj.actData and activityObj.actData:hasStageAchieveAward() then
			return activityObj
		end
	end
end

function OpActivityMixin:getActivityStageAward(stageInfo)
	local bonuIds = {}

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj:isValid() and activityObj.actType == Const.ACT_TYPE_ACHIEVE then
			activityObj.actData:getAchieveStageAward(stageInfo, bonuIds)
		end
	end

	return bonuIds
end

function OpActivityMixin:activityRPC(func, opId, ...)
	if func then
		if self.opActivityObjs[opId] and self.opActivityObjs[opId]:isOperateEnable() then
			func(...)
		else
			MsgManager.notice(Lang.get(1870))
		end
	end
end

function OpActivityMixin:checkPlayNodeReport(avgId)
	for i, nodeData in pairs(ResActivityPlayNodeConfig) do
		if nodeData.avg_id == avgId then
			local actObj = self:getActivityObj(nodeData.relate_achieve)

			if actObj then
				CurAvatar:activityRPC(Functor(RPC.opActAchieveSetClientTriggerFlag, actObj.opId, Const.ACTIVITY_TYPE_PLAY_NODE, nodeData.param), actObj.opId)
			end
		end
	end
end

function OpActivityMixin:recordNewActivityUnlocked(actId)
	table.insert(self.newUnlockedActivity, actId)

	self.newUnlockedAct = true
end

function OpActivityMixin:getNewActivityUnlocked()
	local actId = self.newUnlockedActivity[1]
	local nowNew = self.newUnlockedAct

	self.newUnlockedAct = false

	return actId, nowNew
end

function OpActivityMixin:removeNewActivityUnlocked(actId)
	if actId == self.newUnlockedActivity[1] then
		table.remove(self.newUnlockedActivity, 1)
	end
end

function OpActivityMixin:addActivityRelated(actId, relatedWindow, relatedActId)
	UIConst.ACTIVITY_RELATED_CONFIG[actId] = {
		relatedWindow,
		relatedActId
	}
end

function OpActivityMixin:addActivityMutiAchieveRelated(actId, relatedWindow, relatedActId)
	UIConst.ACTIVITY_MUTIACHIEVE_RELATE_CONFIG[actId] = {
		relatedWindow,
		relatedActId
	}
end

function OpActivityMixin:recordActivityRelate(mainOpId, subOpId)
	if not mainOpId or not subOpId then
		return
	end

	if not self.activityRealteMain2Subs then
		self.activityRealteMain2Subs = {}
	end

	if not self.activityRealteMain2Subs[mainOpId] then
		self.activityRealteMain2Subs[mainOpId] = {}
	end

	if not self.activityRealteSub2Main then
		self.activityRealteSub2Main = {}
	end

	if self.activityRealteSub2Main[subOpId] ~= mainOpId then
		table.insert(self.activityRealteMain2Subs[mainOpId], subOpId)

		self.activityRealteSub2Main[subOpId] = mainOpId
	end
end

function OpActivityMixin:getAllRelateSubActIds(opId)
	if self.activityRealteMain2Subs and self.activityRealteMain2Subs[opId] then
		return self.activityRealteMain2Subs[opId]
	end
end

function OpActivityMixin:getActivityObjByType(typeId)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == typeId and activityObj:getState() ~= Const.OPACT_STATE_CLOSE then
			return activityObj
		end
	end
end

function OpActivityMixin:getPVPArenaActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_ARENA and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getPVPArenaActivityOpId()
	local actObj = self:getPVPArenaActivity()

	if actObj then
		return actObj.opId
	end
end

function OpActivityMixin:getPVPArenaActData()
	local actObj = self:getPVPArenaActivity()

	if actObj then
		return actObj.actData
	end
end

function OpActivityMixin:getPVPArenaActivityData()
	local actObj = self:getPVPArenaActivity()

	if actObj then
		return actObj.actData.arenaData
	end
end

function OpActivityMixin:getPVPArenaFormationHideMode()
	local actObj = self:getPVPArenaActivity()

	if actObj then
		return actObj.actData:getCurFormationHideMode()
	end
end

function OpActivityMixin:getCircleBattleActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_CIRCLE_BATTLE and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getCircleBattleActivityOpId()
	local actObj = self:getCircleBattleActivity()

	if actObj then
		return actObj.opId
	end
end

function OpActivityMixin:tryCallCircleBattleRpc(funcName, ...)
	local actObj = self:getCircleBattleActivity()

	if actObj and actObj.actData then
		actObj.actData:tryCallRpc(funcName, ...)
	end
end

function OpActivityMixin:getWorldBossActivity(...)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_WORLD_BOSS and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getWorldBossActData(...)
	local actObj = self:getWorldBossActivity()

	if actObj then
		return actObj.actData
	end
end

function OpActivityMixin:getNewMazeActivity(...)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_NEW_MAZE and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getNewMazeActData(...)
	local actObj = self:getNewMazeActivity()

	if actObj then
		return actObj.actData
	end
end

Const.FAKE_ACT_PUSH_GIFT = 1
Const.FAKE_ACT_FIRST_RECHARGE = 2
Const.FAKE_ACT_RECHARGE_FADEBACK = 3
Const.FAKE_ACT_WORLDBOSS = 4
Const.FAKE_ACT_ID_CONFIG = {
	[Const.FAKE_ACT_PUSH_GIFT] = {
		9995,
		9996,
		9997,
		9998
	},
	[Const.FAKE_ACT_FIRST_RECHARGE] = {
		9999
	},
	[Const.FAKE_ACT_RECHARGE_FADEBACK] = {
		2004
	},
	[Const.FAKE_ACT_WORLDBOSS] = {
		99999
	}
}
Const.FAKE_FIRST_RECHARGE_SERVER_DATA = {
	achieve = {
		data = {
			{
				progress = 0,
				type = 1,
				got = {
					[1] = false
				}
			}
		}
	}
}

function OpActivityMixin:openFakeActivityObj(systemType, fakeActKey, endTime, actType, fakeRoleData)
	local thisActId
	local actIds = Const.FAKE_ACT_ID_CONFIG[systemType] or {}

	for _, actId in ipairs(actIds) do
		local oldObj = self.activityObjs[actId]

		if not oldObj or not oldObj:isValid() then
			local opActivityMgrItem = self:_getFakeActServerItem(actId, actType, endTime, Const.OPACT_STATE_OPEN)

			self:updateActivityMgrtemData(opActivityMgrItem)

			self.activityObjs[actId].fakeActKey = fakeActKey

			if fakeRoleData then
				self.activityObjs[actId].actData:updateRoleData(fakeRoleData)
				self.activityObjs[actId]:checkNew()
			end

			break
		elseif oldObj and oldObj.fakeActKey == fakeActKey then
			if fakeRoleData then
				self.activityObjs[actId].actData:updateRoleData(fakeRoleData)
				self.activityObjs[actId]:checkNew()
			end

			break
		end
	end
end

function OpActivityMixin:closeFakeActivityObj(systemType, fakeActKey, actType)
	local actIds = Const.FAKE_ACT_ID_CONFIG[systemType] or {}

	for _, actId in ipairs(actIds) do
		local oldObj = self.activityObjs[actId]

		if oldObj and oldObj:isValid() and oldObj.fakeActKey == fakeActKey then
			local opActivityMgrItem = self:_getFakeActServerItem(actId, actType, 0, Const.OPACT_STATE_CLOSE)

			self:updateActivityMgrtemData(opActivityMgrItem)
		end
	end
end

function OpActivityMixin:_getFakeActServerItem(actId, actType, endTime, state)
	local opId = self:getDynamicFakeActOpId(actId)
	local opActivityMgrItem = {}

	opActivityMgrItem.act_id = opId
	opActivityMgrItem.act_type = actType
	opActivityMgrItem.tmpl_id = actId
	opActivityMgrItem.time = {}
	opActivityMgrItem.time.closetime = endTime
	opActivityMgrItem.time.freezetime = endTime
	opActivityMgrItem.state = state

	return {
		data = opActivityMgrItem
	}
end

local DYNAMIC_ACT_ID = 0

function OpActivityMixin:getDynamicFakeActOpId(actId)
	if self.activityObjs[actId] then
		return self.activityObjs[actId].opId
	else
		DYNAMIC_ACT_ID = DYNAMIC_ACT_ID - 1

		return DYNAMIC_ACT_ID
	end
end

function OpActivityMixin:checkActGroupOpen(groupId)
	if groupId == Const.ACT_NEW_OPEN_ARTIFACT then
		return self:checkArtifactNewOpen()
	elseif groupId == Const.ACT_NEW_OPEN_PUSHGIFT then
		local pushGifts = self:getPushGift(true)

		return next(pushGifts) ~= nil
	else
		local groupData = ResActivityClientNewOpen[groupId]

		for _, groupInfo in pairs(groupData or {}) do
			local actId = groupInfo.actId

			if actId then
				local actObj = self:getActivityObj(actId)

				if actObj and actObj:isValid() then
					return true
				end
			elseif ClientUtils.isNewSkinValid(groupInfo) then
				return true
			end
		end
	end

	return false
end

function OpActivityMixin:_newOpenHasRedDot(groupInfo, cachedData)
	if not cachedData then
		cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_SHOW) or {}
		cachedData = cachedData[groupInfo.id] or {}
	end

	if groupInfo.param then
		local skinId = groupInfo.param or 0
		local actId = groupInfo.actId or 0

		if (not cachedData or not cachedData[actId] or not cachedData[actId][skinId]) and not self:hasGetHeroSkin(skinId) then
			return true
		end
	end

	return false
end

function OpActivityMixin:checkActGroupNewOpen(groupId)
	if groupId == Const.ACT_NEW_OPEN_ARTIFACT then
		return self:checkActArtifactHasNew()
	elseif groupId == Const.ACT_NEW_OPEN_PUSHGIFT then
		local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_SHOW) or {}

		cachedData = cachedData.GiftCellPage or {}

		local pushGifts = self:getPushGift(true)

		for giftId, giftServerData in pairs(pushGifts) do
			local giftClientData = ResPushGiftPkg[giftServerData.gift_id]
			local pageId = giftClientData.client_page_id

			if ResActivityClientGiftCell[pageId] then
				local skinId = ResActivityClientGiftCell[pageId].skin_item_id

				if not cachedData[skinId] and not self:hasGetHeroSkin(skinId) then
					return true
				end
			end
		end
	else
		local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_SHOW) or {}

		cachedData = cachedData[groupId] or {}

		local groupData = ResActivityClientNewOpen[groupId]

		for _, groupInfo in pairs(groupData or {}) do
			local actId = groupInfo.actId

			if actId then
				local actObj = self:getActivityObj(actId)

				if actObj and actObj:isValid() and self:_newOpenHasRedDot(groupInfo, cachedData) then
					return true
				end
			elseif ClientUtils.isNewSkinValid(groupInfo) and self:_newOpenHasRedDot(groupInfo, cachedData) then
				return true
			end
		end
	end

	return false
end

function OpActivityMixin:newOpenArtifactRedDot(groupInfo, cachedData)
	cachedData = cachedData or UserData.getClientData(Const.USER_KEY_ACTIVITY_ARTIFACT_SHOW) or {}
	cachedData = cachedData[groupInfo.id] or {}

	if not cachedData or cachedData[groupInfo.artifact_id or 0] ~= (groupInfo.relate_activity or 0) then
		return true
	end

	return false
end

function OpActivityMixin:saveNewOpenArtifactRedDot(groupInfo)
	local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_ARTIFACT_SHOW) or {}

	cachedData[groupInfo.id] = {
		[groupInfo.artifact_id or 0] = groupInfo.relate_activity or 0
	}

	UserData.setClientData(Const.USER_KEY_ACTIVITY_ARTIFACT_SHOW, cachedData)

	local activityMainDlg = UIManager.tryGetUI("activityMainDlg")

	if activityMainDlg then
		activityMainDlg:onRefreshMainBanner()
	end
end

function OpActivityMixin:checkArtifactNewOpen()
	for _, groupInfo in pairs(ResActivityArtifactNewOpen) do
		if ClientUtils.isNewArtifactValid(groupInfo) then
			local actId = groupInfo.relate_activity

			if actId then
				local actObj = self:getActivityObj(actId)

				if actObj and actObj:isValid() then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function OpActivityMixin:checkActArtifactHasNew()
	local cachedData = UserData.getClientData(Const.USER_KEY_ACTIVITY_ARTIFACT_SHOW) or {}

	for _, groupInfo in pairs(ResActivityArtifactNewOpen) do
		if ClientUtils.isNewArtifactValid(groupInfo) then
			local actId = groupInfo.relate_activity

			if actId then
				local actObj = self:getActivityObj(actId)

				if actObj and actObj:isValid() and self:newOpenArtifactRedDot(groupInfo, cachedData) then
					return true
				end
			elseif self:newOpenArtifactRedDot(groupInfo, cachedData) then
				return true
			end
		end
	end

	return false
end

function OpActivityMixin:getUpActivity()
	local objList = {}

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_UPDRAW and activityObj:isValid() then
			table.insert(objList, activityObj)
		end

		if (activityObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP or activityObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_CAMP) and activityObj:isValid() and activityObj.actData.isUnLock and activityObj.actData:isUnLock() then
			table.insert(objList, activityObj)
		end
	end

	local function upActSort(a, b)
		if a.startTime and b.startTime then
			if a.startTime == b.startTime then
				return a.opId > b.opId
			else
				return a.startTime > b.startTime
			end
		else
			return a.opId > b.opId
		end
	end

	table.sort(objList, upActSort)

	return objList
end

function OpActivityMixin:checkUpActivityNew()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if (activityObj.actType == Const.ACT_TYPE_UPDRAW or activityObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP or activityObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_CAMP or activityObj.actType == Const.ACT_TYPE_COLLECT_WORDS) and activityObj:isValid() then
			activityObj:checkNew()
		end
	end
end

function OpActivityMixin:drawActivityHasShareAward(opActId, heroId)
	local activityObj = self.activityObjs[opActId]

	if activityObj and activityObj.actData then
		return not activityObj.actData:hasShared() and activityObj.actData:getUpHero() == heroId
	end

	return false
end

function OpActivityMixin:getReplacePoolActivity()
	local activityDict = {}

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_REPLACE_POOL and activityObj:isValid() then
			activityDict[activityObj.actData.poolId] = activityObj
		end
	end

	return activityDict
end

function OpActivityMixin:replaceActivityHasShareAward(heroId)
	local activityDict = self:getReplacePoolActivity()
	local actObj, poolId

	for pid, obj in pairs(activityDict) do
		actObj = obj
		poolId = pid

		break
	end

	if actObj and actObj.actData then
		local detail = actObj.actData:getNowUpDetail(poolId)

		if detail then
			return not actObj.actData:hasShared() and detail.fake_hero_id == heroId, actObj.actId
		end
	end

	return false
end

function OpActivityMixin:poolHasReplaced(poolId)
	local activityDict = self:getReplacePoolActivity()

	return activityDict[poolId] ~= nil
end

function OpActivityMixin:getRentUpActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_RENT_UP and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getRentUpActivityStartTime()
	local rentActObj = self:getRentUpActivity()

	if rentActObj then
		return rentActObj.actData.startTime
	end
end

function OpActivityMixin:getSneakBattleActivity(...)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_SNEAK_BATTLE and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getSneakBattleActivityData(...)
	local actObj = self:getSneakBattleActivity()

	if actObj then
		return actObj.actData
	end
end

function OpActivityMixin:initSneakBattlePersistentData(newpve_data)
	if newpve_data then
		self.sneakBattlePersistentData = {}

		for _, data in ipairs(newpve_data.persistent_data) do
			self:setSneakBattlePersistentData(data)
		end
	end
end

function OpActivityMixin:setSneakBattlePersistentData(oneData)
	local type = oneData.type

	if not self.sneakBattlePersistentData[type] then
		self.sneakBattlePersistentData[type] = {}
	end

	self.sneakBattlePersistentData[type].passData = oneData.pass_data
	self.sneakBattlePersistentData[type].achieveGot = ClientUtils.getBitsDictFromByteString(oneData.achieve_award)

	if oneData.stage_award then
		for _, data in ipairs(oneData.stage_award) do
			local index = data.level

			if not self.sneakBattlePersistentData[type][index] then
				self.sneakBattlePersistentData[type][index] = {}
			end

			self.sneakBattlePersistentData[type][index].stageStrongPass = ClientUtils.getBitsDictFromByteString(data.stage_strong_pass)
			self.sneakBattlePersistentData[type][index].strongPassNum = data.strong_pass_num
		end
	end
end

function OpActivityMixin:getSneakBattlePersistentData(type)
	if self.sneakBattlePersistentData and self.sneakBattlePersistentData[type] then
		return self.sneakBattlePersistentData[type]
	end
end

function OpActivityMixin:onNewPveGetCurFormationResp(formation)
	if formation then
		local actData = self:getSneakBattleActivityData()

		if actData then
			actData:setRelicHeroDic(formation)
		end
	end
end

function OpActivityMixin:onNewPveResetResp(...)
	local ui = UIManager.tryGetUI("sneakBattleLevelMainDlg")

	if ui and ui:getVisible() then
		ui:setData()
	end
end

function OpActivityMixin:onNewPveWearRelicResp(actId, heroId, relicId)
	local actData = self:getSneakBattleActivityData()
	local ui = UIManager.tryGetUI("relicWearDlg")

	if ui then
		ui:setVisible(false)
	end

	if actData then
		if not actData.relicHeroDic then
			actData.relicHeroDic = {}
		end

		actData.relicHeroDic[relicId] = heroId
		actData.heroRelicDic[heroId] = relicId

		actData:checkNew()

		local ui = UIManager.tryGetUI("sneakBattleHeroCheckDlg")

		if ui then
			ui:refreshUISneakBattle()
		end
	end
end

function OpActivityMixin:onNewPveRoleDataNotify(data)
	self:setSneakBattlePersistentData(data)

	local ui = UIManager.tryGetUI("sneakBattleMainDlg")

	if ui then
		ui:setData()
	end

	local ui = UIManager.tryGetUI("sneakBattleAwardDlg")

	if ui then
		ui:setData()
	end
end

function OpActivityMixin:onNewPveResetResp(actId, level)
	local ui = UIManager.tryGetUI("sneakBattleLevelMainDlg")

	if ui then
		ui:setData()
	end

	local actData = self:getSneakBattleActivityData()

	if actData then
		actData.resetTick = ClientUtils.getServerTime()
	end
end

function OpActivityMixin:onNewPveChooseLevelResp(actId, level)
	local actData = self:getSneakBattleActivityData()

	if actData then
		local ui = UIManager.tryGetUI("sneakBattleMainDlg")

		if ui then
			ui:setData()
		end

		local ui = UIManager.getUI("sneakBattleLevelMainDlg", true)

		if ui then
			ui:setData(actData, level)
		end
	end
end

function OpActivityMixin:onNewPveResetStageResp(actId, level, stage)
	local ui = UIManager.tryGetUI("sneakBattleTeamSetDlg")

	if ui then
		ui:setData()
	end

	local ui = UIManager.tryGetUI("sneakBattleLevelMainDlg")

	if ui then
		ui:setData()
	end
end

function OpActivityMixin:onNewPveResetProgressResp(...)
	local ui = UIManager.tryGetUI("sneakBattleTeamSetDlg")

	if ui then
		ui:setData()
	end

	local ui = UIManager.tryGetUI("sneakBattleLevelMainDlg")

	if ui then
		ui:setData()
	end
end

function OpActivityMixin:onNewPveChooseLimitsResp(...)
	local ui = UIManager.tryGetUI("sneakBattleTeamSetDlg")

	if ui then
		ui:setData()
	end
end

function OpActivityMixin:initSeasonTowerScoreData(achieve_awarded)
	self.serasonTowerAchieveAward = ClientUtils.getBitsDictFromByteString(achieve_awarded)
end

function OpActivityMixin:onOpActTowerRoleAchieveNotify(achieve_awarded)
	self.serasonTowerAchieveAward = ClientUtils.getBitsDictFromByteString(achieve_awarded)
end

function OpActivityMixin:onOpActTowerSweepResp(addScore, dropAdd)
	if addScore ~= 0 or dropAdd ~= 0 then
		local activitySeasonTowerSweepDlg = UIManager.tryGetUI("activitySeasonTowerSweepDlg")

		if activitySeasonTowerSweepDlg then
			activitySeasonTowerSweepDlg:onShowScore(addScore, dropAdd)
		else
			activitySeasonTowerSweepDlg = UIManager.getUI("activitySeasonTowerSweepDlg", true)

			activitySeasonTowerSweepDlg:onShowScore(addScore, dropAdd)
		end
	end
end

function OpActivityMixin:onOpActTowerGetBuffResp(item, sys_buff_id, opId)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj and actObj.actData then
		actObj.actData:onOpActTowerGetBuffResp(item, sys_buff_id)
	end
end

function OpActivityMixin:onOpActTowerUpdateBuffNotify(item, opId)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj and actObj.actData then
		actObj.actData:onOpActTowerUpdateBuffNotify(item)
	end
end

function OpActivityMixin:getSeasonTowerAct()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_SEASON_TOWER then
			return activityObj
		end
	end
end

function OpActivityMixin:getSeasonTowerName(towerId, levelId)
	local actObj = self:getSeasonTowerAct()

	if actObj and actObj.actData then
		return actObj.actData:getTowerName(towerId, levelId)
	end
end

function OpActivityMixin:getEquipRecycleActivity(...)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_EQUIP_RECYCLE and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:getEquipRecycleActivityData(...)
	local actObj = self:getEquipRecycleActivity()

	if actObj then
		return actObj.actData
	end
end

function OpActivityMixin:checkPlotShopNew()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_PLOT and activityObj:isValid() then
			activityObj:checkNew()
		end
	end
end

function OpActivityMixin:onBingoSetBigRewardResp(activity_id, reward_id)
	if self.opActivityObjs[activity_id] then
		self.opActivityObjs[activity_id].actData:updateBigReward(reward_id)
	end

	local mainDlg = UIManager.tryGetUI("activityBingoDlg")

	if mainDlg then
		mainDlg:refreshPanel()
	end
end

function OpActivityMixin:onBingoDrawResp(activityId, index)
	if self.opActivityObjs[activityId] then
		self.opActivityObjs[activityId].actData:updateBingoDraw(index)
	end

	local mainDlg = UIManager.tryGetUI("activityBingoDlg")

	if mainDlg then
		mainDlg:onDrawResp(index)
	end
end

function OpActivityMixin:onBingoNextRoundResp(activity_id, round, big_reward_id, big_reward_times, new_big_reward_id)
	if self.opActivityObjs[activity_id] then
		self.opActivityObjs[activity_id].actData:updateRound(round, big_reward_id, big_reward_times, new_big_reward_id)
	end

	local mainDlg = UIManager.tryGetUI("activityBingoDlg")

	if mainDlg then
		mainDlg:showFinalAward()
	end
end

function OpActivityMixin:onOpActLotteryAddNotify(act_id, code)
	local obj = self.opActivityObjs[act_id]

	if obj then
		local ui = UIManager.getUI("activityLotteryGetCodeDlg", true)

		if ui then
			ui:setCode(obj.actId, code)
		end

		obj.actData:onGetCode(code)
	end
end

function OpActivityMixin:getActPrivilege(privilegeType, preValue, onlyReturnExtra)
	local absValue = 0
	local effValue = 0

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_PRIVILEGE and activityObj:isValid() then
			absValue = absValue + (activityObj.actData:getActPrivilegeValue(privilegeType, true) or 0)
			effValue = effValue + (activityObj.actData:getActPrivilegeValue(privilegeType) or 0)
		end
	end

	if onlyReturnExtra then
		return (preValue or 0) * effValue * 0.0001 + absValue
	else
		return math.max((preValue or 0) * math.max(0, 1 + effValue * 0.0001) + absValue, 0)
	end
end

function OpActivityMixin:isActPrivilegeValid(privilegeType)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_PRIVILEGE and activityObj:isValid() then
			return activityObj.actData:isActPrivilegeValid(privilegeType)
		end
	end

	return false
end

function OpActivityMixin:getAllActPrivilegeObj()
	local activityObjs = {}

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_PRIVILEGE and activityObj:isValid() then
			table.insert(activityObjs, activityObj)
		end
	end

	return activityObjs
end

local function _sortPrivilegeInfo(privilegeInfoA, privilegeInfoB)
	if privilegeInfoA.startTime ~= privilegeInfoB.startTime then
		return privilegeInfoA.startTime > privilegeInfoB.startTime
	elseif privilegeInfoA.resData.index ~= privilegeInfoB.resData.index then
		return privilegeInfoA.resData.index < privilegeInfoB.resData.index
	end
end

function OpActivityMixin:getAllPrivilegeInfoList()
	local activityObjs = CurAvatar:getAllActPrivilegeObj()
	local privilegeInfoList = {}

	for _, activityObj in ipairs(activityObjs) do
		if activityObj.actData and activityObj.actData.clientData and activityObj:getStartEndTime()[1] then
			for _, resInfo in ipairs(activityObj.actData.clientData) do
				local privilegeInfo = {}

				privilegeInfo.startTime = activityObj:getStartEndTime()[1]
				privilegeInfo.resData = resInfo
				privilegeInfo.activityObj = activityObj

				table.insert(privilegeInfoList, privilegeInfo)
			end
		end
	end

	if ClientUtils.getServerTime() < (GameFsm.argLoginRespReconnect or 0) then
		self:addToPrivilegeInfoList(privilegeInfoList, Const.ACT_PRIVILEGE_TYPE_EQUIP_DEBUFF_ID, GameFsm.argLoginRespReconnect)
	end

	local priBuffDataList = self:getAllBuffPrivilege()

	if #priBuffDataList > 0 then
		for _, priBuffData in ipairs(priBuffDataList) do
			self:addToPrivilegeInfoList(privilegeInfoList, priBuffData.resData.show_buff_id, priBuffData.endTime)
		end
	end

	local priDefBuffDataList = self:getAllDefineBuffPrivilege()

	if #priDefBuffDataList > 0 then
		for _, priDefBuffData in ipairs(priDefBuffDataList) do
			self:addToPrivilegeInfoList(privilegeInfoList, priDefBuffData.pri_id, priDefBuffData.endTime)
		end
	end

	table.sort(privilegeInfoList, _sortPrivilegeInfo)

	return privilegeInfoList
end

function OpActivityMixin:addToPrivilegeInfoList(privilegeInfoList, opPrivilegeId, endTime)
	if ResOpActivityPrivilegeDetail[opPrivilegeId] then
		local privilegeInfo = {}

		privilegeInfo.startTime = ClientUtils.getServerTime()
		privilegeInfo.resData = ResOpActivityPrivilegeDetail[opPrivilegeId][1]
		privilegeInfo.endTime = endTime

		table.insert(privilegeInfoList, privilegeInfo)
	end
end

function OpActivityMixin:getAllDefineBuffPrivilege()
	local buffDataList = {}

	for recharge_id, data in pairs(self.monthCardServerData) do
		if ClientUtils.getServerTime() < data.endtime then
			local pri_id = ResCardClient[data.id].show_pri_id

			if pri_id then
				local buffData = {}

				buffData.endTime = data.endtime
				buffData.pri_id = pri_id

				table.insert(buffDataList, buffData)
			end
		end
	end

	return buffDataList
end

function OpActivityMixin:onOpActOnHookRoleDeliverResp(opId, pos, foodId)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onGetFood(pos, foodId)
	end
end

function OpActivityMixin:onOpActHatsuneCheerConvertNotify(act_id, convert_cheer, award_id, num)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj then
		actObj.actData:onCheerConvert(convert_cheer, award_id, num)
	end
end

function OpActivityMixin:onClanOpActClanDataNotify(clanId, data)
	if self.myCircle then
		self.myCircle:onClanOpActClanDataNotify(data)
	end
end

function OpActivityMixin:onClanOpActMemberDataNotify(data)
	if self.myCircle then
		self.myCircle:onClanOpActMemberDataNotify(data)
	end
end

function OpActivityMixin:onOpActFlottoryDrawResp(opId, award)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onDrawResp(award)
	end
end

function OpActivityMixin:onOpActFlottorySetSelIndexResp(opId)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onSelBonusResp()
	end
end

function OpActivityMixin:initRebackData(reflux)
	self.rebackFlag = reflux.flag
	self.rebackBonusDict = ClientUtils.getBitsDictFromByteString(reflux.once_awarded)
	self.rebackGroup = reflux.group
end

function OpActivityMixin:checkRebackState()
	local rebackData = ResRefluxOnceAward[self.rebackFlag]

	if rebackData then
		for index, rData in ipairs(rebackData) do
			local dataGroup = rData.group_id

			if not self.rebackBonusDict[index] and (dataGroup == nil or dataGroup == 0 or dataGroup == self.rebackGroup) then
				local mainStageDlg = UIManager.tryGetUI("mainStageDlg")

				if mainStageDlg then
					local rebackBonusDlg = UIManager.getUI("rebackBonusDlg", true)

					rebackBonusDlg:onShow(self.rebackFlag, self.rebackBonusDict, true)

					return true
				end

				break
			end
		end
	end
end

function OpActivityMixin:checkPushActivityState()
	if self.hasOpenPushActivity then
		return
	end

	local hasValid = false

	for id, configInfo in pairs(ResActivityPushConfig) do
		if ClientUtils.isPushConfigValid(configInfo) then
			hasValid = true

			break
		end
	end

	if hasValid then
		local preTickTime = UserData.loadCommonData("PushActivityTick")

		preTickTime = tonumber(preTickTime)

		if preTickTime and ClientUtils.isTickToday(preTickTime) then
			return
		end

		UIManager.getUI("pushActivityDlg", true)

		self.hasOpenPushActivity = true
	end
end

function OpActivityMixin:onRefluxGetOnceAwardResp(index)
	self.rebackBonusDict[index] = true

	local rebackBonusDlg = UIManager.tryGetUI("rebackBonusDlg")

	if rebackBonusDlg then
		rebackBonusDlg:onGetResp(index)
	end
end

function OpActivityMixin:rebackEntryEnable()
	local rEntryInfo = ResActivityRebackConfig[self.rebackFlag]

	if rEntryInfo then
		for _, info in pairs(rEntryInfo) do
			if info.act_id and self:isActivityOpen(info.act_id) then
				return true
			end
		end
	end

	return false
end

function OpActivityMixin:openRebackDlg()
	local rebackBonusDlg = UIManager.getUI("rebackBonusDlg", true)

	rebackBonusDlg:onShow(self.rebackFlag, self.rebackBonusDict)
end

function OpActivityMixin:onRefluxNewGroupNotify(group_id)
	self.unchooseRebackGroup = group_id
end

function OpActivityMixin:onRefluxNewSetFlagResp(reflux)
	self:initRebackData(reflux)
	self:checkRebackState()
end

function OpActivityMixin:onRefluxDataFreshNotify(reflux_data)
	if reflux_data then
		self:initRebackData(reflux_data)

		if not ClientUtils.isInBeginner() then
			self:checkRebackState()
		end
	end
end

function OpActivityMixin:onOpActCollectWordsGetBuddyWordResp(opId, uid)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onCollectWordsGetBuddyInfo(uid)
	end
end

function OpActivityMixin:onOpActCollectWordsGetDepositResp(opId, item_id)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onCollectWordsGetDeposit(item_id)
	end
end

function OpActivityMixin:onOpActCollectWordsRecvWordResp(opId, item_id)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onCollectWordsRecvWord(item_id)
	end
end

function OpActivityMixin:onOpActCollectWordsComposeWordResp(opId, times)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onCollectWordsCompose(times)
	end
end

function OpActivityMixin:onRoleOpActSimpleGetResp(simple_data)
	if #simple_data > 0 then
		local opId = simple_data[1].act_id
		local actObj = self:getActivityObjByOpId(opId)

		if actObj then
			actObj.actData:onRoleOpActSimpleGet(simple_data)
		end
	end
end

function OpActivityMixin:onNewMazeOpenResp(opId, level)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:setVisible(false)
		end

		CurAvatar:jumpToShowActivity(actObj.actId)

		local cycle = actObj.actData.cycle
		local ratingLevel = actObj.actData.ratingLevel
		local lastPlayLevel = actObj.actData.lastPlayLevel

		UIManager.getUI("newMazeStageHintDlg", true):setData(cycle, ratingLevel, lastPlayLevel)
	end
end

function OpActivityMixin:onNewMazeLevelCycleResetNotify(opId)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:showResetTips()
		end
	end
end

function OpActivityMixin:onNewMazeLevelEnterResp(opId, level, type)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		if type == Const.NEW_MAZE_LEVEL_ENTER_TYPE.Init or type == Const.NEW_MAZE_LEVEL_ENTER_TYPE.FailReset or type == Const.NEW_MAZE_LEVEL_ENTER_TYPE.NextReset then
			local chooseDlg = UIManager.tryGetUI("newMazeChooseDlg")

			if chooseDlg then
				chooseDlg:playChooseAni()
			end
		elseif type == Const.NEW_MAZE_LEVEL_ENTER_TYPE.Next then
			local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

			if mainDlg then
				mainDlg:setVisible(false)
			end

			local chooseDlg = UIManager.tryGetUI("newMazeChooseDlg")

			if chooseDlg then
				chooseDlg:_setData(true)
			else
				chooseDlg = UIManager.getUI("newMazeChooseDlg", true)

				chooseDlg:_setData(true)
			end
		elseif type == Const.NEW_MAZE_LEVEL_ENTER_TYPE.Reset then
			local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

			mainDlg:resetLevelData()
		end
	end
end

function OpActivityMixin:onNewMazeNodeSelectResp(opId, data)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNodeSelectResp(data)
	end
end

function OpActivityMixin:onNewMazeLayerNextNotify(opId)
	local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if mainDlg then
		mainDlg:goNextLayer()
	else
		mainDlg = UIManager.getUI("newMazeMainDlg")

		mainDlg:setData()
		mainDlg:goNextLayer()
	end
end

function OpActivityMixin:onNewMazeMultiAwardListNotify(opId, type, items, notifyType)
	if notifyType == Const.NEW_MAZE_MULTI_AWARD_NOTIFY_TYPE.Fight then
		self.newMazeBattleMultiAward = items
	elseif notifyType == Const.NEW_MAZE_MULTI_AWARD_NOTIFY_TYPE.RandEvent then
		local winDlg = UIManager.getUI("newMazeRandomWinHintDlg", true)
		local isTreasure = true

		winDlg:setData(items, isTreasure)
	elseif notifyType == Const.NEW_MAZE_MULTI_AWARD_NOTIFY_TYPE.Feature then
		local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

		chooseThreeDlg:setData(items, notifyType, type)
	else
		local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

		chooseThreeDlg:setData(items, nil, type)
	end
end

function OpActivityMixin:onNewMazeShopItemUpdateNotify(opId, items, cur_coin_num)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeShopItemUpdateNotify(items, cur_coin_num)
	end
end

function OpActivityMixin:onNewMazeShopPurchaseResp(opId, item, cur_coin_num)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeShopPurchase(item, cur_coin_num)
	end
end

function OpActivityMixin:onNewMazeShopSellResp(opId, item, cur_coin_num)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeShopSell(item, cur_coin_num)
	end
end

function OpActivityMixin:onNewMazeHaloEquipResp(opId, id)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeHaloEquip(id)
	end

	local haloPreviewDlg = UIManager.getUI("newMazeHaloPreviewDlg", true)

	haloPreviewDlg:setData(true)

	local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if mainDlg then
		mainDlg:refreshFettersUI()
	end
end

function OpActivityMixin:onNewMazeHaloUnEquipResp(opId, id)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeHaloUnEquip(id)
	end

	local haloPreviewDlg = UIManager.getUI("newMazeHaloPreviewDlg", true)

	haloPreviewDlg:setData(true)

	local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if mainDlg then
		mainDlg:refreshFettersUI()
	end
end

function OpActivityMixin:onNewMazeItemChangeNotify(opId, type, items)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeItemChangeNotify(items)

		if type == Const.NEW_MAZE_ITEM_CHANGE_TYPE.Normal then
			local chooseThreeDlg = UIManager.tryGetUI("newMazeChooseThreeDlg")

			if chooseThreeDlg then
				chooseThreeDlg:flyImageToUI()
				chooseThreeDlg:onClosePanel()
			end
		elseif type == Const.NEW_MAZE_ITEM_CHANGE_TYPE.RandEvent then
			local isFail = false

			if #items == 0 then
				isFail = true
			end

			for i, item in pairs(items) do
				if item.num < 0 and item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.RedHeart then
					isFail = true
				end

				if item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Buff then
					isFail = true
				end

				if item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero and item.num > 0 and actObj.actData.curSelectHeroList then
					if #actObj.actData.curSelectHeroList == 1 then
						local heroOld = ResNewMazeHero[actObj.actData.curSelectHeroList[1]]
						local heroNew = ResNewMazeHero[item.id]

						if heroNew.quality < heroOld.quality then
							isFail = true
						end
					else
						local highQuality = 0

						for i, heroId in pairs(actObj.actData.curSelectHeroList) do
							if highQuality < ResNewMazeHero[heroId].quality then
								highQuality = ResNewMazeHero[heroId].quality
							end
						end

						if highQuality >= ResNewMazeHero[item.id].quality then
							isFail = true
						end
					end
				end
			end

			actObj.actData.curSelectHeroList = nil

			if isFail then
				local loseDlg = UIManager.getUI("newMazeRandomLoseHintDlg", true)

				loseDlg:setData(items)
			else
				local winDlg = UIManager.getUI("newMazeRandomWinHintDlg", true)

				winDlg:setData(items)
			end
		end
	end
end

function OpActivityMixin:onNewMazeRandomEventOptionSelectResp(opId, index, sub_event)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		local eventId = sub_event.spec_id
		local eventType = sub_event.type
		local battleId = ResNewMazeBattle[eventId].battle_id
		local pveId = battleId
		local battleData = {}

		battleData.newMazeData = {}
		battleData.newMazeData.eventType = eventType
		battleData.newMazeData.eventId = eventId
		battleData.newMazeData.fromRandom = 1
		battleData.newMazeData.isRetry = 0
		battleData.newMazeData.actId = actObj.actId
		battleData.newMazeData.opId = actObj.opId

		CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_NEW_MAZE, battleData)
	end
end

function OpActivityMixin:onNewMazeFeatureUseResp(opId, id, layer)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onFeatureUseResp(id, layer)
	end

	if id == Const.NEW_MAZE_SKILL_ID_REFRESH_NODE then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:goNextLayer()
		end
	elseif id == Const.NEW_MAZE_SKILL_ID_GET_COIN then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:refreshUI()
		end
	end
end

function OpActivityMixin:onNewMazeShopLevelUpNotify(opId)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeShopLevelUpNotify()
	end
end

function OpActivityMixin:onNewMazeSetOutsideRelicResp(opId, hero_id, relic_id)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeSetOutsideRelicResp(hero_id, relic_id)
	end

	self:closeWearDlg()

	local newMazeHeroListDlg = UIManager.tryGetUI("newMazeHeroListDlg")
	local newMazeHeroInfoDlg = UIManager.tryGetUI("newMazeHeroInfoDlg")

	if newMazeHeroListDlg then
		newMazeHeroListDlg:refreshHeroList()

		if newMazeHeroInfoDlg then
			newMazeHeroInfoDlg:refreshUIForNewMaze(newMazeHeroListDlg.filterList)
		end
	end
end

function OpActivityMixin:onNewMazeLevelExitResp(opId, op_type, inherit_flag)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeLevelExitResp(op_type, inherit_flag)
	end
end

function OpActivityMixin:onNewMazeModifyInheritResp(opId, type)
	return
end

function OpActivityMixin:onNewMazeSelectInheritResp(opId, type)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onNewMazeSelectInheritResp(type)

		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:refreshUI()
			mainDlg:refreshFettersUI()
		end

		local boxDetailDlg = UIManager.tryGetUI("newMazeBoxDetailDlg")

		if boxDetailDlg then
			boxDetailDlg:refreshInheritIconNew()
		end
	end
end

function OpActivityMixin:onMysteryShopUpdateNotify(shop_sub_type, goods_item)
	if shop_sub_type == Const.MYSTERY_SHOP_SUB_TYPE_NEW_MAZE then
		local mysteryStoreDlg = UIManager.tryGetUI("newMazeMysteryStoreDlg")

		mysteryStoreDlg = mysteryStoreDlg or UIManager.getUI("newMazeMysteryStoreDlg", true)

		mysteryStoreDlg:setData(shop_sub_type, goods_item)
	elseif shop_sub_type == Const.MYSTERY_SHOP_SUB_TYPE_PET_MAZE then
		local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

		if actObj ~= nil and actObj:isValid() then
			actObj.actData:setMysteryData(goods_item)
		end
	end
end

function OpActivityMixin:onMysteryShopEnterResp(shop_sub_type)
	return
end

function OpActivityMixin:onNewMazeEnchanterUseResp(opId, hero_id, enchanter_id, pos, oldId, newId, enchanterItem)
	if #enchanterItem > 0 then
		UIManager.getUI("newMazeSolderAwardDlg", true):onShow(enchanterItem)
	else
		UIManager.getUI("newMazeSolderReplaceDlg", true):onShow(hero_id, oldId, newId)
	end

	local newMazeHeroListDlg = UIManager.tryGetUI("newMazeHeroListDlg")

	if newMazeHeroListDlg then
		newMazeHeroListDlg:refreshHeroList()
		newMazeHeroListDlg:refreshFettersUI()
	end

	local newMazeChangeSolderDlg = UIManager.tryGetUI("newMazeChangeSolderDlg")

	if newMazeChangeSolderDlg then
		newMazeChangeSolderDlg:refreshUI()
	end

	local newMazeMainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if newMazeMainDlg then
		newMazeMainDlg:refreshFettersUI()
	end
end

local CHECK_ID = 1

function OpActivityMixin:onNewMazeCheckPool(actId, selectIndex, poolId)
	self.newMazePoolSelectIndex = selectIndex

	RPC.newMazeRandPoolCheck(actId, CHECK_ID, poolId, "kNewMazeRandPoolCheckTypeHeroCareer")
end

function OpActivityMixin:onNewMazeRandPoolCheckResp(actid, checkid, randpool, checkType, param)
	if #param == 0 then
		MsgManager.notice(Lang.get(101823))
	else
		UIManager.getUI("newMazeCareerEventChooseDlg", true):onShow(actid, self.newMazePoolSelectIndex, randpool, param)
	end
end

function OpActivityMixin:onNewMazeTalentSetResp(actid, talent_item)
	local newMazeChooseDlg = UIManager.tryGetUI("newMazeChooseDlg")

	if newMazeChooseDlg then
		newMazeChooseDlg:refreshTalentUI()
	end

	local newMazeTalentMainDlg = UIManager.tryGetUI("newMazeTalentMainDlg")

	if newMazeTalentMainDlg then
		newMazeTalentMainDlg:onNewMazeTalentSetResp()
	end
end

function OpActivityMixin:onNewMazeTalentWorkNotify(actid, talentType)
	MsgManager.notice(ResNewMazeDisplay[13060072].desc)
end

function OpActivityMixin:onOpActChatGameMakeChocoleteResp(opId, gift_id, material_num)
	local activityValentineMakeDlg = UIManager.tryGetUI("activityValentineMakeDlg")

	if activityValentineMakeDlg then
		activityValentineMakeDlg:onOpActChatGameMakeChocoleteResp(opId, gift_id, material_num)
	end
end

function OpActivityMixin:onOpActChatGameResetChatResp(opId)
	local activityValentineChatDlg = UIManager.tryGetUI("activityValentineChatDlg")

	if activityValentineChatDlg then
		activityValentineChatDlg:onOpActChatGameResetChatResp(opId)
	end
end

function OpActivityMixin:onOpActChatGameChooseBranchResp(opId, node_id)
	local activityValentineChatDlg = UIManager.tryGetUI("activityValentineChatDlg")

	if activityValentineChatDlg then
		activityValentineChatDlg:onOpActChatGameChooseBranchResp(opId, node_id)
	end
end

function OpActivityMixin:onOpActChatGameChatEndResp(opId, result)
	local activityValentineChatDlg = UIManager.tryGetUI("activityValentineChatDlg")

	if activityValentineChatDlg then
		activityValentineChatDlg:onOpActChatGameChatEndResp()
	end
end

function OpActivityMixin:getTopPVPActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_TOPPVP and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:updataTopPvpBulletSeqMaxId(id)
	if id then
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			actData:updateBulletMaxSeq(id)
		end
	end
end

function OpActivityMixin:getTopPVPActivityData()
	local actObj = self:getTopPVPActivity()

	if actObj then
		return actObj.actData
	end
end

function OpActivityMixin:getTopPVPActivityOpId()
	local actObj = self:getTopPVPActivity()

	if actObj then
		return actObj.opId
	end
end

function OpActivityMixin:TopPvpCanChangeBpHeros()
	local actData = self:getTopPVPActivityData()

	if actData then
		return actData:CanChangeBpHeros()
	end
end

function OpActivityMixin:checkTopPVPGroupMatchQualification()
	local actData = self:getTopPVPActivityData()

	if actData then
		return actData:checkGroupMatchQualification()
	end

	return false
end

function OpActivityMixin:getTopPVPActivityStage(...)
	local actData = self:getTopPVPActivityData()

	if actData then
		return actData:getTopPvpStage()
	end
end

function OpActivityMixin:getTopPvpCurStageRemainTime(...)
	local actData = self:getTopPVPActivityData()

	if actData then
		return actData:getCurStageRemainTime()
	end

	return 0
end

function OpActivityMixin:checkTopPvpKnockoutRoomQualification(knockoutRoom)
	if knockoutRoom and knockoutRoom.knockout_member then
		for i, player in pairs(knockoutRoom.knockout_member) do
			if player.uid == CurAvatar.uid then
				return true
			end
		end
	end

	return false
end

function OpActivityMixin:onBPPvpKnockouotBanRuleSetResp(act_id, room_id, rule_id)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateBpBanRuleId(rule_id)
	end
end

function OpActivityMixin:onBPPvpActivityStateGetResp(state, knockoutRoomId, betRoomId)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateTopPvpState(state)

		if knockoutRoomId then
			actData:updateMyKnockoutRoomId(knockoutRoomId)
		end

		if betRoomId then
			actData:updateBetRoomId(betRoomId)
		end
	end
end

local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")

function OpActivityMixin:onBPPvpGameDataNotify(pvpState, groupRoom, knockoutRoom, roomId, type, roomState, bpData, knockoutFight)
	local actData = self:getTopPVPActivityData()

	if actData then
		local roomData = actData:getChaheRoomData()

		if type then
			if type == "kCSActBPPvpNotifyTypeStateChange" then
				if pvpState then
					if actData then
						actData:updateTopPvpState(pvpState)
					end

					local nowState = actData:getTopPvpStage()
					local myNowRoomid = actData.myKnockoutRoomId

					if actData.inKnockoutRoomId and actData.inKnockoutRoomId == roomData.room_id then
						if actData.stateMap[nowState] == "KnockoutRoomChoose" then
							local ui = UIManager.tryGetUI("topPvpReadyDlg")

							if ui then
								ui:setVisible(false)
							end

							local isFirst = actData:checkBpFirstQualification(roomData)
							local qualification = self:checkTopPvpKnockoutRoomQualification(roomData)

							if qualification then
								local ui = UIManager.tryGetUI("topPvpBpMainDlg")

								if ui then
									ui:setVisible(false)
								end
							end

							if qualification and roomData.room_id == myNowRoomid then
								if roomData.winner == 0 then
									UIManager.getUI("topPvpCoinDlg", true):show(isFirst)
								else
									local member = roomData.knockout_member

									if member and member[1] and member[1].uid then
										local myIndex

										for i = 1, #member do
											if member[i].uid == CurAvatar.uid then
												myIndex = i

												break
											end
										end

										if myIndex == roomData.winner then
											UIManager.getUI("topPvpAutoResultDlg", true):show(true)
											actData:refreshUI()
										else
											UIManager.getUI("topPvpAutoResultDlg", true):show(false)
											actData:refreshUI()
										end
									end
								end
							end
						elseif actData.stateMap[nowState] == "KnockoutRoomFight" then
							local ui = UIManager.tryGetUI("topPvpCoinDlg")

							if ui then
								ui:setVisible(false)
							end

							if roomData and roomData.winner == 0 then
								local ui = UIManager.getUI("topPvpBpMainDlg", true)

								if ui then
									ui:setData()
								end
							elseif roomData and roomData.winner ~= 0 then
								local qualification = self:checkTopPvpKnockoutRoomQualification(roomData)

								if not qualification then
									local ui = UIManager.tryGetUI("topPvpBpMainDlg")

									if ui then
										ui:setVisible(false)
									end

									local ResBPPvpShow = require("ClientData/ResBPPvpShow")
									local desc = ResBPPvpShow[13070008].desc

									if desc then
										MsgManager.notice(desc)
									end
								end
							end
						end
					end
				end
			elseif type == "kCSActBPPvpNotifyTypeKnockoutBPPoolSync" then
				if knockoutRoom and actData.inKnockoutRoomId == knockoutRoom.room_id then
					actData:initCacheRoomData(knockoutRoom)
				end
			elseif type == "kCSActBPPvpNotifyTypeGroupSettle" then
				if roomId then
					actData:updateMyKnockoutRoomId(roomId)
				end
			elseif type == "kCSActBPPvpNotifyTypeKnockoutBP" then
				if actData.inKnockoutRoomId and actData.inKnockoutRoomId == roomId and bpData then
					actData:updateBpData(bpData)
				end
			elseif type == "kCSActBPPvpNotifyTypeKnockoutRoundSettle" then
				if roomId then
					actData:updateMyKnockoutRoomId(roomId)
				end
			elseif type == "kCSActBPPvpNotifyTypeKnockoutFightSettle" then
				if actData.inKnockoutRoomId and actData.inKnockoutRoomId == roomId then
					actData:updateRoomSettle(knockoutFight)
				end

				actData:updateRoomInfoSettle(knockoutFight)
			elseif type == "kCSActBPPvpNotifyTypeRoomStateChange" then
				actData:updateRoomState(roomState)

				if actData.myKnockoutRoomId and roomId and actData.myKnockoutRoomId == roomId then
					actData:updateMyRoomState(roomState)
				end

				local qualification = self:checkTopPvpKnockoutRoomQualification(roomData)
				local nowState = actData:getTopPvpStage()

				if actData.inKnockoutRoomId == roomId then
					local nowState = actData:getTopPvpStage()

					if actData.stateMap[nowState] == "KnockoutRoomFight" then
						local roomStage = actData:getKnockoutRoomStage(roomData.state.timer_id)

						if actData.knockoutStateMap[roomStage] == "BP" or actData.knockoutStateMap[roomStage] == "BPShow" then
							local ui = UIManager.getUI("topPvpBpMainDlg", true)

							if ui then
								ui:setData()
							end
						elseif actData.knockoutStateMap[roomStage] == "Formation" then
							if qualification then
								actData:initFormationRoomData(roomData)
							end

							local ui = UIManager.tryGetUI("topPvpBpMainDlg")

							if ui then
								ui:setVisible(false)
							end

							local battleData = {}

							battleData.topPvpData = {}

							local actObj = CurAvatar:getTopPVPActivity()

							if actObj then
								battleData.topPvpData.actId = actObj.actId
							end

							local formationUI = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

							if qualification and not formationUI then
								CurAvatar:enterFormation(ResBPPvpMisc[1].pve_id, BattleConst.FORMATION_TYPE_TOP_PVP_KNOCKOUT, battleData)
							elseif not qualification then
								UIManager.getUI("topPvpWaittingDlg", true):show(roomData.state, roomId)
							end
						elseif actData.knockoutStateMap[roomStage] == "FightPrepare" then
							local ui = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

							if ui and ui:getVisible() then
								ui:setVisible(false)
							end

							if qualification then
								local ui = UIManager.tryGetUI("battleBeforeWearDlg")

								if ui and ui:getVisible() then
									ui:setVisible(false)
								end

								local ui = UIManager.tryGetUI("topPvpTimeDlg")

								if ui and ui:getVisible() then
									ui:setVisible(false)
								end

								UIManager.getUI("topPvpWaitDlg", true)
							else
								UIManager.getUI("topPvpWaittingDlg", true):show(roomData.state, roomId)
							end
						elseif actData.knockoutStateMap[roomStage] == "FightReq" then
							local ui = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

							if ui and ui:getVisible() then
								ui:setVisible(false)
							end

							if qualification then
								local ui = UIManager.tryGetUI("battleBeforeWearDlg")

								if ui and ui:getVisible() then
									ui:setVisible(false)
								end

								UIManager.getUI("topPvpWaitDlg", true)
							else
								UIManager.getUI("topPvpWaittingDlg", true):show(roomData.state, roomId)
							end
						elseif actData.knockoutStateMap[roomStage] == "CountDown" then
							local ui = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

							if ui and ui:getVisible() then
								ui:setVisible(false)
							end

							if qualification then
								local ui = UIManager.tryGetUI("battleBeforeWearDlg")

								if ui and ui:getVisible() then
									ui:setVisible(false)
								end

								local ui = UIManager.tryGetUI("topPvpWaitDlg")

								if ui and ui:getVisible() then
									ui:setVisible(false)
								end

								UIManager.getUI("battleStartTopPvpDlg", true)
							end

							if not qualification then
								UIManager.getUI("topPvpWaittingDlg", true):show(roomData.state, roomId)
							end
						elseif actData.knockoutStateMap[roomStage] == "Fight" then
							local ui = UIManager.tryGetUI("topPvpWaittingDlg")

							if ui then
								ui:setVisible(false)
							end

							local ui = UIManager.tryGetUI("battleStartTopPvpDlg")

							if ui then
								ui:setVisible(false)
							end

							if roomData.room_id == roomId then
								if roomData.replay_id and roomData.replay_id ~= "0" then
									self.cachedKnockOutData = {}
									self.cachedKnockOutData.startTime = roomData.state.start_time
									self.cachedKnockOutData.roundTime = roomData.round_time

									local comm = actData:getMyKnockoutRoomCommData()

									self.cachedKnockOutData.comm = {}

									if roomData.first_bp_uid == 2 then
										table.insert(self.cachedKnockOutData.comm, comm[2].comm)
										table.insert(self.cachedKnockOutData.comm, comm[1].comm)
									else
										for i = 1, #comm do
											table.insert(self.cachedKnockOutData.comm, comm[i].comm)
										end
									end

									RPC.pVEBattleReplay(tostring(roomData.replay_id), BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
								elseif roomData.replay_id == "0" and roomData.winner ~= 0 and qualification then
									local myIndex

									for i = 1, #roomData.knockout_member do
										if roomData.knockout_member[i].uid == CurAvatar.uid then
											myIndex = i

											break
										end
									end

									if myIndex == roomData.winner then
										UIManager.getUI("topPvpAutoResultDlg", true):show(true)
									else
										UIManager.getUI("topPvpAutoResultDlg", true):show(false)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function OpActivityMixin:onBPPvpKnockoutRoomInfoGetResp(room_info)
	local ui = UIManager.tryGetUI("topPvpMainDlg")

	if ui then
		local qualification = self:checkTopPvpKnockoutRoomQualification(room_info)

		if qualification and ui.panelKnockoutPanel.panelMyMatch:getVisible() then
			ui.panelKnockoutPanel.panelMyMatch:setData(room_info)
		end
	end

	local ui = UIManager.tryGetUI("topPvpRecordInfoDlg")

	if ui and ui:getVisible() and ui.reportData and ui.reportData.room_id and ui.reportData.room_id == room_info.room_id then
		local showUi = UIManager.tryGetUI("topPvpBpReplayDlg")

		if showUi and showUi:getVisible() then
			showUi:show(room_info)
		end
	end

	local actData = CurAvatar:getTopPVPActivityData()

	if actData and room_info and actData.myKnockoutRoomId and actData.myKnockoutRoomId == room_info.room_id then
		actData:updataCacheRoomInfo(room_info)
	end

	if actData and actData.betRoomId and room_info and room_info.room_id == actData.betRoomId then
		actData:updateCacheBetRoomInfo(room_info)

		if actData:checkBetRoomCanEnter() then
			actData:setknockoutBetRoomShow()
		end
	end
end

function OpActivityMixin:checkTopPvpBpSetQualification(...)
	local number = CurAvatar:getHeroSpeciesCount()

	if number >= 30 then
		return true
	end

	return false
end

function OpActivityMixin:onBPPvpGroupEnterRoomResp(state, group_room)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateTopPvpState(state)
	end

	local ui = UIManager.tryGetUI("topPvpMainDlg")

	if ui then
		ui:refreshRedDot()
		ui.panelGroupMatchPanel:setData(group_room.member)
	end
end

function OpActivityMixin:checkTopPvpGroupMatchChanged(uid)
	local actData = self:getTopPVPActivityData()

	if actData then
		return actData:checkGroupMatchChallenged(uid)
	end
end

function OpActivityMixin:onBPPvpKnockoutGetHallDataResp(actId, areaId, state, detail)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateQueryHallTime()

		if state then
			actData:updateTopPvpState(state)
		end
	end

	local ui = UIManager.tryGetUI("topPvpMainDlg")

	if ui and ui.panelKnockoutPanel.panelMatchTable:getVisible() then
		ui.panelKnockoutPanel.panelMatchTable:setCommData(detail)
	end
end

function OpActivityMixin:onBPPvpKnockoutFormationGetResp(formation)
	local actData = CurAvatar:getTopPVPActivityData()

	actData:updateMyKnockoutFormation(formation)

	local formationUI = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

	if not formationUI then
		local battleData = {}

		battleData.topPvpData = {}

		local actObj = CurAvatar:getTopPVPActivity()

		if actObj then
			battleData.topPvpData.actId = actObj.actId
		end

		CurAvatar:enterFormation(ResBPPvpMisc[1].pve_id, BattleConst.FORMATION_TYPE_TOP_PVP_KNOCKOUT, battleData)

		if actData.needShowWatiDlg == true then
			actData.needShowWatiDlg = false

			UIManager.getUI("topPvpWaitDlg", true)
		end
	end
end

function OpActivityMixin:onBPPvpKnockoutEnterRoomResp(room_info, comm, not_allowed)
	local ui = UIManager.tryGetUI("topPvpLiveConfirmDlg")

	if ui then
		ui:setVisible(false)
	end

	if not_allowed == 1 then
		local ResBPPvpShow = require("ClientData/ResBPPvpShow")
		local resData = ResBPPvpShow[13070016]

		if resData then
			local hint = resData.desc

			if hint then
				MsgManager.notice(hint)
			end
		end
	else
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			local qualification = self:checkTopPvpKnockoutRoomQualification(room_info)
			local data = {}

			data.info = room_info
			data.comm = comm

			actData:updateMyKnockRoom(data)
			actData:updateInKnockoutRoomId(room_info.room_id)
			actData:initCacheRoomData(room_info)

			local nowState = actData:getTopPvpStage()

			if actData.stateMap[nowState] == "KnockoutRoomPrepare" or actData.stateMap[nowState] == "KnockoutBPPoolSync" then
				if not qualification then
					local ui = UIManager.getUI("topPvpBpMainDlg", true)

					if ui then
						ui:setData(true)
					end
				end
			elseif actData.stateMap[nowState] == "KnockoutRoomFight" then
				local roomStage = actData:getKnockoutRoomStage(room_info.state.timer_id)

				if actData.knockoutStateMap[roomStage] == "BP" or actData.knockoutStateMap[roomStage] == "BPShow" then
					UIManager.getUI("topPvpBpMainDlg", true):setData(true)
				elseif actData.knockoutStateMap[roomStage] == "Formation" then
					if qualification then
						actData:initFormationRoomData(room_info)
					end

					local ui = UIManager.tryGetUI("topPvpBpMainDlg")

					if ui then
						ui:setVisible(false)
					end

					local battleData = {}

					battleData.topPvpData = {}

					local actObj = CurAvatar:getTopPVPActivity()

					if actObj then
						battleData.topPvpData.actId = actObj.actId
					end

					local formationUI = UIManager.tryGetUI("topPvpKnockoutDragHeroDlg")

					if qualification and not formationUI then
						if actData:checkHaveFormation(room_info) then
							local actId = self:getTopPVPActivityOpId()

							RPC.bPPvpKnockoutFormationGet(actId, CurAvatar.uid, room_info.room_id)
						else
							CurAvatar:enterFormation(ResBPPvpMisc[1].pve_id, BattleConst.FORMATION_TYPE_TOP_PVP_KNOCKOUT, battleData)
						end
					elseif not qualification then
						UIManager.getUI("topPvpWaittingDlg", true):show(room_info.state, room_info.room_id)
					end
				elseif actData.knockoutStateMap[roomStage] == "Fight" then
					if room_info.replay_id and room_info.replay_id ~= "0" then
						self.cachedKnockOutData = {}
						self.cachedKnockOutData.startTime = room_info.state.start_time
						self.cachedKnockOutData.roundTime = room_info.round_time

						local comm = actData:getMyKnockoutRoomCommData()

						self.cachedKnockOutData.comm = {}

						if room_info.first_bp_uid == 2 then
							table.insert(self.cachedKnockOutData.comm, comm[2].comm)
							table.insert(self.cachedKnockOutData.comm, comm[1].comm)
						else
							for i = 1, #comm do
								table.insert(self.cachedKnockOutData.comm, comm[i].comm)
							end
						end

						RPC.pVEBattleReplay(room_info.replay_id, BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
					elseif room_info.replay_id == "0" and room_info.winner ~= 0 then
						if qualification then
							local myIndex

							for i = 1, #room_info.knockout_member do
								if room_info.knockout_member[i].uid == CurAvatar.uid then
									myIndex = i

									break
								end
							end

							if myIndex == room_info.winner then
								UIManager.getUI("topPvpAutoResultDlg", true):show(true)
							else
								UIManager.getUI("topPvpAutoResultDlg", true):show(false)
							end
						else
							local ResBPPvpShow = require("ClientData/ResBPPvpShow")
							local resData = ResBPPvpShow[13070008]

							if resData then
								local hint = resData.desc

								if hint then
									MsgManager.notice(hint)
								end
							end
						end
					end
				elseif actData.knockoutStateMap[roomStage] == "FightPrepare" then
					if qualification then
						local actId = self:getTopPVPActivityOpId()

						actData.needShowWatiDlg = true

						RPC.bPPvpKnockoutFormationGet(actId, CurAvatar.uid, room_info.room_id)
					else
						UIManager.getUI("topPvpWaittingDlg", true):show(room_info.state, room_info.room_id)
					end
				elseif actData.knockoutStateMap[roomStage] == "FightReq" then
					if qualification then
						local actId = self:getTopPVPActivityOpId()

						actData.needShowWatiDlg = true

						RPC.bPPvpKnockoutFormationGet(actId, CurAvatar.uid, room_info.room_id)
					else
						UIManager.getUI("topPvpWaittingDlg", true):show(room_info.state, room_info.room_id)
					end
				elseif actData.knockoutStateMap[roomStage] == "CountDown" then
					if qualification then
						local ui = UIManager.tryGetUI("topPvpWaitDlg")

						if ui and ui:getVisible() then
							ui:setVisible(false)
						end

						local actId = self:getTopPVPActivityOpId()

						RPC.bPPvpKnockoutFormationGet(actId, CurAvatar.uid, room_info.room_id)
					else
						UIManager.getUI("topPvpWaittingDlg", true):show(room_info.state, room_info.room_id)
					end
				end
			elseif actData.stateMap[nowState] == "KnockoutRoomChoose" then
				if qualification then
					if room_info.winner == 0 then
						local isFirst = actData:checkBpFirstQualification(room_info)

						UIManager.getUI("topPvpCoinDlg", true):lastShow(isFirst)
					end
				else
					local ui = UIManager.getUI("topPvpBpMainDlg", true)

					if ui then
						ui:setData()
					end
				end
			elseif actData.stateMap[nowState] == "KnockoutBPPoolSync" then
				if qualification then
					local isFirst = actData:checkBpFirstQualification(room_info)

					UIManager.getUI("topPvpCoinDlg", true):lastShow(isFirst)
				else
					local ui = UIManager.getUI("topPvpBpMainDlg", true)

					if ui then
						ui:setData()
					end
				end
			end
		end
	end
end

function OpActivityMixin:onBPPvpKnockoutBetInfoGetResp(bet_room, blue_bet_num, red_bet_num, rightCount)
	local ui = UIManager.tryGetUI("topPvpGambleMainDlg")

	if ui then
		ui:setGambleInfoData(bet_room, blue_bet_num, red_bet_num, rightCount)
	end

	local ui = UIManager.tryGetUI("topPvpGambleSimpleDlg")

	if ui then
		ui:setData(bet_room)
	end
end

local ResBPPvpShow = require("ClientData/ResBPPvpShow")

function OpActivityMixin:onBPPvpKnockoutBetResp(act_id, room_id, bet_pos, over_time, blue_bet_num, red_bet_num)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateBetTime()
	end

	if over_time == 1 then
		local desc = ResBPPvpShow[13070005].desc

		MsgManager.notice(desc)
	else
		local round = math.floor(room_id % 100 / 10)
		local desc = ResBPPvpShow[13070006].desc

		MsgManager.notice(desc)

		if actData then
			actData:updateBetSupport(blue_bet_num, red_bet_num)
		end

		local ui = UIManager.tryGetUI("topPvpGambleMainDlg")

		if ui then
			ui.panelGambleInfo:setBetPostion(bet_pos)
			ui.panelGambleInfo:setSupportRate(blue_bet_num, red_bet_num)
			ui:refreshRedDot()
		end

		local ui = UIManager.tryGetUI("topPvpGambleSimpleDlg")

		if ui then
			ui:setBetPostion(bet_pos)
		end

		local ui = UIManager.tryGetUI("topPvpMainDlg")

		if ui then
			ui:refreshState()
		end
	end
end

function OpActivityMixin:onBPPvpKnockoutBetHistoryGetResp(bet_his)
	local ui = UIManager.tryGetUI("topPvpGambleMainDlg")

	if ui then
		ui:setGambleRecordData(bet_his)
	end
end

function OpActivityMixin:petPettySystemEnable(...)
	local ResPettyPayTab = require("ClientData/ResPettyPayTab")
	local flag = true

	if ResPettyPayTab and ResPettyPayTab[1] and ResPettyPayTab[1].unlock_condition then
		flag = ConditionLimitManager.inLimitState(ResPettyPayTab[1].unlock_condition)
	end

	return Const.PETTY_PAY_OPEN and not flag
end

function OpActivityMixin:getSeasonPlayActivity(notCheckValid)
	local actOpenObj, preOpenObj

	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_ACHIEVE and activityObj.actData and activityObj.actData.isSeasonMain then
			if activityObj:isValid() then
				actOpenObj = actOpenObj or activityObj

				if not activityObj:inFreeze() then
					actOpenObj = activityObj
				end
			elseif notCheckValid and activityObj.curState == Const.OPACT_STATE_PREOPEN then
				preOpenObj = activityObj
			end
		end
	end

	if actOpenObj then
		return actOpenObj
	else
		return preOpenObj
	end
end

function OpActivityMixin:getSeasonPlayFreezeActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_ACHIEVE and activityObj.actData and activityObj.actData.isSeasonMain and activityObj:inFreeze() then
			return activityObj
		end
	end
end

function OpActivityMixin:onOpActGetAwardResp(...)
	local seasonPlayExchangeDlg = UIManager.tryGetUI("seasonPlayExchangeDlg")

	if seasonPlayExchangeDlg and seasonPlayExchangeDlg:getVisible() then
		seasonPlayExchangeDlg:refreshUI()
	end
end

function OpActivityMixin:initSubscribeData(subscribe_data)
	RedDotManager.setKeyState(UIConst.RD_HINT_FIRST_SUBSCRIBE_AWARD_NOT_GOT, false)

	if not self.subscribeData then
		self.subscribeData = {}
	end

	if subscribe_data then
		self.subscribeData[subscribe_data.id] = {}
		self.subscribeData[subscribe_data.id].endTime = subscribe_data.expire

		if subscribe_data.award_get then
			self.subscribeData[subscribe_data.id].awardGet = subscribe_data.award_get

			if self.subscribeData[subscribe_data.id].endTime ~= 0 and self.subscribeData[subscribe_data.id].awardGet == Const.FIRST_SUBSCRIBE_AWARD_NOT_GET then
				RedDotManager.setKeyState(UIConst.RD_HINT_FIRST_SUBSCRIBE_AWARD_NOT_GOT, true)
			end
		end
	end
end

function OpActivityMixin:onSubscribeDataNotify(subscribe_data)
	if not self.subscribeData then
		self.subscribeData = {}
	end

	if not self.subscribeData[subscribe_data.id] then
		self.subscribeData[subscribe_data.id] = {}
	end

	self.subscribeData[subscribe_data.id].endTime = subscribe_data.expire

	if subscribe_data.award_get then
		self.subscribeData[subscribe_data.id].awardGet = subscribe_data.award_get

		if subscribe_data.expire ~= 0 and subscribe_data.award_get == Const.FIRST_SUBSCRIBE_AWARD_NOT_GET then
			RedDotManager.setKeyState(UIConst.RD_HINT_FIRST_SUBSCRIBE_AWARD_NOT_GOT, true)
		end
	end
end

function OpActivityMixin:getSubscribeDataByRechargeId(rechargeId)
	if rechargeId and self.subscribeData and self.subscribeData[rechargeId] then
		return self.subscribeData[rechargeId]
	end
end

function OpActivityMixin:checkSubscribeEffective(rechargeId)
	if rechargeId then
		local data = self:getSubscribeDataByRechargeId(rechargeId)

		if data then
			local endTime = data.endTime
			local nowTime = ClientUtils.getServerTime()

			return nowTime < endTime
		end
	end
end

function OpActivityMixin:checkPrivilegeMonthCardLapseShow(time, type)
	if not type or not time then
		return
	end

	local showData = CurAvatar:getClientUserData(Const.WELFARETYPE_PRIVILEGEMONTHCARD)

	if not showData[type] or showData[type] ~= time then
		showData[type] = time

		CurAvatar:setClientUserData(Const.WELFARETYPE_PRIVILEGEMONTHCARD, showData)

		local ResClientNotice = require("ClientData/ResClientNotice")

		if ResClientNotice[769] then
			MsgManager.notice(ResClientNotice[769].desc)
		end
	end
end

function OpActivityMixin:initCumulativeCountData(count)
	if count then
		if not self.cumulativeCountData then
			self.cumulativeCountData = {}
		end

		for index, data in ipairs(count.data) do
			self.cumulativeCountData[index] = data.number
		end
	end
end

function OpActivityMixin:getCumulativeCountDataByType(type)
	if self.cumulativeCountData and self.cumulativeCountData[type] then
		return self.cumulativeCountData[type]
	end
end

function OpActivityMixin:onRoleCountNotify(type, number)
	if not self.cumulativeCountData then
		self.cumulativeCountData = {}
	end

	self.cumulativeCountData[type] = number
end

function OpActivityMixin:onNotifyActBonus(attrs, items)
	local relatedActTabs = {}

	for i, attr in ipairs(attrs) do
		local id = Const.MONEY_TYPE2ID[attr.value]

		if id then
			attr.id = id

			table.insert(items, attr)
		end
	end

	for _, item in ipairs(items) do
		local resData = ResItem[item.id]

		if resData and resData.related_activity then
			for _, actId in ipairs(resData.related_activity) do
				if not relatedActTabs[actId] then
					relatedActTabs[actId] = true

					self:onUpdateItemChanged(actId)
				end
			end
		end
	end
end

function OpActivityMixin:onUpdateItemChanged(actId)
	local tempData = ResOpActivityClientTemplate[actId]

	if tempData then
		local config = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[tempData.template_type]

		if config and config[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW then
			local ui = UIManager.getUI(config[1], nil, false)

			if ui and ui.onUpdateItemChanged then
				ui:onUpdateItemChanged()
			end
		end
	end
end

function OpActivityMixin:checkActivityConditionLimit(actConditionId)
	local condData = ResOpActivityConditionLimit[actConditionId]

	if condData then
		if condData.type == Const.ACT_CONDITION_TYPE_SPECIAL_LIMIT then
			return self:checkActivitySpecialLimit(condData)
		elseif condData.type == Const.ACT_CONDITION_TYPE_TIME_VALID then
			if ClientUtils.isTimeConfigPassed(condData.param1) then
				return true
			else
				return false, condData.unlock_desc
			end
		elseif condData.type == Const.ACT_CONDITION_TYPE_TIME_RANGE then
			if ClientUtils.isTimeConfigPassed(condData.param1) and not ClientUtils.isTimeConfigPassed(condData.param2) then
				return true
			else
				return false, condData.unlock_desc
			end
		elseif condData.type == Const.ACT_CONDITION_TYPE_MAIN_STAGE then
			if self:mainStageStatePassed(1, condData.param1, condData.param2) then
				return true
			else
				return false, condData.unlock_desc
			end
		elseif condData.type == Const.ACT_CONDITION_TYPE_VIP_LEVEL then
			if self.vipLevel >= condData.param1 then
				return true
			else
				return false, condData.unlock_desc
			end
		end

		local actObj = self:getActivityObj(condData.templ_id)

		if actObj and actObj:isValid() then
			if condData.type == Const.ACT_CONDITION_TYPE_ACHIEVE then
				local state = actObj.actData:getAchieveState(condData.param1, condData.param2)

				if state ~= Const.ACT_ACHIEVE_STATE_ENOUGH and state ~= Const.ACT_ACHIEVE_STATE_GOT then
					return false, condData.unlock_desc
				end

				if condData.param3 and ConditionLimitManager.inLimitState(condData.param3) then
					return false, ConditionLimitManager.getLimitUnlockDesc(condData.param3)
				end

				return true
			elseif condData.type == Const.ACT_CONDITION_TYPE_GROUP_ACHIEVE_COMPLETE then
				return actObj.actData:isAllCompleteFromGroup(condData.param1), condData.unlock_desc
			elseif condData.type == Const.ACT_CONDITION_TYPE_GROUP_ACHIEVE_RETURN then
				if not condData.param1 or condData.param1 == self.rebackGroup then
					return true
				else
					return false, condData.unlock_desc
				end
			elseif condData.type == Const.ACT_CONDITION_TYPE_SHOP then
				if actObj.actData:getHasBuyNum(condData.param1) >= condData.param2 then
					return true
				else
					return false, condData.unlock_desc or Lang.get(55415)
				end
			elseif condData.type == Const.ACT_CONDITION_TYPE_WORLD_ACHIEVE then
				if actObj.actData:getAchieveProgress(condData.param1) >= condData.param2 then
					return true, nil, condData.param2
				else
					return false, nil, condData.param2
				end
			else
				return false, condData.unlock_desc
			end
		end
	end

	return false, condData and condData.unlock_desc
end

function OpActivityMixin:checkActivitySpecialLimit(condData)
	if condData.param1 == 1 then
		local actObj = self:getActivityObjByType(Const.ACT_TYPE_MONOPOLY)

		if actObj then
			local args = actObj.clientTemplateData.template_args

			if args and tonumber(args[1]) then
				local achieveActObj = self:getActivityObj(tonumber(args[1]))

				if achieveActObj and achieveActObj.actData:getAchieveProgress() >= condData.param2 then
					return true
				end
			end
		end
	end

	return false, condData.unlock_desc
end

function OpActivityMixin:hookActivityBonus(subReason, attrs, items, heros, equip, artifact, relic, notifyType)
	if subReason == 16 then
		self.fLottoryCommonBonus = {
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		}

		return true
	elseif subReason == 17 then
		self.fLottorySpecBonus = {
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		}

		return true
	elseif subReason == 18 then
		self.fLottoryRoundBonus = {
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		}

		return true
	elseif subReason == 21 then
		self.collectWordsComposeBonus = {
			notifyType,
			attrs,
			items,
			heros,
			equip,
			artifact,
			relic
		}

		return true
	end

	return false
end

function OpActivityMixin:getRedPackageActivity()
	for _, showInfo in pairs(ResRedPacketShow) do
		if showInfo.act_id then
			local activityObj = self:getActivityObj(showInfo.act_id)

			if activityObj and activityObj:isValid() then
				return activityObj
			end
		end
	end
end

function OpActivityMixin:onOpActGuessChooseAnswerResp(answerId, rightNum, wrongNum)
	return
end

function OpActivityMixin:onOpActGuessAwardInfuseResp(opId, stageId, award, rightNum, wrongNum)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onOpActGuessAwardInfuseResp(stageId, award, rightNum, wrongNum)
	end

	EventCenter.sendEvent(EventConst.FIGURE_GUESS_GET_CIRCLE_AWARD, stageId, award, rightNum, wrongNum)
end

function OpActivityMixin:onPetMazeSaveFormationResp(opId, level, selectHeroList)
	return
end

function OpActivityMixin:onPetMazeSaveSupportFormationResp(opId, level, stageId, selectHeroList)
	return
end

function OpActivityMixin:onPetMazeResetResp(actId, level, stageId)
	return
end

function OpActivityMixin:onPetMazeSweepResp(opId, layer)
	local actObj = self:getActivityObjByOpId(opId)

	if actObj then
		actObj.actData:onPetMazeSweepResp(layer)
	end
end

function OpActivityMixin:checkPetDrawActivityNew()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_PET_DRAW and activityObj:isValid() then
			activityObj:checkNew()
		end
	end
end

function OpActivityMixin:onOpActBusinessMaterialProductResp(act_id, info_list)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessMaterialProductResp(info_list)
	end
end

function OpActivityMixin:onOpActBusinessMaterialComposeResp(act_id, info_list, move)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessMaterialComposeResp(info_list, move)
	end
end

function OpActivityMixin:onOpActBusinessMaterialUpgradeResp(act_id, grid_pos, grid)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessMaterialUpgradeResp(grid_pos, grid)
	end
end

function OpActivityMixin:onOpActBusinessMaterialDeleteResp(act_id, grid_pos, move)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessMaterialDeleteResp(grid_pos, move)
	end
end

function OpActivityMixin:onOpActBusinessStaminaReceiveResp(act_id, buddy_uid)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessStaminaReceiveResp(buddy_uid)
	end
end

function OpActivityMixin:onOpActBusinessStaminaDonatedResp(act_id, buddy_uid)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessStaminaDonatedResp(buddy_uid)
	end
end

function OpActivityMixin:onOpActBusinessOrderCommitResp(act_id, order_index, grid_pos, move)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessOrderCommitResp(order_index, grid_pos, move)
	end
end

function OpActivityMixin:onOpActBusinessOrderUpdateResp(act_id, order_index, order)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessOrderUpdateResp(order_index, order)
	end
end

function OpActivityMixin:onOpActBusinessPermissionAddNotify(act_id, permission_type, param)
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj then
		actObj.actData:onOpActBusinessPermissionAddNotify(permission_type, param)
	end
end

function OpActivityMixin:onOpActTurnTableDrawResp(act_id, items)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj then
		local mallUI = UIManager.getUI("mallDlg", nil, false)

		if mallUI then
			mallUI:onTurnTableDrawResp(items)
		end
	end
end

function OpActivityMixin:onGiftDrawWinnersListGetResp(act_id, level, level_list)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj then
		actObj.actData:updateGetDrawLogTime(level_list)

		local levelId = self.curGiftDrawLogLevelId or 1
		local activityBuyGiftDrawLogDlg = UIManager.getUI("activityBuyGiftDrawLogDlg", nil, false)

		if activityBuyGiftDrawLogDlg then
			activityBuyGiftDrawLogDlg:setData(actObj, levelId, level_list)
		else
			UIManager.getUI("activityBuyGiftDrawLogDlg", true):setData(actObj, levelId, level_list)
		end
	end
end

function OpActivityMixin:onGiftDrawGiftShareResp(act_id, level)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj then
		actObj.actData:updateGiftDrawShareTime()
		MsgManager.notice(Lang.get(86680))
	end
end

function OpActivityMixin:onGiftDrawResultNotify(act_id, level, round, uid)
	local actObj = self:getActivityObj(act_id)

	if actObj and actObj:isValid() then
		local isBuy = false

		for i, v in pairs(actObj.actData.selfBuyData or {}) do
			if v.level == level then
				isBuy = v.last_buy_round == round
			end
		end

		if isBuy then
			actObj.actData.showRedDotTab[level] = true

			actObj:checkNew()
		end

		local isInPage = false
		local actMainDlg = UIManager.tryGetUI("activityMainDlg")

		if actMainDlg and actMainDlg:checkActPageVisible(actObj) then
			isInPage = true

			RPC.opActivityData("kOpActivitySyncMgrData", 0, actObj.opId)
			actMainDlg:playSpecialShow(actObj, {
				level
			})
		end

		if isBuy and not isInPage then
			local actInfo = {}

			actInfo.level = level
			actInfo.levelTitle = actObj.actData.detailData[level].price_title
			actInfo.round = round
			actInfo.actId = act_id
			actInfo.uid = uid

			self:getRoleCommInfosNoTip({
				uid
			}, Functor(self.setWinnerInfo, self, actInfo))
		end
	end
end

function OpActivityMixin:setWinnerInfo(actInfo)
	local winnerInfo = self:getRoleInfoByUid(actInfo.uid)

	if winnerInfo then
		local playerComm = winnerInfo.commInfo

		self:addActMsgNoticeCache(Const.RENT_NOTICE_TYPE.GiftDrawMsg, actInfo, playerComm)
	end
end

function OpActivityMixin:addActMsgNoticeCache(msgType, actInfo, playerComm)
	RentMsgManager.addRentMsg(msgType, actInfo, playerComm)
end

function OpActivityMixin:checkActGiftDrawRechargeNotice(recharge_id)
	local rechargeData = ResRecharge[recharge_id]

	if rechargeData then
		local relatedActId = ResRechargeGiftDraw[1].relate_act
		local actObj = CurAvatar:getActivityObj(relatedActId)

		if actObj and actObj:isValid() and not actObj:inFreeze() then
			for _, v in pairs(actObj.actData.detailData or {}) do
				if rechargeData.cost_rmb >= v.min_price and rechargeData.cost_rmb <= v.max_price then
					local curSelfBuyRound = 1
					local curSelfBuyCount = 0
					local isDraw = false
					local lastDrawTimes = 0

					for _, data in pairs(actObj.actData.selfBuyData or {}) do
						if data.level == v.level_id then
							curSelfBuyRound = data.buy_round or 1
							curSelfBuyCount = data.buy_count or 0

							break
						end
					end

					for i, mgrData in pairs(actObj.actData.giftDrawData) do
						if mgrData.level == v.level_id then
							if curSelfBuyRound < mgrData.cur_round then
								isDraw = true
							else
								lastDrawTimes = v.draw_times - mgrData.cur_progress
							end

							if actObj.actData.specialGiftTableData[recharge_id] then
								local mutiCount = actObj.actData.specialGiftTableData[recharge_id].count

								if mgrData.cur_progress + mutiCount > v.draw_times then
									isDraw = true
									curSelfBuyRound = curSelfBuyRound + 1
									curSelfBuyCount = mgrData.cur_progress + mutiCount - v.draw_times

									break
								end

								curSelfBuyCount = curSelfBuyCount + mutiCount
								lastDrawTimes = v.draw_times - mgrData.cur_progress - mutiCount
							end

							break
						end
					end

					local percent = string.format("%0.2f%%", curSelfBuyCount / v.draw_times * 100)
					local content = utils.format(Lang.get(88554), v.price_title, curSelfBuyRound, percent)

					if isDraw then
						content = string.format(Lang.get(86862), content)
					else
						content = utils.format(Lang.get(88555), content, lastDrawTimes)
					end

					if not self.giftDrawNoConfirm then
						UIManager.getUI("buyGiftDrawConfirmDlg", true):showUI(content)

						break
					end

					MsgManager.notice(content)

					break
				end
			end
		end
	end
end

function OpActivityMixin:onOpActEquipMakeChooseResp(act_id, type, equip)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local activityEquipMakeDlg = UIManager.tryGetUI("activityEquipMakeDlg")

		if activityEquipMakeDlg then
			activityEquipMakeDlg:playSpecShow(type, equip)
		end
	end
end

function OpActivityMixin:onOpActEquipMakeRandResp(act_id, type)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local activityEquipMakeDlg = UIManager.tryGetUI("activityEquipMakeDlg")

		if activityEquipMakeDlg then
			activityEquipMakeDlg:playRefreshShow()
		end
	end
end

function OpActivityMixin:onOpActEquipBaptizeChooseResp(act_id)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local activityEquipReformDlg = UIManager.tryGetUI("activityEquipReformDlg")

		if activityEquipReformDlg then
			activityEquipReformDlg:onChooseEquipResp()
		end
	end
end

function OpActivityMixin:onOpActEquipBaptizeAttrLockResp(act_id, pos)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local activityEquipReformDlg = UIManager.tryGetUI("activityEquipReformDlg")

		if activityEquipReformDlg then
			activityEquipReformDlg:refreshSubAttrPanel()
		end
	end
end

function OpActivityMixin:onOpActEquipBaptizeInitResp(act_id)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local activityEquipReformDlg = UIManager.tryGetUI("activityEquipReformDlg")

		if activityEquipReformDlg then
			activityEquipReformDlg:playRefreshSubAttrAni()
		end
	end
end

function OpActivityMixin:onOpActEquipBaptizeDoneResp(act_id, equip)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local activityEquipReformDlg = UIManager.tryGetUI("activityEquipReformDlg")

		if activityEquipReformDlg then
			activityEquipReformDlg:playFinishAni(equip)
		end
	end
end

function OpActivityMixin:onOpActEquipBaptizeRandAttrResp(act_id)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		actObj.actData:checkReformLvUp()

		local activityEquipReformDlg = UIManager.tryGetUI("activityEquipReformDlg")

		if activityEquipReformDlg then
			activityEquipReformDlg:playRefreshSubAttrAni()
		end
	end
end

function OpActivityMixin:getNewbieUpActivity(...)
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP and activityObj:isValid() then
			return activityObj
		end
	end
end

function OpActivityMixin:onOpActRandReplaceSetResp(act_id, group_id, index)
	local actObj = self:getNewbieUpActivity()

	if actObj and actObj:isValid() then
		local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

		if drawCardMainDlg then
			local career = actObj.actData:getCareerByGroupId(group_id)

			drawCardMainDlg:changePanelInfo(career)
			drawCardMainDlg:refreshPool()
		end
	end

	local actObj = self:getSeasonDrawCardActivity()

	if actObj and actObj:isValid() then
		local seasonPlayUpDlg = UIManager.tryGetUI("seasonPlayUpDlg")

		if seasonPlayUpDlg then
			seasonPlayUpDlg:refreshUI()
		end
	end

	local seasonPlaySkinPoolDlg = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

	if seasonPlaySkinPoolDlg then
		seasonPlaySkinPoolDlg:_setData()
	end
end

function OpActivityMixin:onOpActDrawNewbieUpNewCycleResp(act_id, new_cycle)
	local actObj = self:getActivityObjByOpId(act_id)

	if actObj and actObj:isValid() then
		local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

		if drawCardMainDlg then
			drawCardMainDlg:refreshPool()
		end
	end
end

function OpActivityMixin:getSeasonDrawCardActivity()
	for opActId, activityObj in pairs(self.opActivityObjs) do
		if activityObj.actType == Const.ACT_TYPE_SEASON_DRAW and activityObj:isValid() then
			return activityObj
		end
	end
end

return OpActivityMixin
