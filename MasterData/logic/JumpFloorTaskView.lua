-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorTaskView.lua

module("logic.extensions.jumpfloor.view.JumpFloorTaskView", package.seeall)

local JumpFloorTaskView = class("JumpFloorTaskView", ViewComponent)

function JumpFloorTaskView:ctor()
	JumpFloorTaskView.super.ctor(self)
end

function JumpFloorTaskView:buildUI()
	JumpFloorTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function JumpFloorTaskView:bindEvents()
	JumpFloorTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function JumpFloorTaskView:unbindEvents()
	JumpFloorTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function JumpFloorTaskView:onEnter()
	JumpFloorTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)

	self._activityId = self:getFirstParam()

	self:_sendInfoReq()
end

function JumpFloorTaskView:onExit()
	JumpFloorTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self._scrollerList:dispose()
end

function JumpFloorTaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function JumpFloorTaskView:_updateCell(view, cell, temData, tag)
	local data = temData.data
	local cell = self:_clearCell(cell)

	cell.txtTitle.text = data.title
	cell.txtDesc.text = data.desc

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProgress.text = string.format("<color=#%s>%s</color>/%s", ColorConst.Red, Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)
	GameUtil.SetActive(cell.btnReceive, temData.state == 1)
	GameUtil.SetActive(cell.noReceive, temData.state == 2)
	GameUtil.SetActive(cell.receive, temData.state == 3)
	GameUtil.SetActive(cell.txtProgress.gameObject, temData.state == 2)
	GameUtil.addClickHandler(cell.btnReceive, function()
		self:_onClickRecieve(data.taskId)
	end, self)
end

function JumpFloorTaskView:_clearCell(tempCell)
	local cell = {}

	cell.go = tempCell.gameObject
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgress = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.item = goutil.findChild(cell.go, "item")
	cell.btnReceive = goutil.findChild(cell.go, "btnReceive")
	cell.noReceive = goutil.findChild(cell.go, "noReceive")
	cell.receive = goutil.findChild(cell.go, "receive")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnReceive)

	return cell
end

function JumpFloorTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function JumpFloorTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function JumpFloorTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
end

function JumpFloorTaskView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in ipairs(queue) do
		local list = {}

		for idx, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = EventTaskSummaryController.instance:calcTaskState(self._activityId, data.taskId)

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

		self._taskDataQueue[pageId] = list
	end

	table.sort(self._taskDataQueue, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.data.taskId < b.data.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
end

function JumpFloorTaskView:_updateTaskScrollerList()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskLists = list

	self._scrollerList:reloadData(self._taskLists)
end

function JumpFloorTaskView:_onClickRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

return JumpFloorTaskView
