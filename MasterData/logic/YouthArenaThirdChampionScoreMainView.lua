-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScoreMainView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScoreMainView", package.seeall)

local YouthArenaThirdChampionScoreMainView = class("YouthArenaThirdChampionScoreMainView", ViewComponent)

function YouthArenaThirdChampionScoreMainView:ctor()
	YouthArenaThirdChampionScoreMainView.super.ctor(self)
end

function YouthArenaThirdChampionScoreMainView:buildUI()
	YouthArenaThirdChampionScoreMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setIsUnlockCallBack(GameUtil.handler(self._isUnlock, self))
	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onPreClickTab, self))
	self._commonTab:setDefaultLeafCallBack(GameUtil.handler(self._onGetDefaultLeaf, self))
end

function YouthArenaThirdChampionScoreMainView:bindEvents()
	YouthArenaThirdChampionScoreMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function YouthArenaThirdChampionScoreMainView:unbindEvents()
	YouthArenaThirdChampionScoreMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function YouthArenaThirdChampionScoreMainView:onEnter()
	YouthArenaThirdChampionScoreMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._handleGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actData = YouthArenaThirdConfig.instance:getActivityData(self._activityId)
	self._enterLastSelectedTabKey = self._lastSelectedTabKey
	self._hasManualClick = false
	self._isDefaultTabApplied = false
	self._skipNextGetInfoAutoAction = false

	self:_initTabView()
	self:_sendInfoReq()

	if self:_restoreLastSelectedTabIfNeed() then
		return
	end

	self:_refreshDefaultTabIfNeed()
end

function YouthArenaThirdChampionScoreMainView:onExit()
	YouthArenaThirdChampionScoreMainView.super.onExit(self)
	self:_onClearTabAt()
end

function YouthArenaThirdChampionScoreMainView:_initTabView()
	self:_buildTabDataList()
	self._commonTab:clearAllData()

	for _, key in ipairs(self._tabKeyList or {}) do
		local data = self:_getTabData(key)

		if data.secTabId and data.secTabId > 0 then
			if not data.headTabId then
				local hisRoot = 0

				self._commonTab:addTabData(data.tabName, data, hisRoot)
			end
		end
	end
end

function YouthArenaThirdChampionScoreMainView:_buildTabDataList()
	self:_clearTabData()
	self:_addTabData({
		secTabId = 0,
		tabName = "我的赛程",
		roundId = 0,
		headTabId = 1,
		tabKey = YouthArenaThirdEnum.ChampionScoreTabKey.MySchedule,
		viewName = ViewName.YouthArenaThirdChampionScoreMyScheduleView
	})

	local headTabId = 2

	for _, cfg in ipairs(YouthArenaThirdEnum.ChampionScoreTabGroupCfg or {}) do
		self:_addTabData({
			secTabId = 0,
			roundId = 0,
			headTabId = headTabId,
			tabKey = cfg.rootKey,
			tabName = cfg.rootName,
			mode = cfg.mode
		})
		self:_buildRoundTabDataList(cfg, headTabId)

		headTabId = headTabId + 1
	end
end

function YouthArenaThirdChampionScoreMainView:_buildRoundTabDataList(cfg, headTabId)
	local list = {}

	for _, roundData in pairs(YouthArenaThirdConfig.instance:getRoundDatas(self._activityId) or {}) do
		if roundData.roundType == cfg.roundType then
			table.insert(list, roundData)
		end
	end

	self:_sortRoundTabDataList(list)

	for index, roundData in ipairs(list) do
		self:_addTabData({
			headTabId = headTabId,
			secTabId = index,
			tabKey = string.format("%s_%s", cfg.rootKey, index),
			tabName = self:_getRoundTabName(roundData, index, cfg),
			viewName = ViewName.YouthArenaThirdChampionScoreRoundView,
			roundId = checknumber(roundData.roundId),
			mode = cfg.mode
		})
	end
end

function YouthArenaThirdChampionScoreMainView:_sortRoundTabDataList(list)
	table.sort(list, function(a, b)
		return checknumber(a and a.roundId) < checknumber(b and b.roundId)
	end)
end

function YouthArenaThirdChampionScoreMainView:_clearTabData()
	self._tabDataMap = {}
	self._tabKeyList = {}
	self._rootDefaultLeafMap = {}
end

function YouthArenaThirdChampionScoreMainView:_addTabData(data)
	if not data or string.nilorempty(data.tabKey) then
		return
	end

	self._tabDataMap[data.tabKey] = data

	table.insert(self._tabKeyList, data.tabKey)

	if checknumber(data.secTabId) > 0 and self._rootDefaultLeafMap[data.headTabId] == nil then
		self._rootDefaultLeafMap[data.headTabId] = data.secTabId
	end
