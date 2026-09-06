-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomainAdventureMainHudView.lua

module("logic.extensions.domainadventure.view.DomainAdventureMainHudView", package.seeall)

local DomainAdventureMainHudView = class("DomainAdventureMainHudView", ViewComponent)
local _IsTestMode = false
local _CurBossIdx = 1
local _CurEliteFight = 1

function DomainAdventureMainHudView:ctor()
	DomainAdventureMainHudView.super.ctor(self)
end

function DomainAdventureMainHudView:buildUI()
	DomainAdventureMainHudView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTipRule = goutil.findChild(self.mainGO, "leftTop/btnTipRule")
	self._btnTipImg = goutil.findChild(self.mainGO, "leftTop/btnTipImg")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._redBtnTask = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnPort = goutil.findChild(self.mainGO, "btnPort")
	self._redBtnPort = goutil.findChild(self.mainGO, "btnPort/redPoint")
	self._btnBuff = goutil.findChild(self.mainGO, "btnBuff")
	self._btnPrize = goutil.findChild(self.mainGO, "btnPrize")
	self._redBtnPrize = goutil.findChild(self.mainGO, "btnPrize/redPoint")
	self._btnEye = goutil.findChild(self.mainGO, "btnEye")
	self._btnEvent = goutil.findChild(self.mainGO, "btnEvent")
	self._eventCol = goutil.findChild(self.mainGO, "eventCol")
	self._eventView = goutil.findChild(self.mainGO, "eventCol/eventView")
	self._arrowDown = goutil.findChild(self.mainGO, "eventCol/arrowDown")
	self._arrowUp = goutil.findChild(self.mainGO, "eventCol/arrowUp")
	self._btnEventViewShow = goutil.findChild(self.mainGO, "eventCol/btnEventViewShow")
	self._eventCustomInput = UICustomInput.Get(self._eventCol)
	self._guide = goutil.findChild(self.mainGO, "guide")
	self._threadElite = goutil.findChild(self.mainGO, "guide/threadElite")
	self._txtCountInElite = goutil.findChildTextComponent(self.mainGO, "guide/threadElite/txtCount")

	local eliteScrView = goutil.findChild(self.mainGO, "guide/threadElite/scrView")
	local eliteScrCell = goutil.findChild(self.mainGO, "guide/threadElite/scrCell")

	self._eliteScrollerList = ScrollerList.create(eliteScrView, eliteScrCell, GameUtil.handler(self._updateEliteCell, self), GameUtil.handler(self._clearEliteCell, self))
	self._threadBoss = goutil.findChild(self.mainGO, "guide/threadBoss")
	self._txtCountInBoss = goutil.findChildTextComponent(self.mainGO, "guide/threadBoss/txtCount")
	self._threadSolveForm = goutil.findChild(self.mainGO, "guide/threadSolveForm")
	self._txtCountInSolveForm = goutil.findChildTextComponent(self.mainGO, "guide/threadSolveForm/txtCount")
	self._threadDayTask = goutil.findChild(self.mainGO, "guide/threadDayTask")
	self._txtCountInDayTask = goutil.findChildTextComponent(self.mainGO, "guide/threadDayTask/txtCount")
	self._gmTest = goutil.findChild(self.mainGO, "gmTest")
	self._btnDetail = goutil.findChild(self.mainGO, "gmTest/btnDetail")
	self._btnFreshShow = goutil.findChild(self.mainGO, "gmTest/btnFreshShow")
end

function DomainAdventureMainHudView:bindEvents()
	DomainAdventureMainHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTipRule, self._onClickBtnTipRule, self)
	GameUtil.addClickHandler(self._btnTipImg, self._onClickBtnTipImg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnPort, self._onClickBtnPort, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnEye, self._onClickBtnEye, self)
	GameUtil.addClickHandler(self._btnEventViewShow, self._onClickBtnEventViewShow, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickBtnDetail, self)
	GameUtil.addClickHandler(self._btnFreshShow, self._onClickBtnFreshShow, self)
	GameUtil.addClickHandler(self._threadBoss, self._onClickThreadBoss, self)
	GameUtil.addClickHandler(self._threadSolveForm, self._onClickThreadSolveForm, self)
	self._eventCustomInput:AddListener(self._onCustomInputCallback, self)
