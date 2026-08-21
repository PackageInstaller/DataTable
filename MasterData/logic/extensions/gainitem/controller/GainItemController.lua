-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/controller/GainItemController.lua

module("logic.extensions.gainitem.controller.GainItemController", package.seeall)

local OptionType = GameEnum.OptionType
local ItemType = GameEnum.ItemTypeEnum
local M = class("GainItemController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._reasonFuncMap = {}
	self._additionalViewMap = {}
	self._openOtherViewMap = {}
end

function M:onInit()
	self:_registerReasonFunc()
	self:_registerAdditionalViewFunc()
	self:_registerOpenOtherViewFunc()
	GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._dealGainItemAdd, self)
	GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleGainItemViewClose, self)
	GlobalDispatcher:addEventListener(EventType.GET_ROLE_VIEW_CLOSE, self._handleGetRoleViewClose, self)
end

function M:preCreate()
	ViewMgr.instance:preCreate(ViewName.GainItemView)
	ViewMgr.instance:preCreate(ViewName.ItemConvert)
end

function M:_registerReasonFunc()
	self._reasonFuncMap[OptionType.DUNGEON_FIRST_PASSED] = self._handleMainlinePlotFirstReward
	self._reasonFuncMap[OptionType.DUNGEON_NORMAL_PASSED] = self._handleEmpty
	self._reasonFuncMap[OptionType.DUNGEON_FAILED_RETURNED] = self._handleEmpty
	self._reasonFuncMap[OptionType.DUNGEON_STAR] = self._handleEmpty
	self._reasonFuncMap[OptionType.DEFAULT_ADD] = self._handleEmpty
	self._reasonFuncMap[OptionType.TIME_RECOVER_ENERGY] = self._handleEmpty
	self._reasonFuncMap[OptionType.DUNGEON_MATERIAL_GOLD] = self._handleEmpty
	self._reasonFuncMap[OptionType.DUNGEON_MATERIAL_EXP] = self._handleEmpty
	self._reasonFuncMap[OptionType.HOUSE_HOLD_RECEIVE_REPORT] = self._handleEmpty
	self._reasonFuncMap[OptionType.HOUSE_RECEIVE_ALL] = self._handleEmpty
	self._reasonFuncMap[OptionType.HOUSE_HOLD_SPEED_UP_COST] = self._handleEmpty
	self._reasonFuncMap[OptionType.HOUSE_FURNITURE_CHANGE] = self._handleEmpty
	self._reasonFuncMap[OptionType.FOOTBALL_GAME_SETTLE] = self._handleEmpty
	self._reasonFuncMap[OptionType.PORTRAIT_WITH_HERO] = self._handleEmpty
	self._reasonFuncMap[OptionType.GM_ADD_TEST_ITEM_AND_HERO] = self._handleEmpty
	self._reasonFuncMap[OptionType.CREATE_PLAYER] = self._handleEmpty
	self._reasonFuncMap[OptionType.CURRENCY_EXCHANGE] = self._handleExchangeEmpty
	self._reasonFuncMap[OptionType.SIGN_IN_DAILY] = self._handleSignIn
	self._reasonFuncMap[OptionType.SIGN_IN_HISTORY] = self._handleSignIn
	self._reasonFuncMap[OptionType.LOTTERY] = self._handleLottery
	self._reasonFuncMap[OptionType.PLAYER_LEVELUP] = self._handleLevelUp
	self._reasonFuncMap[OptionType.HERO_BREAK_COMPOSE] = self._handleDECompose
	self._reasonFuncMap[OptionType.ECHO_ITEM_DECOMPOSE] = self._showActualGainItem
	self._reasonFuncMap[OptionType.EQUIP_DECOMPOSE] = self._showActualGainItem
	self._reasonFuncMap[OptionType.DICE_DECOMPOSE] = self._showActualGainItem
	self._reasonFuncMap[OptionType.HOUSE_DECOMPOSE_FURNITURES] = self._handleDECompose
	self._reasonFuncMap[OptionType.TACIT_TASK] = self._handleTacitTask
	self._reasonFuncMap[OptionType.ACHIEVEMENT_REWARD] = self._handleAchievementReward
	self._reasonFuncMap[OptionType.MonthlyCard] = self._handleSignIn
	self._reasonFuncMap[OptionType.Mall] = self._handleMallGainItem
	self._reasonFuncMap[OptionType.AIR_WEEK_REWARD] = self._handleAirWorkShopRodeoWeek
	self._reasonFuncMap[OptionType.CLIP_DOLL] = self._handleEmpty
	self._reasonFuncMap[OptionType.NEWBIE_TASK] = self._handleNewbie
	self._reasonFuncMap[OptionType.SEASON_TASK_REWARD] = self._handleSeasonTaskReward
	self._reasonFuncMap[OptionType.SEASON_SCHEDULE_REWARD] = self._handleSeasonSheduleReward
	self._reasonFuncMap[OptionType.MONTH_SIGN_IN] = self._openGainViewDirectly
	self._reasonFuncMap[CommEnum.ItemChangeClientOptType.BattleIn] = self._handBattle
