-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGlorytaskView.lua

module("logic.extensions.recastglory.view.RecastGlorytaskView", package.seeall)

local RecastGlorytaskView = class("RecastGlorytaskView", ViewComponent)

function RecastGlorytaskView:ctor()
	RecastGlorytaskView.super.ctor(self)
end

function RecastGlorytaskView:unbindEvents()
	RecastGlorytaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function RecastGlorytaskView:bindEvents()
	RecastGlorytaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function RecastGlorytaskView:buildUI()
	RecastGlorytaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function RecastGlorytaskView:onExit()
	RecastGlorytaskView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function RecastGlorytaskView:onEnter()
	RecastGlorytaskView.super.onEnter(self)

	self._activityId = 17072
	self._taskPageCfg = EventTaskSummaryConfig.instance:getTaskPageCfg(self._activityId)

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityId / 1000, self._activityId)

	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGetInfoReq(self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function RecastGlorytaskView:_sendInfoReq()
	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGetInfoReq(self._activityId)
end

function RecastGlorytaskView:_onUpdate()
	self:_onUpdateTaskDate()
	self:_onUpdateUI()
end

function RecastGlorytaskView:_onUpdateUI()
	self:_sortTaskCell()
end

function RecastGlorytaskView:_onUpdateTaskDate()
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
			self:_checkTimeCfg(a.data.endTime, b.data.endTime, b.data.taskId)

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
		local isInTimeA = self:_isTaskInTime(a.data.taskId)
		local isInTimeB = self:_isTaskInTime(b.data.taskId)

		if isInTimeA == isInTimeB then
			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		else
			return not not isInTimeA
		end
	end)
end

function RecastGlorytaskView:_sortTaskCell()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskLists = list

	self._scrollList:reloadData(self._taskLists)
end

function RecastGlorytaskView:_isTaskInTime(taskId)
	return EventTaskSummaryController.instance:isTaskInTime(self._activityId, taskId)
end

function RecastGlorytaskView:_isTaskCanJump(taskId)
	return EventTaskSummaryController.instance:isTaskHasJumpStr(self._activityId, taskId)
end

function RecastGlorytaskView:_checkTimeCfg(timeA, timeB, taskId)
	if string.nilorempty(timeA) or string.nilorempty(timeB) then
		return
	end

	local timeA = GameUtil.string2time(timeA)
	local timeB = GameUtil.string2time(timeB)

	if timeB < timeA then
		printError("警告！警告！任务id:" .. taskId .. "，任务生效时间配置错误，请修改配置（yh运营-活动任务.xlsx/export_任务方案），前面任务的结束时间要比后面的晚哦")
	end
end

function RecastGlorytaskView:_updateCell(view, goCell, temData)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	cell.txtTitle.text = data.title
	cell.txtDesc.text = data.desc

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)

	local startDate, endDate = GameUtil.string2date(data.startTime), GameUtil.string2date(data.endTime)

	cell.txtTime.text = string.format("生效时间：\n%02d.%02d 5:00 - %02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)

	local isCanJump = self:_isTaskCanJump(data.taskId)
	local isInTime = self:_isTaskInTime(data.taskId)

	GameUtil.SetActive(cell.btnReceive, temData.state == 1)
	GameUtil.SetActive(cell.btnGoto, temData.state == 2 and isInTime and isCanJump)
	GameUtil.SetActive(cell.noPass, not isCanJump and temData.state == 2)
	GameUtil.SetActive(cell.receive, temData.state == 3)
	GameUtil.SetActive(cell.txtProgress.gameObject, temData.state ~= 3 and isInTime and isCanJump)
	GameUtil.SetActive(cell.txtTime.gameObject, not isInTime and temData.state == 2)
	GameUtil.addClickHandler(cell.btnGoto, function()
		self:_onClickGoto(data)
	end, self)
	GameUtil.addClickHandler(cell.btnReceive, function()
		self:_onClickRecieve(data.taskId)
	end, self)
end

function RecastGlorytaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgress = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.btnReceive = goutil.findChild(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.receive = goutil.findChild(cell.go, "receive")
	cell.noPass = goutil.findChild(cell.go, "noPass")
	cell.rewardViewGo = goutil.findChild(cell.go, "rewardView")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnReceive)
	GameUtil.rmClickHandler(cell.btnGoto)

	return cell
end

function RecastGlorytaskView:_onClickGoto(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	self:close()
	GotoMgr.gotoByString(data.jumpTo)
end

function RecastGlorytaskView:_onClickRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

return RecastGlorytaskView
