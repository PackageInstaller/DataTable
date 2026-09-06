-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/EventTaskTabChildView.lua

module("logic.extensions.eventtasksummary.view.tab.EventTaskTabChildView", package.seeall)

local EventTaskTabChildView = class("EventTaskTabChildView", ViewComponent)

function EventTaskTabChildView:ctor()
	EventTaskTabChildView.super.ctor(self)
end

function EventTaskTabChildView:buildUI()
	EventTaskTabChildView.super.buildUI(self)

	local taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	local taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._taskScrollList = ScrollerList.create(taskScrollerview, taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function EventTaskTabChildView:bindEvents()
	EventTaskTabChildView.super.bindEvents(self)
end

function EventTaskTabChildView:unbindEvents()
	EventTaskTabChildView.super.unbindEvents(self)
end

function EventTaskTabChildView:onEnter()
	EventTaskTabChildView.super.onEnter(self)

	local params = self:getOpenParam()

	self._eventTaskMgr = params[1]
	self._pageId = checknumber(params[2])
	self._viewParams = params[3]
	self._activityId = self._eventTaskMgr:getActivityId()
	self._activityType = checknumber(EventTaskSummaryConfig.instance:getActivityType(self._activityId))

	self.addGEvent(self, GlobalNotify.PM_EventTaskTabUpdate, self._onTaskTabUpdate, self)
	self:_onUpdate()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function EventTaskTabChildView:onExit()
	EventTaskTabChildView.super.onExit(self)
	self._taskScrollList:dispose()

	self._eventTaskMgr = nil
	self._pageId = nil
	self._activityId = nil
	self._activityType = nil
end

function EventTaskTabChildView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EventTaskTabChildView:_onUpdateData()
	self:_onUpdateTaskData()
end

function EventTaskTabChildView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function EventTaskTabChildView:_onUpdatePlaneUI()
	return
end

function EventTaskTabChildView:_onUpdateTaskData()
	local typeInfoList = {}
	local typeIdList = self._eventTaskMgr:getTypeIdList(self._pageId)

	for index, typeId in ipairs(typeIdList) do
		local taskInfoList = {}
		local taskIdList = self._eventTaskMgr:getTaskIdList(self._pageId, typeId)

		for _, taskId in ipairs(taskIdList) do
			local info = {}

			info.taskId = taskId
			info.state = self._eventTaskMgr:_getTaskState(taskId)

			table.insert(taskInfoList, info)
		end

		if #taskInfoList > 0 then
			table.sort(taskInfoList, function(a, b)
				if a.state == b.state then
					if a.taskId < b.taskId then
						return true
					end

					return false
				end

				return a.state < b.state
			end)
			table.insert(typeInfoList, taskInfoList)
		end
	end

	table.sort(typeInfoList, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.taskId < b.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)

	self._typeInfoList = typeInfoList
end

function EventTaskTabChildView:_updateTaskScrollerList()
	local list = {}

	for typeId, taskInfoList in ipairs(self._typeInfoList) do
		if #taskInfoList > 0 then
			if taskInfoList[1].state == GameEnum.PrizeState.IsHasGain then
				table.insert(list, taskInfoList[#taskInfoList])
			else
				table.insert(list, taskInfoList[1])
			end
		end
	end

	self._taskScrollList:reloadData(list)
end

function EventTaskTabChildView:_updateTaskCell(view, cell, info, tag)
	local taskId = info.taskId
	local state = info.state
	local data = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
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

	if txtProgress then
		local curProgress = self._eventTaskMgr:getCurProgressOfTask(taskId)
		local maxProgress = data.maxProgress

		txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		local isNeedShow = not data.isHideProgress and state == GameEnum.PrizeState.IsNotEnough

		GameUtil.SetActive(txtProgress.gameObject, isNeedShow)
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
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnReceive, self, data.taskId))
end

function EventTaskTabChildView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnGoto)
	GameUtil.rmClickHandler(btnReceive)
end

function EventTaskTabChildView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:_onClickBtnClose()
	end
end

function EventTaskTabChildView:_onClickBtnReceive(taskId)
	local result, tips = self._eventTaskMgr:getTryGainPrizeResultAndTips(taskId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local taskIdList = self._eventTaskMgr:getCanGainTaskIdListByPage(self._pageId)

	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskIdList)
end

function EventTaskTabChildView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function EventTaskTabChildView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function EventTaskTabChildView:_onClickBtnClose()
	GlobalDispatcher:dispatch(GlobalNotify.PM_EventTaskTabChildExit)
end

function EventTaskTabChildView:_onTaskTabUpdate()
	self:_onUpdate()
end

return EventTaskTabChildView