end

function M:_registerAdditionalViewFunc()
	self._additionalViewMap[ItemType.ProtomerItemType] = self._addViewProtomerUnlock
end

function M:_registerOpenOtherViewFunc()
	self._openOtherViewMap[ItemType.RoguelikeClueType] = self._openRogueThreadTipsView
	self._openOtherViewMap[ItemType.Portrait] = self._openMaskView
	self._openOtherViewMap[ItemType.TreasureBox] = self._setTreasureBoxView
end

function M:showGainItems(GainItemsData, openByBlock)
	self:_handleCommonGain(GainItemsData, openByBlock)
end

function M:_openGainViewDirectly(GainItemsData)
	self:_handleCommonGain(GainItemsData, false)
end

function M:_handleExchangeEmpty(GainItemsData)
	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		RetrieveFacade.instance:tryForceLottery(GainItemsData.showItems)
	else
		self:_handleCommonGain(GainItemsData, true)
	end
end

function M:openView(itemDataList, getLstFromModel, additionalViewLst, titleStr, openByBlock, exitCallBack, exitCallBackHandler)
	ToolTipsMgr.showGainItemView({
		showRewardTag = false,
		itemDataList = itemDataList,
		getLstFromModel = getLstFromModel,
		additionalViewLst = additionalViewLst,
		titleStr = titleStr,
		exitCallBack = exitCallBack,
		exitCallBackHandler = exitCallBackHandler
	}, openByBlock)
end

function M:_dealGainItemAdd(e, params)
	local gainItemsData = GainItemsData.New(params)
	local optType = self:_calOptType(gainItemsData)

	if optType then
		local fun = self._reasonFuncMap[optType]

		if fun then
			fun(self, gainItemsData)
		else
			self:_handleCommonGain(gainItemsData, true)
		end
	end
end

function M:_calOptType(GainItemsData)
	if GainItemsData.isHasPlayerAttr then
		-- block empty
	end

	if #GainItemsData.showItems <= 0 then
		return false
	end

	if BattleMgr.instance:isInBattle() then
		return CommEnum.ItemChangeClientOptType.BattleIn
	end

	return GainItemsData.originPushInfo.optType
end

function M:_handleEmpty()
	return
end

function M:_handleCommonGain(GainItemsData, openByBlock)
	self._optType = false

	if not self:_tryOpenOtherView(GainItemsData) then
		return
	end

	GainItemModel.instance:handleItemAddEvent(GainItemsData.addItemsBeforeConvert, GainItemsData.heroIdsAddBeforeConvert)

	local addViewlst = self:_tryOpenAdditionalView(GainItemsData.addItemsWithoutHeroBeforeConvert)

	self:openView(GainItemsData.addItemsBeforeConvert, true, addViewlst, nil, openByBlock)

	if #GainItemsData.firstRepeatUseItems > 0 then
		ItemConvertController.instance:setOptType(self._optType or GameEnum.OptionType.ITEM_CONVERSION)
		ItemConvertController.instance:setCacheSourceMOList(GainItemsData.firstRepeatUseItems)
		ItemConvertController.instance:setCacheItemMOList(GainItemsData.repeatAddItems)
	end
