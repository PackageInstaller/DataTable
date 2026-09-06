-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattletaskView.lua

module("logic.extensions.lotusbattle.view.LotusbattletaskView", package.seeall)

local LotusbattletaskView = class("LotusbattletaskView", TableViewComponent)

LotusbattletaskView.TabType = {
	Achievement = 2,
	Daily = 1
}

function LotusbattletaskView:ctor()
	LotusbattletaskView.super.ctor(self)
end

function LotusbattletaskView:unbindEvents()
	LotusbattletaskView.super.unbindEvents(self)

	for k, v in pairs(self._tabBtns) do
		v.btn:RemoveClickListener()
	end

	self._btnClose:RemoveClickListener()
end

function LotusbattletaskView:bindEvents()
	LotusbattletaskView.super.bindEvents(self)
	self._tabBtns[LotusbattletaskView.TabType.Daily].btn:AddClickListener(function()
		self:_switchTab(LotusbattletaskView.TabType.Daily)
	end)
	self._tabBtns[LotusbattletaskView.TabType.Achievement].btn:AddClickListener(function()
		self:_switchTab(LotusbattletaskView.TabType.Achievement)
	end)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LotusbattletaskView:buildUI()
	LotusbattletaskView.super.buildUI(self)

	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnAchievementTaskGo = self:getGo("btns/btnAchievementTask")
	self._btnDailyTaskGo = self:getGo("btns/btnDailyTask")

	self:_buildTabBtns(LotusbattletaskView.TabType.Daily, self._btnDailyTaskGo)
	self:_buildTabBtns(LotusbattletaskView.TabType.Achievement, self._btnAchievementTaskGo)

	self._btnClose = self:getBtn("leftTop/btnClose")
end

function LotusbattletaskView:_buildTabBtns(tabType, go)
	self._tabBtns = self._tabBtns or {}
	self._tabBtns[tabType] = {
		onGo = goutil.findChild(go, "on"),
		offGo = goutil.findChild(go, "off"),
		btn = Framework.ButtonAdapter.Get(go)
	}
end

function LotusbattletaskView:onExit()
	LotusbattletaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._reloadTask, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function LotusbattletaskView:onEnter()
	LotusbattletaskView.super.onEnter(self)

	self._activityId = self:_getActivityId()
	self._txtTitle.text = "活动任务"
	self._tabType = self._tabType or ReadyforwarmainView.TabType.Daily

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._reloadTask, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
	self:_reloadTask()
end

function LotusbattletaskView:_onClickbtnClose()
	self:close()
end

function LotusbattletaskView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function LotusbattletaskView:_updateCell(view, cell, taskCfg)
	local btnJump = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnJump")

	goutil.setActive(btnJump.gameObject, false)

	local btnRecieve = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnRecieve")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")
	local goReceive = goutil.findChild(cell.gameObject, "receive")
	local progress = EventTaskSummaryModel.instance:getTaskCurProgress(taskCfg.taskId)
	local isGain = EventTaskSummaryModel.instance:isTaskHasGainPrize(taskCfg.taskId)
	local isCanGain = not isGain and progress >= taskCfg.maxProgress

	goutil.setActive(goReceive, isGain)
	goutil.setActive(btnRecieve.gameObject, isCanGain)

	txtName.text = taskCfg.title
	txtProgress.text = (isGain or isCanGain) and "" or string.format("%s/%s", progress, taskCfg.maxProgress)
	txtDesc.text = taskCfg.desc

	self:_setReward(goItem, taskCfg.prize)
	btnJump:AddClickListener(function()
		if isGain then
			FloatWordMgr.instance:show("奖励已领取")

			return
		end

		self:_onClickJump(taskCfg.jumpTo)
	end)
	btnRecieve:AddClickListener(function()
		if isGain then
			FloatWordMgr.instance:show("奖励已领取")

			return
		end

		if isCanGain then
			EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskCfg.taskId)
		end
	end)
end

function LotusbattletaskView:_onClickJump(jumpTo)
	GotoMgr.gotoByString(jumpTo)
end

function LotusbattletaskView:_setReward(goItem, prize)
	MaterialMgr.setCellListByCfg(prize, goItem)

	local layout = goItem:GetComponent(ComponentType.UILayoutSingleLine)

	layout:Layout()
end

function LotusbattletaskView:_clearTableview(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function LotusbattletaskView:_switchTab(tabType)
	if self._tabType == tabType then
		return
	end

	self._tabType = tabType

	self:_reloadTask()
	self:_setTabOnOff()
end

function LotusbattletaskView:_reloadTask()
	local taskCfgs = EventTaskSummaryConfig.instance:getTaskCfgs(self._activityId)
	local canGainList = {}
	local normalList = {}
	local typeId2Cfg = {}
	local isGainList = {}

	for i, v in ipairs(taskCfgs) do
		if not typeId2Cfg[v.typeId] or typeId2Cfg[v.typeId].isGain then
			local progress = EventTaskSummaryModel.instance:getTaskCurProgress(v.taskId)
			local isGain = EventTaskSummaryModel.instance:isTaskHasGainPrize(v.taskId)
			local isCanGain = not isGain and progress >= v.maxProgress

			typeId2Cfg[v.typeId] = {
				cfg = v,
				isGain = isGain,
				isCanGain = isCanGain
			}
		end
	end

	for k, v in pairs(typeId2Cfg) do
		if v.isGain then
			table.insert(isGainList, v.cfg)
		elseif v.isCanGain then
			table.insert(canGainList, v.cfg)
		else
			table.insert(normalList, v.cfg)
		end
	end

	table.sort(canGainList, function(a, b)
		return a.taskId < b.taskId
	end)
	table.sort(normalList, function(a, b)
		return a.taskId < b.taskId
	end)
	table.insertto(canGainList, normalList)
	table.insertto(canGainList, isGainList)

	self._curViewDatas = canGainList

	self:reloadData()
end

function LotusbattletaskView:_setTabOnOff()
	for k, v in pairs(self._tabBtns) do
		goutil.setActive(v.onGo, k == self._tabType)
		goutil.setActive(v.offGo, k ~= self._tabType)
	end
end

function LotusbattletaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function LotusbattletaskView:_getActivityId()
	return LotusbattleModel.instance:getActivityId()
end

return LotusbattletaskView