end

function YouthArenaThirdChampionScoreMainView:_getTabData(tabKey)
	return self._tabDataMap and self._tabDataMap[tabKey]
end

function YouthArenaThirdChampionScoreMainView:_jumpToTabByKey(key)
	local data = self:_getTabData(key)

	if not data then
		return
	end

	self._curTabKey = key

	self._commonTab:jumpTabByData(data)
end

function YouthArenaThirdChampionScoreMainView:_restoreLastSelectedTabIfNeed()
	local data = self:_getTabData(self._enterLastSelectedTabKey)

	if not data then
		return false
	end

	if not self:_isUnlockData(data) then
		return false
	end

	self._hasManualClick = true
	self._isDefaultTabApplied = true

	self:_jumpToTabByKey(data.tabKey)

	return true
end

function YouthArenaThirdChampionScoreMainView:_refreshDefaultTabIfNeed()
	if self._hasManualClick or self._isDefaultTabApplied == true then
		return
	end

	local defaultKey = self:_getBestAvailableTabKey()

	if string.nilorempty(defaultKey) then
		return
	end

	self._isDefaultTabApplied = true

	self:_jumpToTabByKey(defaultKey)
end

function YouthArenaThirdChampionScoreMainView:_onUpdateCell(view, cell, tabData, tag)
	local data = tabData and tabData.data
	local redpoint = goutil.findChild(cell, "redpoint")
	local lock = goutil.findChild(cell, "lock")

	GameUtil.SetActive(redpoint, false)
	GameUtil.SetActive(lock, not self:_isUnlock(tabData))

	if data then
		tabData.tabName = data.tabName
	end
end

function YouthArenaThirdChampionScoreMainView:_onUpdateRight(tabData)
	if tabData and tabData.data and tabData.data.tabKey then
		self._curTabKey = tabData.data.tabKey
	end

	local data = self:_getTabData(self._curTabKey)

	if not data then
		return
	end

	if not string.nilorempty(data.viewName) then
		self._lastSelectedTabKey = self._curTabKey
	end

	if self._oldTabKey and self._oldTabKey == self._curTabKey then
		return
	end

	self:_onClearTabAt()

	self._oldTabKey = self._curTabKey

	if not string.nilorempty(data.viewName) then
		self:showTabAt(self._contentCol, data.viewName, self._activityId, data.roundId, data.mode)
	end
end

function YouthArenaThirdChampionScoreMainView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabKey = nil
end

function YouthArenaThirdChampionScoreMainView:_isUnlock(tabData)
	local data = tabData and tabData.data

	return self:_isUnlockData(data)
end

function YouthArenaThirdChampionScoreMainView:_onPreClickTab(tabData)
	if not self:_isUnlock(tabData) then
		FloatWordMgr.instance:show(self:_getTabLockTips(tabData and tabData.data))

		return true
	end

	self._hasManualClick = true

	return false
end

function YouthArenaThirdChampionScoreMainView:_onGetDefaultLeaf(tabData)
	local data = tabData and tabData.data

	return self:_getBestLeafSecTabId(checknumber(data and data.headTabId))
end

function YouthArenaThirdChampionScoreMainView:_isRootTabData(data)
	return data and checknumber(data.secTabId) == 0 and string.nilorempty(data.viewName)
end

function YouthArenaThirdChampionScoreMainView:_isRoundTabData(data)
	return data and checknumber(data.secTabId) > 0 and checknumber(data.roundId) > 0
end

function YouthArenaThirdChampionScoreMainView:_isUnlockData(data)
	if not data then
		return true
	end

	if data.tabKey == YouthArenaThirdEnum.ChampionScoreTabKey.MySchedule then
		return true
	end

	if self:_isRootTabData(data) then
		return self:_hasUnlockChild(data)
	end

	if self:_isRoundTabData(data) then
		return checknumber(data.roundId) <= self:_getCurRoundId()
	end

	return true
end

function YouthArenaThirdChampionScoreMainView:_hasUnlockChild(rootData)
	if not rootData then
		return false
	end

	for _, key in ipairs(self._tabKeyList or {}) do
		local data = self:_getTabData(key)

		if data and checknumber(data.headTabId) == checknumber(rootData.headTabId) and checknumber(data.secTabId) > 0 and self:_isUnlockData(data) then
			return true
		end
	end

	return false
end