end

function DomainAdventureMainHudView:unbindEvents()
	DomainAdventureMainHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTipRule)
	GameUtil.rmClickHandler(self._btnTipImg)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnPort)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnEye)
	GameUtil.rmClickHandler(self._btnEventViewShow)
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnFreshShow)
	GameUtil.rmClickHandler(self._threadBoss)
	GameUtil.rmClickHandler(self._threadSolveForm)
	self._eventCustomInput:RemoveListener()
end

function DomainAdventureMainHudView:onEnter()
	DomainAdventureMainHudView.super.onEnter(self)

	self._activityId = DomainAdventureController.instance:getCurActivityId()
	self._activityType = DomainAdventureController.instance:getActivityType()

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:_onClickBtnClose()

		return
	end

	self._scene = SceneMgr.instance:getCurScene()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._actData = DomainAdventureConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DomainAdventureGainGlobalPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DomainAdventureGainGlobalPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.DomainAdventureSceneOpenTestMode, self._handleDomainAdventureSceneOpenTestMode, self)

	local key = string.format("DomainAdventure_First_Scene_Rule_%s", self._activityId)

	local function firstCallback()
		self:_onClickBtnTipImg()
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback)
	GameUtil.SetActive(self._gmTest, enableDebug and _IsTestMode)
	self:_onSetUI()
	self:_onUpdate()
end

function DomainAdventureMainHudView:onExit()
	DomainAdventureMainHudView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	RedPointController.instance:unregRedPoint(self._redBtnPort)
	RedPointController.instance:unregRedPoint(self._redBtnPrize)
	self:_onClearThreadElite()
end

function DomainAdventureMainHudView:_handleDomainAdventureSceneOpenTestMode()
	_IsTestMode = not _IsTestMode

	GameUtil.SetActive(self._gmTest, enableDebug and _IsTestMode)
end

