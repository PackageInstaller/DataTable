-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/studenttask/StudentGrowthTaskView.lua

module("logic.extensions.tutorsystem.view.studenttask.StudentGrowthTaskView", package.seeall)

local StudentGrowthTaskView = class("StudentGrowthTaskView", ViewComponent)

function StudentGrowthTaskView:ctor()
	StudentGrowthTaskView.super.ctor(self)
end

function StudentGrowthTaskView:buildUI()
	StudentGrowthTaskView.super.buildUI(self)

	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._empty = goutil.findChild(self.mainGO, "taskCol/empty")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function StudentGrowthTaskView:bindEvents()
	StudentGrowthTaskView.super.bindEvents(self)
end

function StudentGrowthTaskView:unbindEvents()
	StudentGrowthTaskView.super.unbindEvents(self)
end

function StudentGrowthTaskView:onEnter()
	StudentGrowthTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentGainGrowthTaskPrizeRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function StudentGrowthTaskView:onExit()
	StudentGrowthTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentGainGrowthTaskPrizeRes, self._sendInfoReq, self)
	self._taskScrollList:dispose()
end

function StudentGrowthTaskView:_sendInfoReq()
	TutorSystemController.instance:sendTutorStudentTaskInfoReq()
end

function StudentGrowthTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StudentGrowthTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function StudentGrowthTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function StudentGrowthTaskView:_onUpdatePlaneUI()
	GameUtil.SetActive(self._empty, false)
end

function StudentGrowthTaskView:_onUpdateTaskData()
	self._taskDataList = {}

	local dataList = {}
	local growthTaskIdList = TutorSystemModel.instance:getPublishedGrowthTaskIdListInStuTask()

	for _, taskId in ipairs(growthTaskIdList) do
		local data = TutorSystemConfig.instance:getTsGrowthTaskData(taskId)

		table.insert(dataList, data)
	end

	local list = {}

	for _, data in ipairs(dataList) do
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

	self._taskDataList = list
end

function StudentGrowthTaskView:_calcPrizeState(taskId)
	local isHasGain = TutorSystemController.instance:isHasGainGrowUpTaskPrizeInStuTask(taskId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = TutorSystemController.instance:isEnouthGetGrowUpTaskPrizeInStuTask(taskId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function StudentGrowthTaskView:_updateTaskScrollerList()
	self._taskScrollList:reloadData(self._taskDataList)
end

function StudentGrowthTaskView:_updateTaskCell(view, cell, cfg, tag)
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

		local curProgress = TutorSystemModel.instance:getGrowUpTaskCurProgressInStuTask(data.taskId)
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

function StudentGrowthTaskView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function StudentGrowthTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStuTaskFloorCloseSignal)
end

function StudentGrowthTaskView:_onClickBtnReceive(taskId)
	TutorSystemController.instance:sendPM_TutorStudentGainGrowthTaskPrizeReq(taskId)
end

function StudentGrowthTaskView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function StudentGrowthTaskView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return StudentGrowthTaskView