function YouthArenaThirdChampionScoreMainView:_getBestAvailableTabKey()
	local curRoundId = self:_getCurRoundId()
	local latestData

	for _, key in ipairs(self._tabKeyList or {}) do
		local data = self:_getTabData(key)

		if self:_isRoundTabData(data) and self:_isUnlockData(data) then
			if checknumber(data.roundId) == curRoundId then
				return data.tabKey
			end

			if latestData == nil or checknumber(data.roundId) > checknumber(latestData.roundId) then
				latestData = data
			end
		end
	end

	if latestData then
		return latestData.tabKey
	end

	return YouthArenaThirdEnum.ChampionScoreTabKey.MySchedule
end

function YouthArenaThirdChampionScoreMainView:_getBestLeafSecTabId(headTabId)
	if checknumber(headTabId) <= 0 then
		return 0
	end

	local curRoundId = self:_getCurRoundId()
	local latestData

	for _, key in ipairs(self._tabKeyList or {}) do
		local data = self:_getTabData(key)

		if self:_isRoundTabData(data) and checknumber(data.headTabId) == checknumber(headTabId) and self:_isUnlockData(data) then
			if checknumber(data.roundId) == curRoundId then
				return checknumber(data.secTabId)
			end

			if latestData == nil or checknumber(data.roundId) > checknumber(latestData.roundId) then
				latestData = data
			end
		end
	end

	if latestData then
		return checknumber(latestData.secTabId)
	end

	return checknumber(self._rootDefaultLeafMap and self._rootDefaultLeafMap[headTabId])
end

function YouthArenaThirdChampionScoreMainView:_getTabLockTips(data)
	if self:_isRootTabData(data) or self:_isRoundTabData(data) then
		return "当前赛程暂未开放"
	end

	return "未开启"
end

function YouthArenaThirdChampionScoreMainView:_sendInfoReq()
	if checknumber(self._activityId) <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetInfoReq(self._activityId)
end

function YouthArenaThirdChampionScoreMainView:_handleGetInfoRes()
	if self._commonTab then
		self._commonTab:refresh()
	end

	if self._skipNextGetInfoAutoAction == true then
		self._skipNextGetInfoAutoAction = false
		self._enterLastSelectedTabKey = nil

		return
	end

	if self:_relocateIfCurrentTabNeed() then
		self._enterLastSelectedTabKey = nil

		return
	end

	if self._hasManualClick ~= true and self:_restoreLastSelectedTabIfNeed() then
		self._enterLastSelectedTabKey = nil

		return
	end

	self._enterLastSelectedTabKey = nil

	if self._hasManualClick ~= true then
		self._isDefaultTabApplied = false
	end

	self:_refreshDefaultTabIfNeed()
end

function YouthArenaThirdChampionScoreMainView:_handleStepChange(activityId, stepId)
	if checknumber(activityId) ~= checknumber(self._activityId) then
		return
	end

	self._skipNextGetInfoAutoAction = true

	YouthArenaThirdController.instance:requestGetInfoForStepChange(activityId, stepId)

	if self._commonTab then
		self._commonTab:refresh()
	end
end

function YouthArenaThirdChampionScoreMainView:_getSubMo()
	if checknumber(self._activityId) <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionScoreMainView:_getCurRoundId()
	local subMo = self:_getSubMo()
	local curStepId = subMo and subMo:getCurStepId()
	local stepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId)

	return checknumber(stepData and stepData.roundId)
end

function YouthArenaThirdChampionScoreMainView:_relocateIfCurrentTabNeed()
	if string.nilorempty(self._curTabKey) then
		return false
	end

	local data = self:_getTabData(self._curTabKey)

	if data and self:_isUnlockData(data) then
		return false
	end

	local targetKey = self:_getBestAvailableTabKey()

	if string.nilorempty(targetKey) or targetKey == self._curTabKey then
		return false
	end

	self._hasManualClick = true
	self._isDefaultTabApplied = true

	self:_jumpToTabByKey(targetKey)
	FloatWordMgr.instance:show("当前赛程暂未开放，已为你切换到可查看赛程。")

	return true
end

function YouthArenaThirdChampionScoreMainView:_getRoundTabName(roundData, index, cfg)
	if roundData and not string.nilorempty(roundData.roundName) then
		return roundData.roundName
	end

	return string.format("全服冠军积分赛第%s场%s", index, cfg.modeName or "")
end

function YouthArenaThirdChampionScoreMainView:_onClickTip()
	if self._actData then
		if string.nilorempty(self._actData) then
			return
		end

		TipsFacade.instance:openRulesView(self._actData)
	end
end

function YouthArenaThirdChampionScoreMainView:_onClickClose()
	self._lastSelectedTabKey = nil

	self:close()
end

return YouthArenaThirdChampionScoreMainView
