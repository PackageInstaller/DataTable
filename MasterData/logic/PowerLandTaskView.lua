-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/PowerLandTaskView.lua

module("logic.extensions.eventtasksummary.view.PowerLandTaskView", package.seeall)

local PowerLandTaskView = class("PowerLandTaskView", ViewComponent)

function PowerLandTaskView:ctor()
	PowerLandTaskView.super.ctor(self)
end

function PowerLandTaskView:buildUI()
	PowerLandTaskView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "topCol/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "topCol/txtTitle")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function PowerLandTaskView:bindEvents()
	PowerLandTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PowerLandTaskView:unbindEvents()
	PowerLandTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PowerLandTaskView:onEnter()
	PowerLandTaskView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function PowerLandTaskView:onExit()
	PowerLandTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self._taskScrollList:dispose()
end

function PowerLandTaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function PowerLandTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PowerLandTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function PowerLandTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function PowerLandTaskView:_onUpdatePlaneUI()
	return
end

function PowerLandTaskView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = EventTaskSummaryConfig.instance:getVisibleTaskQueue(self._activityId, EventTaskSummaryModel.instance:getPlayerTypeTag(self._activityId))
	local pageIdList = table.keys(queue)

	table.sort(pageIdList, function(a, b)
		return a < b
	end)

	for _, pageId in ipairs(pageIdList) do
		local taskList = queue[pageId]
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

		if #list > 0 then
			table.insert(self._taskDataQueue, list)
		end
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

function PowerLandTaskView:_updateTaskScrollerList()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if #taskDataList > 0 then
			if taskDataList[1].state == 3 then
				table.insert(list, taskDataList[#taskDataList])
			else
				table.insert(list, taskDataList[1])
			end
		end
	end

	self._taskScrollList:reloadData(list)
end

function PowerLandTaskView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnRecieve = goutil.findChild(mainGo, "btnRecieve")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")

	txtTitle.text = data.title
	txtDesc.text = data.desc

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	local prizeStrArr = string.split(data.prize, "#")

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		self._itemScrollListDic[mainGo]:dragNotifyParent()
		GameUtil.SetActive(btnRecieve, state == 1)
		GameUtil.SetActive(btnGoto, state == 2)
		GameUtil.SetActive(receivedGo, state == 3)
		GameUtil.SetActive(txtProgress.gameObject, state ~= 3)
		GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
		GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
	end
end

function PowerLandTaskView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function PowerLandTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	self:close()
end

function PowerLandTaskView:_onClickBtnRecieve(taskId)
	for _, taskDataList in ipairs(self._taskDataQueue or {}) do
		for _, info in ipairs(taskDataList) do
			if info.data.taskId == taskId then
				local taskIdList = {}

				for _, taskInfo in ipairs(taskDataList) do
					if taskInfo.state == GameEnum.PrizeState.IsCanGet then
						table.insert(taskIdList, taskInfo.data.taskId)
					end
				end

				EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskIdList)

				return
			end
		end
	end
end

function PowerLandTaskView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function PowerLandTaskView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return PowerLandTaskView