function DomainAdventureMainHudView:_onSetUI()
	RedPointController.instance:regRedPoint(self._redBtnTask, RedPointModel.ID_EVENT_TASK_DOMADV)
	RedPointController.instance:regRedPoint(self._redBtnPort, RedPointModel.ID_PASSPORT_DOMADV)
	RedPointController.instance:regRedPoint(self._redBtnPrize, RedPointModel.ID_DOMADV_GLOBAL_PRIZE)

	local list = {}
	local tab = {
		showAdd = false,
		id = DomainAdventureConfig.instance:getCostItem(self._activityId)
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
end

function DomainAdventureMainHudView:_onUpdate()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local curShowType = self._scene:getShowType()

	GameUtil.SetGray(self._btnEye, curShowType == DomAdvEnum.ShowType_Normal)
	GameUtil.SetActive(self._eventCol, curShowType == DomAdvEnum.ShowType_Eye)
	self:_onUpdateGuide()
end

function DomainAdventureMainHudView:_onUpdateGuide()
	self:_onUpdateThreadElite()
	self:_onUpdateThreadBoss()
	self:_onUpdateThreadSolveForm()
	self:_onUpdateThreadDayTask()
end

function DomainAdventureMainHudView:_onUpdateThreadElite()
	local unlockCount = 0
	local gridStateList = {}
	local gridIdList = self._scene:getGridIdsByType(DomAdvEnum.EventType_EliteFight)

	for _, gridId in ipairs(gridIdList) do
		local gridState = self._scene:getGridState(gridId)

		table.insert(gridStateList, gridState)

		if gridState:isAdjacentUnlock() then
			unlockCount = unlockCount + 1
		end
	end

	table.sort(gridStateList, function(a, b)
		local aEventId = DomainAdventureConfig.instance:getEventId(self._activityId, a:getBlockId())
		local bEventId = DomainAdventureConfig.instance:getEventId(self._activityId, b:getBlockId())

		return aEventId < bEventId
	end)

	self._txtCountInElite.text = string.format("%s/%s", unlockCount, #gridIdList)

	self._eliteScrollerList:reloadData(gridStateList)
end

function DomainAdventureMainHudView:_onClearThreadElite()
	self._eliteScrollerList:dispose()
end

function DomainAdventureMainHudView:_updateEliteCell(view, cell, gridState, tag)
	local gridId = gridState:getBlockId()
	local eventId = DomainAdventureConfig.instance:getEventId(self._activityId, gridId)
	local data = DomainAdventureConfig.instance:getClgEventData(self._activityId, eventId)
	local mainGo = cell.gameObject
	local imgFmt = goutil.findChild(mainGo, "imgFmt")
	local imgLock = goutil.findChild(mainGo, "imgLock")

	GameUtil.SetActive(imgLock, not gridState:isAdjacentUnlock())
	GameUtil.addClickHandler(mainGo, function()
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneFocusToGrid, gridId, true)
	end, self)
	GameUtil.getUIImageSpriteChange(imgFmt):ChangeSprite(data.iconSpriteName)
end

function DomainAdventureMainHudView:_clearEliteCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DomainAdventureMainHudView:_onUpdateThreadBoss()
	local eliteIds = self._scene:getGridIdsByType(DomAdvEnum.EventType_EliteFight)

	for _, gridId in ipairs(eliteIds) do
		local gridState = self._scene:getGridState(gridId)

		if gridState:isAdjacentUnlock() == false then
			GameUtil.SetActive(self._threadBoss, false)

			return
		end
	end

	local gridIdList = self._scene:getGridIdsByType(DomAdvEnum.EventType_Boss)
	local gridId = checknumber(gridIdList[1])
	local eventId = DomainAdventureConfig.instance:getEventId(self._activityId, gridId)
	local cur = self._domAdvMo:getDailyFightBossTimesInBoss()
	local data = DomainAdventureConfig.instance:getBossEventData(self._activityId, eventId)

	if data then
		if not data.dailyTimes then
			local max = 0
			local left = Mathf.Max(max - cur, 0)

			self._txtCountInBoss.text = string.format("(%s/%s)", left, max)

			GameUtil.SetActive(self._threadBoss, left > 0)
		end
	end
end

function DomainAdventureMainHudView:_onUpdateThreadSolveForm()
	local cur = 0
	local gridIdList = self._scene:getGridIdsByType(DomAdvEnum.EventType_SolveForm)

	for _, gridId in ipairs(gridIdList) do
		local gridState = self._scene:getGridState(gridId)

		if gridState:isOccupied() then
			cur = cur + 1
		end
	end

	GameUtil.SetActive(self._threadSolveForm, cur < #gridIdList)

	if cur >= #gridIdList then
		return
	end

	self._txtCountInSolveForm.text = string.format("(%s/%s)", cur, #gridIdList)
end

function DomainAdventureMainHudView:_onUpdateThreadDayTask()
	local bossUnlockCount = 0
	local gridIdList = self._scene:getGridIdsByType(DomAdvEnum.EventType_Boss)

	for _, gridId in ipairs(gridIdList) do
		local gridState = self._scene:getGridState(gridId)

		if gridState:isBossUnlock() then
			bossUnlockCount = bossUnlockCount + 1
		end
	end

	local cur = self._domAdvMo:getTodayCostStrength()
	local max = DomainAdventureConfig.instance:getGuideDailyStrengthCost(self._activityId)

	self._txtCountInDayTask.text = string.format("(%s/%s)", cur, max)

	GameUtil.SetActive(self._threadDayTask, bossUnlockCount < #gridIdList and cur < max)
end

function DomainAdventureMainHudView:_onClickThreadBoss()
	local gridIdList = self._scene:getGridIdsByType(DomAdvEnum.EventType_Boss)

	_CurBossIdx = Mathf.Clamp((_CurBossIdx + 1) % (#gridIdList + 1), 1, #gridIdList)

	local gridId = checknumber(gridIdList[_CurBossIdx])

	if gridId >= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneFocusToGrid, gridId, true)
	end
end

function DomainAdventureMainHudView:_onClickThreadSolveForm()
	local gridIdList = self._scene:getGridIdsByType(DomAdvEnum.EventType_SolveForm)

	table.sort(gridIdList, function(aGridId, bGridId)
		local aEventId = DomainAdventureConfig.instance:getEventId(self._activityId, aGridId)
		local bEventId = DomainAdventureConfig.instance:getEventId(self._activityId, bGridId)

		return aEventId < bEventId
	end)

	_CurEliteFight = Mathf.Clamp((_CurEliteFight + 1) % (#gridIdList + 1), 1, #gridIdList)

	local gridId = checknumber(gridIdList[_CurEliteFight])

	if gridId >= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneFocusToGrid, gridId, true)
	end
end

function DomainAdventureMainHudView:_onClickBtnTipRule()
	local key = self._actData.mainViewRuleKey

	TipsFacade.instance:openRulesView(key)
end

function DomainAdventureMainHudView:_onClickBtnTipImg()
	local ruleList = {}
	local info = {}

	info.url = "ui/bigbg/views/domadv/board_yuyanwanfa_15.png"
	info.desc = ""

	local info2 = {}

	info2.url = "ui/bigbg/views/domadv/board_yuyanwanfa_16.png"
	info2.desc = ""

	local info3 = {}

	info3.url = "ui/bigbg/views/domadv/board_yuyanwanfa_17.png"
	info3.desc = ""

	table.insert(ruleList, info)
	table.insert(ruleList, info2)
	table.insert(ruleList, info3)
	TipsFacade.instance:openImageRuleView(ruleList)
end

function DomainAdventureMainHudView:_onClickBtnClose()
	DomainAdventureController.instance:exitDomainAdventureScene()
end

function DomainAdventureMainHudView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DomAdvRankTabFrameView, self._activityId)
end

function DomainAdventureMainHudView:_onClickBtnShop()
	GotoMgr.gotoByString(self._actData.jumpToShop)
end

function DomainAdventureMainHudView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function DomainAdventureMainHudView:_onClickBtnPort()
	UIStateManager.instance:push(ViewName.PassportDomAdvView, self._activityId)
end

function DomainAdventureMainHudView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.DomAdvBuffDetailView, self._activityId)
end

function DomainAdventureMainHudView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.DomAdvGlobalPrizeView, self._activityId)
end

function DomainAdventureMainHudView:_onClickBtnEye()
	local curShowType = self._scene:getShowType()

	if curShowType == DomAdvEnum.ShowType_Normal then
		if not DomAdvEnum.ShowType_Eye then
			local next = DomAdvEnum.ShowType_Normal

			self._scene:setShowType(next)

			if next == DomAdvEnum.ShowType_Eye then
				self:_setVisableEventView(true)
			end

			self:_onUpdate()
		end
	end
end

function DomainAdventureMainHudView:_onClickBtnEventViewShow()
	self:_setVisableEventView(not GameUtil.GetActive(self._eventView))
end

function DomainAdventureMainHudView:_setVisableEventView(isToVisable)
	GameUtil.SetActive(self._eventView, isToVisable)
	GameUtil.SetActive(self._arrowDown, isToVisable)
	GameUtil.SetActive(self._arrowUp, not isToVisable)
end

function DomainAdventureMainHudView:_onCustomInputCallback(hover)
	if not hover then
		-- block empty
	end
end

function DomainAdventureMainHudView:_onClickBtnDetail()
	if enableDebug then
		self._scene._IsAdvTestMode_Detail = not self._scene._IsAdvTestMode_Detail

		self._scene:setNeedNeedMapUIUpdate()
	end
end

function DomainAdventureMainHudView:_onClickBtnFreshShow()
	if enableDebug then
		self._scene._IsAdvTestMode_Eye = not self._scene._IsAdvTestMode_Eye
		self._scene._oldCenterAreaId = -1
	end
end

return DomainAdventureMainHudView
