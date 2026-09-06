-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/view/GeneralWorldProgressTaskView.lua

module("logic.extensions.generalworldprogress.view.GeneralWorldProgressTaskView", package.seeall)

local GeneralWorldProgressTaskView = class("GeneralWorldProgressTaskView", ViewComponent)

function GeneralWorldProgressTaskView:buildUI()
	GeneralWorldProgressTaskView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("tablecell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.redpoint = goutil.findChild(btn.go, "redpoint")
		self._btnsSwitch[i] = btn
	end

	self._btnClose = self:getGo("btnClose")
end

function GeneralWorldProgressTaskView:bindEvents()
	GeneralWorldProgressTaskView.super.bindEvents(self)

	for k, btn in ipairs(self._btnsSwitch) do
		GameUtil.addClickHandler(btn.go, GameUtil.handler(self._onClickSwitch, self, k))
	end

	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GeneralWorldProgressTaskView:unbindEvents()
	GeneralWorldProgressTaskView.super.unbindEvents(self)

	for k, btn in ipairs(self._btnsSwitch) do
		GameUtil.rmClickHandler(btn.go)
	end

	GameUtil.rmClickHandler(self._btnClose)
end

function GeneralWorldProgressTaskView:onEnter()
	GeneralWorldProgressTaskView.super.onEnter(self)

	self._switchId = 1

	self:_sendInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function GeneralWorldProgressTaskView:onExit()
	GeneralWorldProgressTaskView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function GeneralWorldProgressTaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.btnGoTo = goutil.findChild(cell.go, "btnGoTo")
	cell.goFinish = goutil.findChild(cell.go, "finishGo")
	cell.goNoFinish = goutil.findChild(cell.go, "noFinishGo")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "descTxt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "nameTxt")
	cell.txtProger = goutil.findChildTextComponent(cell.go, "progerTxt")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnGet)
	GameUtil.rmClickHandler(cell.btnGoTo)

	return cell
end

function GeneralWorldProgressTaskView:_updateCell(view, goCell, temData)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)

	cell.txtDesc.text = data.desc
	cell.txtName.text = data.title

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProger.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	GameUtil.SetActive(cell.btnGet, temData.state == 1)

	local existGotoStr = not string.nilorempty(data.jumpTo)

	GameUtil.SetActive(cell.btnGoTo, temData.state == 2 and existGotoStr)
	GameUtil.SetActive(cell.goNoFinish, temData.state == 2 and not existGotoStr)
	GameUtil.SetActive(cell.goFinish, temData.state == 3)
	GameUtil.SetActive(cell.txtProger.gameObject, temData.state ~= 3)
	GameUtil.addClickHandler(cell.btnGoTo, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function GeneralWorldProgressTaskView:_onClickBtnGo(data)
	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)
		self:close()
	end
end

function GeneralWorldProgressTaskView:_onClickBtnRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._curActId, taskId)
end

function GeneralWorldProgressTaskView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		self:_onUpdate()
	end
end

function GeneralWorldProgressTaskView:_sendInfoReq()
	self._curActId = checkint(self:getFirstParam())

	if self._curActId ~= 0 then
		EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._curActId)
	end
end

function GeneralWorldProgressTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GeneralWorldProgressTaskView:_onUpdateData()
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

function GeneralWorldProgressTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()

	for k, v in ipairs(self._btnsSwitch) do
		goutil.setActive(v.select, k == self._switchId)
	end
end

function GeneralWorldProgressTaskView:_updateTaskScrollerList()
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

return GeneralWorldProgressTaskView
