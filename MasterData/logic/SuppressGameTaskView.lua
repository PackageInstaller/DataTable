-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameTaskView.lua

module("logic.extensions.suppressgame.view.SuppressGameTaskView", package.seeall)

local SuppressGameTaskView = class("SuppressGameTaskView", ViewComponent)

function SuppressGameTaskView:ctor()
	SuppressGameTaskView.super.ctor(self)
end

function SuppressGameTaskView:buildUI()
	SuppressGameTaskView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "topCol/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "topCol/txtTitle")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function SuppressGameTaskView:bindEvents()
	SuppressGameTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SuppressGameTaskView:unbindEvents()
	SuppressGameTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SuppressGameTaskView:onEnter()
	SuppressGameTaskView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SuppressGame)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.SuppressGameGetTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameGainPrizeRes, self._sendInfoReq, self)
	self:_sendInfoReq()
	self:_onUpdate()
end

function SuppressGameTaskView:onExit()
	SuppressGameTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameGetTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameGainPrizeRes, self._sendInfoReq, self)
	self._taskScrollList:dispose()
end

function SuppressGameTaskView:_sendInfoReq()
	SuppressGameController.instance:onSendSuppressGameGetTaskInfoReq(self._activityId)
end

function SuppressGameTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SuppressGameTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function SuppressGameTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function SuppressGameTaskView:_onUpdatePlaneUI()
	return
end

function SuppressGameTaskView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local sgTabCfg = SuppressGameConfig.instance:getSgTabCfg(self._activityId)

	for gameId, sgTabData in ipairs(sgTabCfg) do
		local taskCfg = SuppressGameConfig.instance:getSgTaskCfg(sgTabData.taskPlanId)
		local list = {}

		for taskId, data in ipairs(taskCfg) do
			local tab = {}

			tab.data = data
			tab.gameId = gameId
			tab.state = self:_calcTaskState(gameId, data.taskId)

			table.insert(list, tab)
		end

		table.sort(list, function(a, b)
			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)

		self._taskDataQueue[gameId] = list
	end

	table.sort(self._taskDataQueue, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.data.taskPlanId < b.data.taskPlanId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
end

local taskState = {
	notEnough = 2,
	isHasGain = 3,
	isCanGet = 1
}

function SuppressGameTaskView:_calcTaskState(gameId, taskId)
	local isHasGain = SuppressGameModel.instance:isTaskHasGainPrize(gameId, taskId)

	if isHasGain then
		return taskState.isHasGain
	end

	local isEnough = SuppressGameModel.instance:isTaskEnoughProgress(gameId, taskId)

	if not isEnough then
		return taskState.notEnough
	end

	return taskState.isCanGet
end

function SuppressGameTaskView:_updateTaskScrollerList()
	local list = {}

	for gameId, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == taskState.isHasGain then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskScrollList:reloadData(list)
end

function SuppressGameTaskView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local gameId = cfg.gameId
	local mainGo = cell.gameObject
	local btnRecieve = goutil.findChild(mainGo, "btnRecieve")
	local imgNotEnough = goutil.findChild(mainGo, "imgNotEnough")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")

	txtDesc.text = data.desc

	local curProgress = SuppressGameModel.instance:getTaskProgress(gameId)
	local maxProgress = data.progress

	txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	local prizeStrArr = string.split(data.prize, "#")

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		self._itemScrollListDic[mainGo]:dragNotifyParent()
		GameUtil.SetActive(btnRecieve, state == taskState.isCanGet)
		GameUtil.SetActive(imgNotEnough, state == taskState.notEnough)
		GameUtil.SetActive(receivedGo, state == taskState.isHasGain)
		GameUtil.SetActive(txtProgress.gameObject, state ~= taskState.isHasGain)
		GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, gameId, data.taskId))
	end
end

function SuppressGameTaskView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function SuppressGameTaskView:_onClickBtnRecieve(gameId, taskId)
	SuppressGameController.instance:onSendSuppressGameGainPrizeReq(self._activityId, gameId, taskId)
end

function SuppressGameTaskView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function SuppressGameTaskView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return SuppressGameTaskView
