-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionKnockoutMainView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionKnockoutMainView", package.seeall)

local YouthArenaThirdChampionKnockoutMainView = class("YouthArenaThirdChampionKnockoutMainView", ViewComponent)

function YouthArenaThirdChampionKnockoutMainView:ctor()
	YouthArenaThirdChampionKnockoutMainView.super.ctor(self)
end

function YouthArenaThirdChampionKnockoutMainView:buildUI()
	YouthArenaThirdChampionKnockoutMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setIsUnlockCallBack(GameUtil.handler(self._isUnlock, self))
	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onPreClickTab, self))
	self._commonTab:setDefaultLeafCallBack(GameUtil.handler(self._onGetDefaultLeaf, self))
end

function YouthArenaThirdChampionKnockoutMainView:bindEvents()
	YouthArenaThirdChampionKnockoutMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function YouthArenaThirdChampionKnockoutMainView:unbindEvents()
	YouthArenaThirdChampionKnockoutMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function YouthArenaThirdChampionKnockoutMainView:onEnter()
	YouthArenaThirdChampionKnockoutMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._handleGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actData = YouthArenaThirdConfig.instance:getActivityData(self._activityId)
	self._hasManualClick = false
	self._isDefaultTabApplied = false
	self._stagePopupShowing = false
	self._skipNextGetInfoAutoAction = false

	self:_initTabView()
	self:_sendInfoReq()

	if self:_handleStageBoundary() then
		return
	end

	if self:_restoreLastSelectedTabIfNeed() then
		return
	end

	self:_refreshDefaultTabIfNeed()
end

function YouthArenaThirdChampionKnockoutMainView:onExit()
	YouthArenaThirdChampionKnockoutMainView.super.onExit(self)
	self:_onClearTabAt()
end

function YouthArenaThirdChampionKnockoutMainView:_initTabView()
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

function YouthArenaThirdChampionKnockoutMainView:_buildTabDataList()
	self:_clearTabData()

	for _, cfg in ipairs(YouthArenaThirdEnum.ChampionKnockoutTabCfg or {}) do
		self:_addTabData({
			headTabId = cfg.headTabId,
			secTabId = cfg.secTabId,
			tabKey = cfg.tabKey,
			viewName = cfg.viewName,
			tabName = self:_getTabName(cfg),
			viewParams = self:_getViewParams(cfg),
			roundId = cfg.roundId
		})
	end
end

function YouthArenaThirdChampionKnockoutMainView:_clearTabData()
	self._tabDataMap = {}
	self._tabKeyList = {}
end

function YouthArenaThirdChampionKnockoutMainView:_addTabData(data)
	if not data or string.nilorempty(data.tabKey) then
		return
	end

	self._tabDataMap[data.tabKey] = data

	table.insert(self._tabKeyList, data.tabKey)
end

function YouthArenaThirdChampionKnockoutMainView:_getTabData(tabKey)
	return self._tabDataMap and self._tabDataMap[tabKey]
end

function YouthArenaThirdChampionKnockoutMainView:_jumpToTabByKey(key)
	local data = self:_getTabData(key)

	if not data then
		return
	end

	self._curTabKey = key

	self._commonTab:jumpTabByData(data)
end

function YouthArenaThirdChampionKnockoutMainView:_restoreLastSelectedTabIfNeed()
	local data = self:_getTabData(self._lastSelectedTabKey)

	if not data then
		return false
	end

	if self:_getCurRoundId() <= 0 then
		self._hasManualClick = true
		self._isDefaultTabApplied = true

		self:_jumpToTabByKey(data.tabKey)

		return true
	end

	if self:_isUnlockData(data) then
		self._hasManualClick = true
		self._isDefaultTabApplied = true

		self:_jumpToTabByKey(data.tabKey)

		return true
	end

	local targetKey = self:_getBestAvailableTabKey()

	if string.nilorempty(targetKey) then
		return false
	end

	self._hasManualClick = true
	self._isDefaultTabApplied = true

	self:_jumpToTabByKey(targetKey)
	self:_showStagePopup("原赛程暂不可查看，已为你切换到可查看赛程。", nil)

	return true
end

function YouthArenaThirdChampionKnockoutMainView:_refreshDefaultTabIfNeed()
	if self._hasManualClick or self._isDefaultTabApplied == true then
		return
	end

	local curRoundId = self:_getCurRoundId()
	local defaultKey = self:_getDefaultTabKey()

	if string.nilorempty(defaultKey) then
		return
	end

	self._isDefaultTabApplied = curRoundId > 0

	self:_jumpToTabByKey(defaultKey)
end