end

function M:_tryOpenOtherView(GainItemsData)
	local dataList = GainItemsData.addItemsWithoutHeroBeforeConvert

	if dataList and #dataList > 0 then
		for index, itemData in ipairs(dataList or {}) do
			local itemTyp = itemData:getType()
			local openViewFunc = self._openOtherViewMap[itemTyp]

			if openViewFunc then
				local isContinueOpenGainView = openViewFunc(self, GainItemsData)

				return isContinueOpenGainView
			end
		end
	end

	return true
end

function M:_tryOpenAdditionalView(dataList)
	local addViewLst = {}

	if dataList and #dataList > 0 then
		for index, itemData in ipairs(dataList or {}) do
			local itemTyp = itemData:getType()
			local addViewFunc = self._additionalViewMap[itemTyp]

			if addViewFunc then
				local addView = addViewFunc(self, itemData)

				table.insert(addViewLst, addView)
			end
		end
	end

	return addViewLst
end

function M:_handBattle(GainItemsData)
	BattleCalculateModel.instance:setCacheItemMOList(GainItemsData.addItemsBeforeConvert)

	if #GainItemsData.firstRepeatUseItems > 0 then
		ItemConvertController.instance:setOptType(GainItemsData.originPushInfo.optType)
		ItemConvertController.instance:setCacheSourceMOList(GainItemsData.firstRepeatUseItems)
		ItemConvertController.instance:setCacheItemMOList(GainItemsData.repeatAddItems)
	end
end

function M:_showActualGainItem(GainItemsData)
	self:openView(GainItemsData.showItems, nil, nil, nil, true)
end

function M:_handleMallGainItem(GainItemsData)
	local hasEchoCardPack = false

	for i = 1, #GainItemsData.showItems do
		local itemData = GainItemsData.showItems[i]

		if itemData:getSubType() == GameEnum.PropSubTypeEnum.EchoCardPack then
			hasEchoCardPack = true

			break
		end
	end

	local viewData = {
		itemDataList = GainItemsData.showItems,
		jumpId = hasEchoCardPack and 10100008 or nil
	}

	TipsBlockController.instance:openView(ViewName.GainItemView, viewData)
end

function M:_handleLevelUp(GainItemsData)
	if Astral.OSDef.isEditor then
		print("玩家升级奖励推送")
		TableUtil.dump(GainItemsData.showItems)
	end
end

function M:_handleLottery(GainItemsData)
	RetrieveController.instance:setCacheItemMOList(GainItemsData.showItems)
end

function M:_handleTacitTask(GainItemsData)
	TacitModel.instance:setCacheItemMOList(GainItemsData.showItems)
end

function M:_handleSignIn(GainItemsData)
	WelfareSigninModel.instance:setCacheItemMOList(GainItemsData.showItems)
end

function M:_handleGainItemViewClose(e, itemDataLst)
	if SceneMgr.instance:getCurSceneType() == SceneType.Lottery then
		GainItemModel.instance:handleGainItemViewClose()

		return
	end

	local heroId = 0

	for _, itemData in ipairs(itemDataLst or {}) do
		if itemData then
			local type = itemData:getType()

			if type == GameEnum.ItemTypeEnum.HeroType then
				heroId = itemData:getItemId()
			end
		end
	end

	if heroId ~= 0 then
		RetrieveFacade.instance:showGetRole(heroId)
	end

	GainItemModel.instance:handleGainItemViewClose()
end

function M:_handleGetRoleViewClose()
	ItemConvertController.instance:popCacheItemMoList()
	ItemConvertController.instance:clearCache()
end

function M:_openRogueThreadTipsView(GainItemsData)
	local dataList = GainItemsData.addItemsWithoutHeroBeforeConvert
	local itemData = dataList[1]

	self._curRogueThreadItemData = itemData

	removetimer(self.checkShowRogueThreadTips, self)
	settimer(0.2, self.checkShowRogueThreadTips, self, true)

	return false
end

