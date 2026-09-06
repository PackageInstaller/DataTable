-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/StuGrowthTaskScheduleView.lua

module("logic.extensions.tutorsystem.view.teachertask.StuGrowthTaskScheduleView", package.seeall)

local StuGrowthTaskScheduleView = class("StuGrowthTaskScheduleView", ViewComponent)

function StuGrowthTaskScheduleView:ctor()
	StuGrowthTaskScheduleView.super.ctor(self)
end

function StuGrowthTaskScheduleView:buildUI()
	StuGrowthTaskScheduleView.super.buildUI(self)

	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "taskCol/itemScrollercell")
	self._empty = goutil.findChild(self.mainGO, "taskCol/empty")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function StuGrowthTaskScheduleView:bindEvents()
	StuGrowthTaskScheduleView.super.bindEvents(self)
end

function StuGrowthTaskScheduleView:unbindEvents()
	StuGrowthTaskScheduleView.super.unbindEvents(self)
end

function StuGrowthTaskScheduleView:onEnter()
	StuGrowthTaskScheduleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._userId = params[1]

	if self._userId == nil then
		FloatWordMgr.instance:show("缺失传入参数:userId")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.TutorGainGrowthTaskInfo, self._onUpdate, self)
	TutorSystemController.instance:sendTutorTeacherGainStudentGrowthTaskInfoReq(self._userId)
end

function StuGrowthTaskScheduleView:onExit()
	StuGrowthTaskScheduleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorGainGrowthTaskInfo, self._onUpdate, self)
	self._taskScrollList:dispose()
end

function StuGrowthTaskScheduleView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StuGrowthTaskScheduleView:_onUpdateData()
	self:_onUpdateTaskData()
end

function StuGrowthTaskScheduleView:_onUpdateUI()
	self:_updateTaskScrollerList()
	self:_onUpdatePlaneUI()
end

function StuGrowthTaskScheduleView:_onUpdatePlaneUI()
	return
end

function StuGrowthTaskScheduleView:_onUpdateTaskData()
	self._taskDataList = {}

	local dataList = {}
	local growthTaskIdList = TutorSystemModel.instance:getPublishedGrowthTaskIdList(self._userId)

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

function StuGrowthTaskScheduleView:_calcPrizeState(taskId)
	local isHasGain = TutorSystemController.instance:isHasGainPrizeAsGrowthTask(self._userId, taskId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = TutorSystemController.instance:isEnouthGetPrizeAsGrowthTask(self._userId, taskId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function StuGrowthTaskScheduleView:_updateTaskScrollerList()
	self._taskScrollList:reloadData(self._taskDataList)
	GameUtil.SetActive(self._empty, #self._taskDataList <= 0)
end

function StuGrowthTaskScheduleView:_updateTaskCell(view, cell, cfg, tag)
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
		GameUtil.SetActive(btnReceive, false)
		GameUtil.SetActive(btnGoto, false)
		GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	end
end

function StuGrowthTaskScheduleView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function StuGrowthTaskScheduleView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function StuGrowthTaskScheduleView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return StuGrowthTaskScheduleView
