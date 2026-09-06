-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/studenttask/StudentBaseTaskView.lua

module("logic.extensions.tutorsystem.view.studenttask.StudentBaseTaskView", package.seeall)

local StudentBaseTaskView = class("StudentBaseTaskView", ViewComponent)

function StudentBaseTaskView:ctor()
	StudentBaseTaskView.super.ctor(self)
end

function StudentBaseTaskView:buildUI()
	StudentBaseTaskView.super.buildUI(self)

	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._empty = goutil.findChild(self.mainGO, "taskCol/empty")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function StudentBaseTaskView:bindEvents()
	StudentBaseTaskView.super.bindEvents(self)
end

function StudentBaseTaskView:unbindEvents()
	StudentBaseTaskView.super.unbindEvents(self)
end

function StudentBaseTaskView:onEnter()
	StudentBaseTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentGainBaseTaskPrizeRes, self._handleTaskPrizeRes, self)
	self:_sendInfoReq()
	self:_handleTaskPrizeRes(msg, 37)
end

function StudentBaseTaskView:onExit()
	StudentBaseTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentGainBaseTaskPrizeRes, self._handleTaskPrizeRes, self)
	self._taskScrollList:dispose()
end

function StudentBaseTaskView:_handleTaskPrizeRes(msg, taskId)
	local itemlist = {}

	if msg and msg.changeSetId ~= 0 then
		local changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(changeSetId)

		local items = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)

		for _, data in ipairs(items) do
			local mo = MaterialModel.instance:createMo(data:getMatType(), data:getDefineId(), data:GetCount())

			table.insert(itemlist, mo)
		end
	end

	TutorSystemController.instance:popChangSetItemList(itemlist)
	self:_sendInfoReq()
end

function StudentBaseTaskView:_sendInfoReq()
	TutorSystemController.instance:sendTutorStudentTaskInfoReq()
end

function StudentBaseTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StudentBaseTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function StudentBaseTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function StudentBaseTaskView:_onUpdatePlaneUI()
	GameUtil.SetActive(self._empty, false)
end

function StudentBaseTaskView:_onUpdateTaskData()
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

function StudentBaseTaskView:_calcPrizeState(taskId)
	local isHasGain = TutorSystemController.instance:isHasGainBaseTaskPrizeInStuTask(taskId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = TutorSystemController.instance:isEnoughGetBaseTaskPrizeInStuTask(taskId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function StudentBaseTaskView:_updateTaskScrollerList()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == GameEnum.PrizeState.IsHasGain then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskScrollList:reloadData(list)
end

function StudentBaseTaskView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProg = goutil.findChildTextComponent(mainGo, "txtTitle/txtProg")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")
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

		local curProgress = TutorSystemModel.instance:getBaseTaskCurProgressInStuTask(data.taskId)
		local maxProgress = data.maxProgress

		txtProg.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		GameUtil.SetActive(txtProg.gameObject, state ~= GameEnum.PrizeState.IsHasGain)
		GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
		GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough and not string.nilorempty(data.jumpTo))
		GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
		GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
		GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnReceive, self, data.taskId))
	end
end

function StudentBaseTaskView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function StudentBaseTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStuTaskFloorCloseSignal)
end

function StudentBaseTaskView:_onClickBtnReceive(taskId)
	TutorSystemController.instance:sendTutorStudentGainBaseTaskPrizeReq(taskId)
end

function StudentBaseTaskView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function StudentBaseTaskView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return StudentBaseTaskView