function YouthArenaThirdChampionKnockoutMainView:_getDefaultTabKey()
	local tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey
	local curRoundId = self:_getCurRoundId()

	if curRoundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutStart or curRoundId > YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd then
		return tabKey.MySchedule
	end

	local playerRoundId = self:_getPlayerRoundId()

	if playerRoundId > 0 and playerRoundId < curRoundId then
		return self:_getRoundTabKey(curRoundId) or tabKey.MySchedule
	end

	return tabKey.MySchedule
end

function YouthArenaThirdChampionKnockoutMainView:_getRoundTabKey(roundId)
	for _, cfg in ipairs(YouthArenaThirdEnum.ChampionKnockoutTabCfg or {}) do
		if checknumber(cfg.roundId) == checknumber(roundId) then
			return cfg.tabKey
		end
	end

	if self:_isRaceRoundTabRound(roundId) then
		return YouthArenaThirdEnum.ChampionKnockoutTabKey.Round128To16
	end
end

function YouthArenaThirdChampionKnockoutMainView:_onUpdateCell(view, cell, tabData, tag)
	local data = tabData and tabData.data
	local redpoint = goutil.findChild(cell, "redpoint")
	local lock = goutil.findChild(cell, "lock")

	GameUtil.SetActive(redpoint, false)
	GameUtil.SetActive(lock, not self:_isUnlock(tabData))

	if data then
		tabData.tabName = data.tabName
	end
end

function YouthArenaThirdChampionKnockoutMainView:_onUpdateRight(tabData)
	if tabData and tabData.data and tabData.data.tabKey then
		self._curTabKey = tabData.data.tabKey
	end

	local data = self:_getTabData(self._curTabKey)

	if not data or string.nilorempty(data.viewName) then
		return
	end

	self._lastSelectedTabKey = self._curTabKey

	if self._oldTabKey and self._oldTabKey == self._curTabKey then
		return
	end

	self:_onClearTabAt()

	self._oldTabKey = self._curTabKey

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function YouthArenaThirdChampionKnockoutMainView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabKey = nil
end

function YouthArenaThirdChampionKnockoutMainView:_isUnlock(tabData)
	local data = tabData and tabData.data

	return self:_isUnlockData(data)
end

function YouthArenaThirdChampionKnockoutMainView:_onPreClickTab(tabData)
	if not self:_isUnlock(tabData) then
		FloatWordMgr.instance:show(self:_getTabLockTips(tabData and tabData.data))

		return true
	end

	self._hasManualClick = true

	return false
end

function YouthArenaThirdChampionKnockoutMainView:_onGetDefaultLeaf(tabData)
	local data = tabData and tabData.data

	if not data or data.tabKey ~= YouthArenaThirdEnum.ChampionKnockoutTabKey.ScheduleRoot then
		return 0
	end

	local curRoundId = self:_getCurRoundId()
	local cfg = self:_getRoundTabCfg(curRoundId)

	if checknumber(cfg and cfg.secTabId) > 0 then
		return cfg.secTabId
	end

	if curRoundId > YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd then
		return YouthArenaThirdEnum.ChampionKnockoutDefaultLeaf.Ended
	end

	return YouthArenaThirdEnum.ChampionKnockoutDefaultLeaf.NotStart
end

function YouthArenaThirdChampionKnockoutMainView:_getRoundTabCfg(roundId)
	for _, cfg in ipairs(YouthArenaThirdEnum.ChampionKnockoutTabCfg or {}) do
		if checknumber(cfg.roundId) == checknumber(roundId) then
			return cfg
		end
	end

	if self:_isRaceRoundTabRound(roundId) then
		return self:_getTabData(YouthArenaThirdEnum.ChampionKnockoutTabKey.Round128To16)
	end
end

function YouthArenaThirdChampionKnockoutMainView:_isRaceRoundTabRound(roundId)
	roundId = checknumber(roundId)

	return roundId >= YouthArenaThirdEnum.ChampionRoundId.KnockoutStart and roundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd
end

function YouthArenaThirdChampionKnockoutMainView:_sendInfoReq()
	if checknumber(self._activityId) <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetInfoReq(self._activityId)
end

function YouthArenaThirdChampionKnockoutMainView:_handleGetInfoRes()
	if self._skipNextGetInfoAutoAction == true then
		self._skipNextGetInfoAutoAction = false

		if self._commonTab then
			self._commonTab:refresh()
		end

		return
	end

	if self:_handleStageBoundary() then
		return
	end

	if self._stagePopupShowing == true then
		return
	end

	if self._commonTab then
		self._commonTab:refresh()
	end

	if self:_relocateIfCurrentTabNeed() then
		return
	end

	self:_refreshDefaultTabIfNeed()
end

