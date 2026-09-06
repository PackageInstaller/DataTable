-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/view/GoldendTenTaskView.lua

module("logic.extensions.goldendten.view.GoldendTenTaskView", package.seeall)

local GoldendTenTaskView = class("GoldendTenTaskView", ViewComponent)

function GoldendTenTaskView:buildUI()
	GoldendTenTaskView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("tablecell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.redpoint = goutil.findChild(btn.go, "dot")
		self._btnsSwitch[i] = btn
	end

	self._btnClose = self:getGo("bg/btnClose")
end

function GoldendTenTaskView:bindEvents()
	GoldendTenTaskView.super.bindEvents(self)

	for k, btn in ipairs(self._btnsSwitch) do
		GameUtil.addClickHandler(btn.go, GameUtil.handler(self._onClickSwitch, self, k))
	end

	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoldendTenTaskView:unbindEvents()
	GoldendTenTaskView.super.unbindEvents(self)

	for k, btn in ipairs(self._btnsSwitch) do
		GameUtil.rmClickHandler(btn.go)
	end

	GameUtil.rmClickHandler(self._btnClose)
end

function GoldendTenTaskView:onEnter()
	GoldendTenTaskView.super.onEnter(self)

	self._switchId = 1

	self:_sendInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function GoldendTenTaskView:onExit()
	GoldendTenTaskView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function GoldendTenTaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btnRecieve = goutil.findChild(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.goReceive = goutil.findChild(cell.go, "receive")
	cell.goNotReach = goutil.findChild(cell.go, "notReach")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgerss = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnRecieve)
	GameUtil.rmClickHandler(cell.btnGoto)

	return cell
end

function GoldendTenTaskView:_updateCell(view, goCell, temData)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)

	cell.txtDesc.text = data.desc
	cell.txtTitle.text = data.title

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProgerss.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	GameUtil.SetActive(cell.btnRecieve, temData.state == 1)

	local exitGotoStr = not string.nilorempty(data.jumpTo)

	GameUtil.SetActive(cell.btnGoto, exitGotoStr and temData.state == 2)
	GameUtil.SetActive(cell.goNotReach, not exitGotoStr and temData.state == 2)
	GameUtil.SetActive(cell.goReceive, temData.state == 3)
	GameUtil.SetActive(cell.txtProgerss.gameObject, temData.state ~= 3)
	GameUtil.addClickHandler(cell.btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(cell.btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function GoldendTenTaskView:_onClickBtnGo(data)
	if not string.nilorempty(data.jumpTo) then
		self:close()
		GotoMgr.gotoByString(data.jumpTo)

		if data.viewId > 0 then
			EventTaskSummaryController.instance:onSendEventTaskSummaryViewReq(self._curActId, data.viewId)
		end
	end
end

function GoldendTenTaskView:_onClickBtnRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._curActId, taskId)
end

function GoldendTenTaskView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		self:_onUpdate()
	end
end

function GoldendTenTaskView:_sendInfoReq()
	self._curActId = checkint(self:getFirstParam())

	if self._curActId ~= 0 then
		EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._curActId)
	end
end

function GoldendTenTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GoldendTenTaskView:_onUpdateData()
	self._taskDataQueue = {}

	if self._curActId ~= 0 then
		local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._curActId)

		for pageId, taskList in ipairs(queue) do
			local list = {}

			for idx, data in ipairs(taskList) do
				local timePeriod = GameUtil.getTimePeriod(data.startTime, data.endTime)

				if timePeriod == GameUtil.inTimePeriod then
					local tab = {}

					tab.data = data
					tab.state = EventTaskSummaryController.instance:calcTaskState(self._curActId, data.taskId)

					table.insert(list, tab)
				end
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
end

function GoldendTenTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()

	for k, v in ipairs(self._btnsSwitch) do
		goutil.setActive(v.select, k == self._switchId)
	end
end

function GoldendTenTaskView:_updateTaskScrollerList()
	local list = {}
	local fitterList = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	goutil.setActive(self._btnsSwitch[1].redpoint, false)
	goutil.setActive(self._btnsSwitch[2].redpoint, false)

	for _, v in ipairs(list) do
		if v.data.periodType == "daily" then
			if self._switchId == 1 then
				table.insert(fitterList, v)
			end

			if v.state == 1 then
				goutil.setActive(self._btnsSwitch[1].redpoint, true)
			end
		else
			if self._switchId == 2 then
				table.insert(fitterList, v)
			end

			if v.state == 1 then
				goutil.setActive(self._btnsSwitch[2].redpoint, true)
			end
		end
	end

	self._tableView:reloadData(fitterList)
end

return GoldendTenTaskView
