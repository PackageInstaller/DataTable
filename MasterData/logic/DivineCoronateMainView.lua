-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/view/DivineCoronateMainView.lua

module("logic.extensions.divinecoronate.view.DivineCoronateMainView", package.seeall)

local DivineCoronateMainView = class("DivineCoronateMainView", ViewComponent)

function DivineCoronateMainView:ctor()
	DivineCoronateMainView.super.ctor(self)
end

function DivineCoronateMainView:unbindEvents()
	DivineCoronateMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineCoronateMainView:bindEvents()
	DivineCoronateMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
end

function DivineCoronateMainView:buildUI()
	DivineCoronateMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._txtDailyGameTimes = self:getTxt("dailyGameTimes/txt")
	self._goTableview = self:getGo("tableview")
	self._goCell = goutil.findChild(self._goTableview, "tablecell")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:regReloadFinish(GameUtil.handler(self.reloadFinish, self))

	self._goBasePrize = goutil.findChild(self._goCell, "prize")
	self._rectTrans = self:getGo("rectTrans"):GetComponent(goutil.Type_RectTransform)
end

function DivineCoronateMainView:onExit()
	DivineCoronateMainView.super.onExit(self)

	self._curTabId = 1

	if self._effTabPrizeMap then
		for _, effect in pairs(self._effTabPrizeMap) do
			UIEffectManager.instance:stopEffect(effect)

			effect = nil
		end
	end
end

function DivineCoronateMainView:onEnter()
	DivineCoronateMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineCoronateGetInfoRes, self._refreshView, self)
	self:_initActivityId()
	self:_initActivityTime()
	self:_getViewConfigsByActId(self._activityId)

	self._effTabPrizeMap = {}
	self._curTabId = 1

	self:_sendGetInfoReq()
end

function DivineCoronateMainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineCoronate)
	end
end

function DivineCoronateMainView:_initActivityTime()
	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.DivineCoronate, self._activityId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function DivineCoronateMainView:_getViewConfigsByActId(actId)
	self._actCfg = DivineCoronateConfig.instance:getActCfgByActId(actId)
	self._tabCfgs = DivineCoronateConfig.instance:getTabCfgsByActId(actId)

	local stageCfg = PlanetariumConfig.instance:getStageCfgById(self._actCfg.gameId)

	self._stageCfg = DivineCoronateController.instance:shuffleConfig(stageCfg)
end

function DivineCoronateMainView:_refreshView()
	self._actInfo = DivineCoronateModel.instance:getActivityInfoByActId(self._activityId)

	if self._actInfo then
		self._curTabId = self._actInfo.maxUnlockTabId + 1 or 1
		self._txtDailyGameTimes.text = lang(string.format("今日归位次数：<color=#ade353>%d</color>/%d", self._actInfo.todayGameTimes, self._actCfg.dailyGameTimes))

		self._tableview:reloadData(self._tabCfgs)
	end
end

function DivineCoronateMainView:_sendGetInfoReq()
	DivineCoronateAgent.instance:sendPM_DivineCoronateGetInfoReq(self._activityId)
end

function DivineCoronateMainView:_onClickTipBtn()
	TipsFacade.instance:openRulesView("divinecoronatemainview_rule")
end

function DivineCoronateMainView:_onClickTabCellBtn(tabId)
	self._stageId = self._stageCfg[tabId].stageId % 14

	UIStateManager.instance:push(ViewName.DivineCoronateGameView, self._activityId, self._actCfg.gameId, self._stageId)
end

function DivineCoronateMainView:_onClickLockBtn(tabId)
	if tabId == self._actInfo.maxUnlockTabId + 1 then
		FloatWordMgr.instance:show("今日次数已用完，明天再来吧~")
	end
end

function DivineCoronateMainView:_onClickGainPrizeBtn(tabId)
	DivineCoronateAgent.instance:sendPM_DivineCoronateGainPrizeReq(self._activityId, tabId)
end