function YouthArenaThirdChampionKnockoutMainView:_handleStepChange(activityId, stepId)
	if checknumber(activityId) ~= checknumber(self._activityId) then
		return
	end

	self._skipNextGetInfoAutoAction = true

	YouthArenaThirdController.instance:requestGetInfoForStepChange(activityId, stepId)

	if self._commonTab then
		self._commonTab:refresh()
	end
end

function YouthArenaThirdChampionKnockoutMainView:_getSubMo()
	if checknumber(self._activityId) <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionKnockoutMainView:_getCurRoundId()
	local subMo = self:_getSubMo()
	local curStepId = subMo and subMo:getCurStepId()
	local stepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId)

	return checknumber(stepData and stepData.roundId)
end

function YouthArenaThirdChampionKnockoutMainView:_getPlayerRoundId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getPlayerRoundId())
end

function YouthArenaThirdChampionKnockoutMainView:_handleStageBoundary()
	local curRoundId = self:_getCurRoundId()

	if curRoundId <= 0 then
		return false
	end

	if curRoundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutStart then
		self:_showStagePopup("当前赛事阶段暂未开放，请返回主界面查看最新赛程。", GameUtil.handler(self.close, self))

		return true
	end

	return false
end

function YouthArenaThirdChampionKnockoutMainView:_relocateIfCurrentTabNeed()
	local data = self:_getTabData(self._curTabKey)
	local targetKey = self:_getRelocateTabKey(data)

	if string.nilorempty(targetKey) then
		return false
	end

	self._hasManualClick = true
	self._isDefaultTabApplied = true

	self:_jumpToTabByKey(targetKey)
	self:_showStagePopup("当前赛程暂未开放，已为你切换到可查看赛程。", nil)

	return true
end

function YouthArenaThirdChampionKnockoutMainView:_getRelocateTabKey(data)
	if not data then
		return nil
	end

	if self:_isUnlockData(data) then
		return nil
	end

	return self:_getBestAvailableTabKey()
end

function YouthArenaThirdChampionKnockoutMainView:_getBestAvailableTabKey()
	local tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey
	local curRoundId = self:_getCurRoundId()

	if curRoundId >= YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd then
		return tabKey.Round16To8
	end

	if curRoundId >= YouthArenaThirdEnum.ChampionRoundId.KnockoutStart then
		return tabKey.Round128To16
	end

	return tabKey.MySchedule
end

function YouthArenaThirdChampionKnockoutMainView:_isUnlockData(data)
	if not data then
		return true
	end

	local tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey
	local curRoundId = self:_getCurRoundId()

	if data.tabKey == tabKey.Round128To16 then
		return curRoundId >= YouthArenaThirdEnum.ChampionRoundId.KnockoutStart
	end

	if data.tabKey == tabKey.Round16To8 then
		return curRoundId >= YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd
	end

	return true
end

function YouthArenaThirdChampionKnockoutMainView:_getTabLockTips(data)
	if not data then
		return "未开启"
	end

	local tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey
	local curRoundId = self:_getCurRoundId()

	if data.tabKey == tabKey.Round128To16 and curRoundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutStart then
		return "当前赛程暂未开放"
	end

	if data.tabKey == tabKey.Round16To8 then
		if curRoundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd then
			return "当前赛程暂未开放"
		end

		return "当前赛程已结束"
	end

	return "未开启"
end

function YouthArenaThirdChampionKnockoutMainView:_showStagePopup(content, confirmFunc)
	if self._stagePopupShowing == true then
		return
	end

	self._stagePopupShowing = true

	TipsFacade.instance:openPopupWindow("提示", content, function()
		self._stagePopupShowing = false

		GameUtil.callBack(confirmFunc)
	end, nil, "确定", nil)
end

function YouthArenaThirdChampionKnockoutMainView:_getTabName(cfg)
	return cfg.tabName
end

function YouthArenaThirdChampionKnockoutMainView:_getViewParams(cfg)
	if cfg.tabKey == YouthArenaThirdEnum.ChampionKnockoutTabKey.Round128To16 then
		return {
			self._activityId
		}
	end

	if checknumber(cfg.roundId) > 0 then
		return {
			self._activityId,
			cfg.roundId
		}
	end

	if not string.nilorempty(cfg.viewName) then
		return {
			self._activityId
		}
	end
end

function YouthArenaThirdChampionKnockoutMainView:_onClickTip()
	if self._actData then
		if string.nilorempty(self._actData) then
			return
		end

		TipsFacade.instance:openRulesView(self._actData)
	end
end

function YouthArenaThirdChampionKnockoutMainView:_onClickClose()
	self._lastSelectedTabKey = nil

	self:close()
end

return YouthArenaThirdChampionKnockoutMainView
