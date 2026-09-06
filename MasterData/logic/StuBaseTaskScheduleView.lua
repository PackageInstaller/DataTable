-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/StuBaseTaskScheduleView.lua

module("logic.extensions.tutorsystem.view.teachertask.StuBaseTaskScheduleView", package.seeall)

local StuBaseTaskScheduleView = class("StuBaseTaskScheduleView", ViewComponent)

function StuBaseTaskScheduleView:ctor()
	StuBaseTaskScheduleView.super.ctor(self)
end

function StuBaseTaskScheduleView:buildUI()
	StuBaseTaskScheduleView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "topCol/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "topCol/txtTitle")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function StuBaseTaskScheduleView:bindEvents()
	StuBaseTaskScheduleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StuBaseTaskScheduleView:unbindEvents()
	StuBaseTaskScheduleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StuBaseTaskScheduleView:onEnter()
	StuBaseTaskScheduleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._userId = params[1]

	if self._userId == nil then
		FloatWordMgr.instance:show("缺失传入参数:userId")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.TutorGainBaseTaskInfo, self._onUpdate, self)
	TutorSystemController.instance:sendTutorTeacherGainStudentBaseTaskInfoReq(self._userId)
end

function StuBaseTaskScheduleView:onExit()
	StuBaseTaskScheduleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorGainBaseTaskInfo, self._onUpdate, self)
	self._taskScrollList:dispose()
end

function StuBaseTaskScheduleView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StuBaseTaskScheduleView:_onUpdateData()
	self:_onUpdateTaskData()
end

function StuBaseTaskScheduleView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function StuBaseTaskScheduleView:_onUpdatePlaneUI()
	return
end

function StuBaseTaskScheduleView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = {}
	local baseTaskCfg = TutorSystemConfig.instance:getTsBaseTaskCfg()

	for taskId, data in ipairs(baseTaskCfg) do
		queue[data.pageIdx] = queue[data.pageIdx] or {}

		table.insert(queue[data.pageIdx], data)
	end

	for pageIdx, taskList in ipairs(queue) do
		local list = {}

		for idx, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = self:_calcPrizeState(data.taskId)

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

		self._taskDataQueue[pageIdx] = list
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

local PrizeState = {
	IsCanGet = 2,
	IsHasGain = 3,
	IsNotEnough = 1
}

function StuBaseTaskScheduleView:_calcPrizeState(taskId)
	local isHasGain = TutorSystemController.instance:isHasGainPrizeAsBaseTask(self._userId, taskId)

	if isHasGain then
		return PrizeState.IsHasGain
	end

	local isEnough = TutorSystemController.instance:isEnoughGetPrizeAsBaseTask(self._userId, taskId)

	if not isEnough then
		return PrizeState.IsNotEnough
	end

	return PrizeState.IsCanGet
end

function StuBaseTaskScheduleView:_getEnoughTaskCountAsSamePage(pageIdx)
	local list = self:_getTaskList(pageIdx)
	local count = 0

	for _, tab in ipairs(list) do
		if tab.state ~= PrizeState.IsNotEnough then
			count = count + 1
		end
	end

	return count
end

function StuBaseTaskScheduleView:_getTaskCountAsSamePage(pageIdx)
	local list = self:_getTaskList(pageIdx)

	return #list
end

function StuBaseTaskScheduleView:_getTaskList(pageIdx)
	if self._taskDataQueue == nil then
		return {}
	end

	for _, list in ipairs(self._taskDataQueue) do
		if list[1].data.pageIdx == pageIdx then
			return list
		end
	end
end

function StuBaseTaskScheduleView:_updateTaskScrollerList()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state ~= PrizeState.IsNotEnough then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskScrollList:reloadData(list)
end

function StuBaseTaskScheduleView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProg = goutil.findChildTextComponent(mainGo, "txtTitle/txtProg")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")
	local txtPageProgressGo = goutil.findChild(mainGo, "txtPageProgress")
	local txtPageProgress = goutil.findChildTextComponent(mainGo, "txtPageProgress/txt")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtTitle.text = data.title
	txtDesc.text = data.desc

	local prizeStrArr = string.split(data.prize, "#")

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		local gradScoreStr = TutorSystemConfig.instance:getTutorSystemGradScoreItem()
		local gradScoreStr = TutorSystemConfig.instance:getTutorSystemGradScoreItemStr(data.score)
		local itemDataList = {}

		if gradScoreStr then
			table.insert(itemDataList, gradScoreStr)
		end

		for _, str in ipairs(prizeStrArr) do
			table.insert(itemDataList, str)
		end

		self._itemScrollListDic[mainGo]:reloadData(itemDataList)
		self._itemScrollListDic[mainGo]:dragNotifyParent()

		local curProgress = TutorSystemModel.instance:getCurProgressAsBaseTask(self._userId, data.taskId)
		local maxProgress = data.maxProgress

		txtProg.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		GameUtil.SetActive(txtProg.gameObject, state == PrizeState.IsNotEnough)

		local enoughCount = self:_getEnoughTaskCountAsSamePage(data.pageIdx)
		local totalCount = self:_getTaskCountAsSamePage(data.pageIdx)

		GameUtil.SetActive(txtPageProgressGo, enoughCount <= totalCount)

		txtPageProgress.text = string.format("%s/%s", Mathf.Clamp(enoughCount, 0, totalCount), totalCount)

		GameUtil.SetActive(btnReceive, false)
		GameUtil.SetActive(btnGoto, false)
		GameUtil.SetActive(receivedGo, false)
	end
end

function StuBaseTaskScheduleView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function StuBaseTaskScheduleView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function StuBaseTaskScheduleView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return StuBaseTaskScheduleView