function DivineCoronateMainView:_updateCell(view, goCell, data)
	local title = goutil.findChildTextComponent(goCell, "txtTitle")
	local descRoot = goutil.findChild(goCell, "descRoot")
	local desc = goutil.findChildTextComponent(goCell, "descRoot/viewport/desc")
	local goBtn = goutil.findChildButtonComponent(goCell, "btn")
	local lockContent = goutil.findChild(goCell, "lock")
	local lockBtn = goutil.findChildButtonComponent(goCell, "lock/btn")
	local prizeRoot = goutil.findChild(goCell, "prizeRoot")
	local gainPrzBtn = goutil.findChildButtonComponent(goCell, "gainPrzBtn")
	local info = self._actInfo
	local canPlay = data.tabId == info.maxUnlockTabId + 1 and self._actCfg.dailyGameTimes - info.todayGameTimes > 0
	local isUnlock = data.tabId <= info.maxUnlockTabId
	local isGot = false

	if info.gainPrizeTabIds then
		for i, v in ipairs(info.gainPrizeTabIds) do
			if data.tabId == v then
				isGot = true

				break
			end
		end
	end

	local canGet = isUnlock and not isGot

	if isGot then
		title.text = data.title or "??????"
	end

	desc.text = data.text

	GameUtil.rmClickHandler(goBtn)
	GameUtil.rmClickHandler(gainPrzBtn)
	GameUtil.rmClickHandler(lockBtn)
	self:_clearPrizes(prizeRoot, data.tabId)

	if not isGot then
		local prizeDatas = string.split(data.prize, "#")

		self:_loadPrizes(prizeRoot, prizeDatas)

		if canGet then
			self:_loadPrizeEffect(prizeRoot, data.tabId)
			GameUtil.addClickHandler(gainPrzBtn, GameUtil.handler(self._onClickGainPrizeBtn, self, data.tabId))
		end

		if canPlay then
			GameUtil.addClickHandler(goBtn, GameUtil.handler(self._onClickTabCellBtn, self, data.tabId))
		else
			GameUtil.addClickHandler(lockBtn, GameUtil.handler(self._onClickLockBtn, self, data.tabId))
		end
	end

	goutil.setActive(lockContent, not isGot)
	goutil.setActive(prizeRoot, not isGot)
	goutil.setActive(goBtn.gameObject, canPlay)
	goutil.setActive(gainPrzBtn.gameObject, canGet)
	goutil.setActive(descRoot, isGot)
	goutil.setActive(lockBtn.gameObject, not canGet and not canPlay)
end

function DivineCoronateMainView:_clearCell(goCell)
	local prizeRoot = goutil.findChild(goCell, "prizeRoot")
	local goBtn = goutil.findChildButtonComponent(goCell, "btn")
	local gainPrzBtn = goutil.findChildButtonComponent(goCell, "gainPrzBtn")
	local lockBtn = goutil.findChildButtonComponent(goCell, "lock/btn")

	goutil.clearChildren(prizeRoot)
	GameUtil.rmClickHandler(goBtn)
	GameUtil.rmClickHandler(gainPrzBtn)
	GameUtil.rmClickHandler(lockBtn)
	MaterialMgr.resetAll(goCell)
end

function DivineCoronateMainView:reloadFinish()
	self._tableview:MoveCellToCenter(self._curTabId - 1)
end

function DivineCoronateMainView:_loadPrizes(root, data)
	local childrenCount = root.transform.childCount
	local prizeCount = #data

	if childrenCount == prizeCount then
		return
	end

	local itemRectTrans = self._goBasePrize:GetComponent(goutil.Type_RectTransform)
	local itemWidth = goutil.getWidth(itemRectTrans)
	local spacing = 12
	local midIndex = math.floor(prizeCount / 2) + 1
	local posX = 0

	for i, v in ipairs(data) do
		posX = prizeCount % 2 == 0 and (i - midIndex + 0.5) * (itemWidth + spacing) or (i - midIndex) * (itemWidth + spacing)

		local goPrize = goutil.cloneAndSetParent(self._goBasePrize, root.transform, "prize_" .. i)
		local item = goutil.findChild(goPrize, "item")
		local effect = goutil.findChild(goPrize, "effect")
		local proxy = MaterialMgr.setCellByCfg(v, item)

		GameUtil.setLocalPos(goPrize.transform, posX, 0, 0)
		goutil.setActive(goPrize, true)
	end
end

function DivineCoronateMainView:_clearPrizes(root, tabId)
	self:_clearPrizeEffect(root, tabId)
	goutil.clearChildren(root)
end

function DivineCoronateMainView:_loadPrizeEffect(root, tabId)
	local childrenCount = root.transform.childCount

	if not childrenCount or childrenCount == 0 then
		return
	end

	for i = 1, childrenCount do
		if self._effTabPrizeMap[tabId .. "_" .. i] then
			return
		end

		local goPrize = root.transform:GetChild(i - 1).gameObject
		local effect = goutil.findChild(root, "prize_" .. i .. "/effect")

		self._effTabPrizeMap[tabId .. "_" .. i] = self:_loadEffect(effect, self._rectTrans)
	end
end

function DivineCoronateMainView:_clearPrizeEffect(root, tabId)
	local childrenCount = root.transform.childCount

	for i = 1, childrenCount do
		if self._effTabPrizeMap[tabId .. "_" .. i] then
			UIEffectManager.instance:stopEffect(self._effTabPrizeMap[tabId .. "_" .. i])

			self._effTabPrizeMap[tabId .. "_" .. i] = nil
		end
	end
end

function DivineCoronateMainView:_loadEffect(goParent, rectTrans)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local _effect = UIEffectManager.instance:playEffect(self, effectPath, goParent, 0, 0, true, nil, nil, function(self, uiEffect)
		uiEffect:setClipping(rectTrans)
	end)

	_effect:setParent(goParent.transform)
	_effect:setScale(1)
	_effect:setLocalPos(0, 0, 0)

	return _effect
end

return DivineCoronateMainView
