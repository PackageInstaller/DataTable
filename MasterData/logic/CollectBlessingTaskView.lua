-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectBlessingTaskView.lua

module("logic.extensions.birthdaywishes.view.CollectBlessingTaskView", package.seeall)

local CollectBlessingTaskView = class("CollectBlessingTaskView", ViewComponent)

function CollectBlessingTaskView:ctor()
	CollectBlessingTaskView.super.ctor(self)
end

function CollectBlessingTaskView:unbindEvents()
	CollectBlessingTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CollectBlessingTaskView:bindEvents()
	CollectBlessingTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function CollectBlessingTaskView:buildUI()
	CollectBlessingTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("topCol/btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CollectBlessingTaskView:onExit()
	CollectBlessingTaskView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)

	for cellGo, scrollList in pairs(self._scrollListMap) do
		scrollList:dispose()

		self._scrollListMap[cellGo] = nil
	end
end

function CollectBlessingTaskView:onEnter()
	CollectBlessingTaskView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._scrollListMap = {}

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function CollectBlessingTaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function CollectBlessingTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CollectBlessingTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function CollectBlessingTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
end

function CollectBlessingTaskView:_onUpdateTaskData()
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

function CollectBlessingTaskView:_updateTaskScrollerList()
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

function CollectBlessingTaskView:_updateCell(view, goCell, temData, tag)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	cell.txtTitle.text = data.title
	cell.txtDesc.text = data.desc

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	GameUtil.SetActive(cell.btnReceive, temData.state == 1)
	GameUtil.SetActive(cell.btnGoto, temData.state == 2)
	GameUtil.SetActive(cell.receive, temData.state == 3)
	GameUtil.SetActive(cell.txtProgress.gameObject, temData.state ~= 3)

	local prize = data.prize
	local prizeArr = string.split(prize, "#")
	local scrollList = self._scrollListMap[goCell]

	if scrollList == nil then
		self._scrollListMap[goCell] = ScrollerList.create(cell.scrollView, cell.scrollCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		scrollList = self._scrollListMap[goCell]
	end

	scrollList:reloadData(prizeArr)
	scrollList:dragNotifyParent()
	GameUtil.addClickHandler(cell.btnGoto, function()
		self:_onClickGoto(data)
	end, self)
	GameUtil.addClickHandler(cell.btnReceive, function()
		self:_onClickRecieve(data.taskId)
	end, self)
end

function CollectBlessingTaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgress = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.scrollView = goutil.findChild(cell.go, "tableviewReward")
	cell.scrollCell = goutil.findChild(cell.go, "tableviewReward/tablecell")
	cell.btnReceive = goutil.findChild(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.receive = goutil.findChild(cell.go, "receive")

	GameUtil.rmClickHandler(cell.btnReceive)
	GameUtil.rmClickHandler(cell.btnGoto)

	local scrollList = self._scrollListMap[goCell]

	if scrollList then
		scrollList:dispose()

		self._scrollListMap[goCell] = nil
	end

	return cell
end

function CollectBlessingTaskView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function CollectBlessingTaskView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function CollectBlessingTaskView:_onClickClose()
	self:close()
	BirthdayWishesController.instance:csGetBirthdayWishesUserInfoReq(self._activityId)
end

function CollectBlessingTaskView:_onClickGoto(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	self:close()
end

function CollectBlessingTaskView:_onClickRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

return CollectBlessingTaskView
