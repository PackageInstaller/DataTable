-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerMainView.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerMainView", package.seeall)

local PsychicedTowerMainView = class("PsychicedTowerMainView", ViewComponent)

function PsychicedTowerMainView:ctor()
	PsychicedTowerMainView.super.ctor(self)
end

function PsychicedTowerMainView:unbindEvents()
	PsychicedTowerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnRank)
end

function PsychicedTowerMainView:bindEvents()
	PsychicedTowerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function PsychicedTowerMainView:buildUI()
	PsychicedTowerMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnShop = self:getGo("btnShop")
	self._btnTask = self:getGo("btnTask")
	self._btnRank = self:getGo("btnRank")
	self._goldBarCon = self:getGo("goldBar")
	self._redPointTask = self:getGo("btnTask/redPoint")
end

function PsychicedTowerMainView:destroyUI()
	PsychicedTowerMainView.super.destroyUI(self)
	self._tableList:dispose()
end

function PsychicedTowerMainView:onExit()
	PsychicedTowerMainView.super.onExit(self)
	self._tableList:dispose()
	removetimer(self._onClock, self)
	RedPointController.instance:unregRedPoint(self._redPointTask)
end

function PsychicedTowerMainView:onEnter()
	PsychicedTowerMainView.super.onEnter(self)

	self._activityId = self:getFirstParam() or PsychicedTowerModel.instance:getCurrActId()
	self._activityCfg = PsychicedTowerConfig.instance:getActivityCfg(self._activityId)
	self._towerCfgs = PsychicedTowerConfig.instance:getTowerCfgs(self._activityId)

	self:refreshView()

	self._timeTargrt = {}

	self:_onClock()
	settimer(1, self._onClock, self, true)
	self:_setTopGoldBar()
	PsychicedTowerAgent.instance:sendPM_PsychicedTowerInfoReq(self._activityId)

	local taskCfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if taskCfg and checknumber(taskCfg.redPointId) > 0 then
		RedPointController.instance:regRedPoint(self._redPointTask, taskCfg.redPointId)
	end
end

function PsychicedTowerMainView:refreshView()
	self._tableList:reloadData(self._towerCfgs)
end

function PsychicedTowerMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgGo = goutil.findChild(go, "img")
	local imgBlock = goutil.findChild(go, "imgBlock")
	local imgLock = goutil.findChild(go, "imgLock")
	local btnChallenge = goutil.findChild(go, "btnChallenge")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local runningTime = goutil.findChild(go, "runningTime")
	local txtTime = goutil.findChildTextComponent(runningTime, "txtTime")
	local openTime = goutil.findChild(go, "txtOpenTime")
	local txtOpenTime = goutil.findChildTextComponent(openTime, "txtTime")
	local isOpen = GameUtil.checkIsInTimePeriod(data.openDateTime, data.endDateTime) == true

	GameUtil.SetActive(imgBlock, not isOpen)
	GameUtil.SetActive(imgLock, not isOpen)
	GameUtil.SetActive(runningTime, isOpen)
	GameUtil.SetActive(openTime, not isOpen)
	GameUtil.SetActive(btnChallenge, isOpen)

	txtName.text = data.name

	if isOpen then
		self._timeTargrt[txtTime] = GameUtil.string2time(data.endDateTime)
	else
		self._timeTargrt[txtTime] = nil

		local startTime = GameUtil.string2date(data.openDateTime)
		local endTime = GameUtil.string2date(data.endDateTime)

		txtOpenTime.text = langPara("%d.%d %d:%02d - %d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
	end

	uGuiUtil.setSpriteToImage(imgGo, nil, data.bgRes)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickTower(data.towerId)
	end)
	GameUtil.addClickHandler(go, function()
		self:_onClickTower(data.towerId)
	end)
end

function PsychicedTowerMainView:_clearCell(cell)
	local go = cell.gameObject
	local btn = go
	local txtTime = goutil.findChildTextComponent(go, "runningTime/txtTime")
	local imgGo = goutil.findChild(go, "img")

	uGuiUtil.clearImage(imgGo)

	self._timeTargrt[txtTime] = nil

	GameUtil.rmClickHandler(btn)
	GameUtil.rmClickHandler(go)
end

function PsychicedTowerMainView:_onClickTower(towerId)
	local towerCfg = PsychicedTowerConfig.instance:getTowerCfg(self._activityId, towerId)

	if GameUtil.checkIsInTimePeriod(towerCfg.openDateTime, towerCfg.endDateTime) == true then
		UIStateManager.instance:push(ViewName.PsychicedTowerLevelView, self._activityId, towerId)
	else
		FloatWordMgr.instance:show(lang("未到开放时间"))
	end
end

function PsychicedTowerMainView:_onClickRule()
	TipsFacade.instance:openRulesView("psychiced_tower_rule")
end

function PsychicedTowerMainView:_onClickShop()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function PsychicedTowerMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function PsychicedTowerMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.PsychicedTowerRankView, self._activityId)
end

function PsychicedTowerMainView:_onClock()
	for txtTime, targetTime in pairs(self._timeTargrt) do
		if targetTime > ServerTime.now() then
			txtTime.text = langPara("%s", GameUtil.FormatTimeWords(targetTime - ServerTime.now()))
		else
			self:refreshView()

			return
		end
	end
end

function PsychicedTowerMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = self._activityCfg.showBar
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return PsychicedTowerMainView
