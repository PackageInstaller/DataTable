-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishTreeTaskView.lua

module("logic.extensions.wishtree.view.WishTreeTaskView", package.seeall)

local WishTreeTaskView = class("WishTreeTaskView", ViewComponent)

function WishTreeTaskView:ctor()
	WishTreeTaskView.super.ctor(self)
end

function WishTreeTaskView:unbindEvents()
	WishTreeTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function WishTreeTaskView:bindEvents()
	WishTreeTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function WishTreeTaskView:buildUI()
	WishTreeTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function WishTreeTaskView:onExit()
	WishTreeTaskView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	GlobalDispatcher:dispatch(GlobalNotify.WishTreePrayValueUpdated)
end

function WishTreeTaskView:onEnter()
	WishTreeTaskView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
	WishTreeModel.instance:setIsAddValue(false)
end

function WishTreeTaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function WishTreeTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function WishTreeTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function WishTreeTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
end

function WishTreeTaskView:_onUpdateTaskData()
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

function WishTreeTaskView:_updateTaskScrollerList()
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

function WishTreeTaskView:_updateCell(view, goCell, temData, tag)
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
	GameUtil.addClickHandler(cell.btnGoto, function()
		self:_onClickGoto(data)
	end, self)
	GameUtil.addClickHandler(cell.btnReceive, function()
		self:_onClickRecieve(data.taskId)
	end, self)
end

function WishTreeTaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgress = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.item = goutil.findChild(cell.go, "item")
	cell.btnReceive = goutil.findChild(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.receive = goutil.findChild(cell.go, "receive")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnReceive)
	GameUtil.rmClickHandler(cell.btnGoto)

	return cell
end

function WishTreeTaskView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.WishTreeGetInfoRes)
	self:close()
end

function WishTreeTaskView:_onClickGoto(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	self:close()
end

function WishTreeTaskView:_onClickRecieve(taskId)
	WishTreeModel.instance:setIsAddValue(true)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

return WishTreeTaskView