function M:getIsShowRogueThreadTips()
	return self._curRogueThreadItemData ~= nil
end

function M:clearRogueThreadData()
	self._curRogueThreadItemData = nil
end

function M:checkShowRogueThreadTips()
	if StoryController.instance:isInStory() then
		return
	end

	ViewMgr.instance:open(ViewName.RogueThreadTips, self._curRogueThreadItemData)
	removetimer(self.checkShowRogueThreadTips, self)
end

function M:_openMaskView(GainItemsData)
	if #GainItemsData.firstRepeatUseItems > 0 then
		ItemConvertController.instance:setOptType(GameEnum.OptionType.ITEM_CONVERSION)
		ItemConvertController.instance:setCacheSourceMOList(GainItemsData.firstRepeatUseItems)
		ItemConvertController.instance:setCacheItemMOList(GainItemsData.repeatAddItems)
		ItemConvertController.instance:popCacheItemMoList()
	else
		local dataList = GainItemsData.addItemsWithoutHeroBeforeConvert
		local itemData = dataList[1]

		ViewMgr.instance:open(ViewName.GainMaskView, itemData)
	end

	return false
end

function M:_setTreasureBoxView(GainItemsData)
	self._optType = GameEnum.OptionType.ITEM_USE

	return true
end

function M:_addViewProtomerUnlock(itemData)
	local info = {}

	info.viewName = ViewName.FacilityHoldingPreviewView
	info.protomerId = itemData:getItemId()
	info.typ = 1

	return info
end

function M:_handleDECompose(GainItemsData)
	ItemConvertController.instance:setOptType(GainItemsData.originPushInfo.optType)
	ItemConvertController.instance:setCacheSourceMOList(GainItemsData.composeUseItems)
	ItemConvertController.instance:setCacheItemMOList(GainItemsData.showItems)
	GlobalDispatcher:dispatchEvent(EventType.ITEM_CONVERT_REFLASH_EVENT)

	if not ViewMgr.instance:isOpen(ViewName.ItemConvert) and not ViewMgr.instance:isOpen(ViewName.GainItemView) then
		ItemConvertController.instance:popCacheItemMoList()
	end
end

function M:_handleAchievementReward(GainItemsData)
	AchievementModel.instance:setRewards(GainItemsData.showItems)
end

function M:_handleChamberWeekly(GainItemsData)
	if not GuideController.instance:isGuiding() then
		ViewMgr.instance:open(ViewName.ChamberGain, GainItemsData.addItemsWithoutHeroBeforeConvert)
	end
end

function M:_handleHeroGet(GainItemsData)
	return
end

function M:checkGainIsOnlyHero(GainItemsData)
	local opt = GainItemsData.originPushInfo.optType

	if opt and opt == OptionType.LOTTERY then
		return false
	end

	local itemList = GainItemsData.addItemsBeforeConvert

	return itemList and #itemList == 1 and itemList[1]:getType() == GameEnum.ItemTypeEnum.HeroType
end

function M:_handleAirWorkShopRodeoWeek(GainItemsData)
	AirWorkShopChallengeModel.instance:setWeeklyReward(GainItemsData)
end

function M:_handleNewbie(GainItemsData)
	local firstWeek = NewbieTaskConfig.instance:getWeekCurrencyId(1)

	GainItemsData:removeDisapperaItems(firstWeek)

	local secondWeek = NewbieTaskConfig.instance:getWeekCurrencyId(2)

	if secondWeek then
		GainItemsData:removeDisapperaItems(secondWeek)
	end

	NewbieTaskController.instance:setCacheItemMOList(GainItemsData.showItems)
end

function M:_handleSeasonTaskReward(GainItemsData)
	SeasonController.instance:addGainItemsData(GainItemsData)
end

function M:_handleSeasonSheduleReward(GainItemsData)
	SeasonController.instance:addGainItemsData(GainItemsData)
end

function M:_handleMainlinePlotFirstReward(GainItemsData)
	MainlineDungeonController.instance:setCacheItemMOList(GainItemsData.showItems)
end

M.instance = M.New()

return M
