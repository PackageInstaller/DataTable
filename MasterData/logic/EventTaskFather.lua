-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/EventTaskFather.lua

module("logic.extensions.eventtasksummary.view.EventTaskFather", package.seeall)

local EventTaskFather = class("EventTaskFather", ViewComponent)

function EventTaskFather:ctor()
	EventTaskFather.super.ctor(self)
end

function EventTaskFather:buildUI()
	EventTaskFather.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "topCol/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "topCol/txtTitle")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function EventTaskFather:bindEvents()
	EventTaskFather.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EventTaskFather:unbindEvents()
	EventTaskFather.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EventTaskFather:onEnter()
	EventTaskFather.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityType = checknumber(EventTaskSummaryConfig.instance:getActivityType(self._activityId))

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function EventTaskFather:onExit()
	EventTaskFather.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self._taskScrollList:dispose()
end

function EventTaskFather:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function EventTaskFather:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EventTaskFather:_onUpdateData()
	self:_onUpdateTaskData()
end

function EventTaskFather:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function EventTaskFather:_onUpdatePlaneUI()
	return
end

function EventTaskFather:_onUpdateTaskData()
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
			tab.state = self:_calcTaskState(data.taskId)

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

function EventTaskFather:_calcTaskState(taskId)
	return EventTaskSummaryController.instance:calcTaskState(self._activityId, taskId)
end

function EventTaskFather:_updateTaskScrollerList()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if #taskDataList > 0 then
			if taskDataList[1].state == GameEnum.PrizeState.IsHasGain then
				table.insert(list, taskDataList[#taskDataList])
			else
				table.insert(list, taskDataList[1])
			end
		end
	end

	self._taskScrollList:reloadData(list)
end

function EventTaskFather:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProg = goutil.findChildTextComponent(mainGo, "txtTitle/txtProg")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")

	if goutil.isNil(txtDesc) then
		txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	end

	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	if txtTitle then
		txtTitle.text = data.title
	end

	if txtDesc then
		txtDesc.text = data.desc
	end

	if txtProg then
		local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
		local maxProgress = data.maxProgress

		txtProg.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		GameUtil.SetActive(txtProg.gameObject, state ~= GameEnum.PrizeState.IsHasGain)
	end

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end

	GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough and not string.nilorempty(data.jumpTo))
	GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function EventTaskFather:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function EventTaskFather:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	self:close()
end

function EventTaskFather:_onClickBtnRecieve(taskId)
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

function EventTaskFather:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function EventTaskFather:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return EventTaskFather
