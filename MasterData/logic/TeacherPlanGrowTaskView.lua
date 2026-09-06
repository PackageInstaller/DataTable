-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/TeacherPlanGrowTaskView.lua

module("logic.extensions.tutorsystem.view.teachertask.TeacherPlanGrowTaskView", package.seeall)

local TeacherPlanGrowTaskView = class("TeacherPlanGrowTaskView", ViewComponent)

function TeacherPlanGrowTaskView:ctor()
	TeacherPlanGrowTaskView.super.ctor(self)
end

function TeacherPlanGrowTaskView:buildUI()
	TeacherPlanGrowTaskView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnPublish = goutil.findChild(self.mainGO, "btnPublish")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._btnAutoSendTask = GameUtil.asBtn(goutil.findChild(self.mainGO, "autoSendTask/imgSelectFrame"))
	self._autoSendTaskGo = goutil.findChild(self.mainGO, "autoSendTask/imgSelect")
end

function TeacherPlanGrowTaskView:bindEvents()
	TeacherPlanGrowTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPublish, self._onClickBtnPublish, self)
	GameUtil.addClickHandler(self._btnAutoSendTask, self._onClickAutoSend, self)
end

function TeacherPlanGrowTaskView:unbindEvents()
	TeacherPlanGrowTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPublish)
	GameUtil.rmClickHandler(self._btnAutoSendTask)
end

function TeacherPlanGrowTaskView:destroyUI()
	TeacherPlanGrowTaskView.super.destroyUI(self)
end

function TeacherPlanGrowTaskView:onEnter()
	TeacherPlanGrowTaskView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._studentUserId = params[1]

	if checknumber(self._studentUserId) == 0 then
		FloatWordMgr.instance:show("学生userId为空")
		self:close()

		return
	end

	self:_resetTaskIdList()
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.TutorTeacherTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorTeacherSwitchAutoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorTeacherPublishGrowUpTaskRes, self._handlePublishGrowUpTaskRes, self)
	self:_onSendInfoReq()
end

function TeacherPlanGrowTaskView:onExit()
	TeacherPlanGrowTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorTeacherTaskInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorTeacherSwitchAutoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorTeacherPublishGrowUpTaskRes, self._handlePublishGrowUpTaskRes, self)
	self._taskScrollList:dispose()
end

function TeacherPlanGrowTaskView:_onSendInfoReq()
	TutorSystemController.instance:sendTutorTeacherTaskInfoReq(self._studentUserId)
end

function TeacherPlanGrowTaskView:_handlePublishGrowUpTaskRes()
	FloatWordMgr.instance:show("发布成功")
	self:_resetTaskIdList()
	self:_onSendInfoReq()
end

function TeacherPlanGrowTaskView:_onSetUI()
	return
end

function TeacherPlanGrowTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TeacherPlanGrowTaskView:_onUpdateData()
	local info = TutorSystemModel.instance:getGrowthTaskInfoInTeaPlanGrowTask(self._studentUserId)

	self._isAutoSendTask = info.autoPublishGrowUpTaskSwitch
end

function TeacherPlanGrowTaskView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_updateTaskScrollerList()
end

function TeacherPlanGrowTaskView:_onUpdatePlaneUI()
	local totalCanPublicTimes = TutorSystemConfig.instance:getTsWeeklyGrowthTaskNum()
	local totalHasPublicTimes = TutorSystemModel.instance:getPublishedTaskCountInTeaPlanGrowTask()
	local selectedTaskListLength = #self:_getSelectedTaskIdList()

	self._txtCount.text = string.format("每周：%d/%d", totalHasPublicTimes + selectedTaskListLength, totalCanPublicTimes)

	GameUtil.SetActive(self._autoSendTaskGo, self._isAutoSendTask)

	local totalTaskCount = #TutorSystemModel.instance:getRandomGrowthTaskIdListInTeaPlanGrowTask(self._studentUserId)
	local leftCanPlanTimes = TutorSystemController.instance:getLeftCanPlanTimesInTeaGrowthTask(self._studentUserId)

	GameUtil.SetActive(self._btnPublish, totalHasPublicTimes < totalTaskCount and leftCanPlanTimes > 0)
end

function TeacherPlanGrowTaskView:_getSelectedTaskIdCount()
	return #self._selectTaskIdList
end

function TeacherPlanGrowTaskView:_getSelectedTaskIdList()
	return self._selectTaskIdList
end

function TeacherPlanGrowTaskView:_addSelectTaskId(taskId)
	table.insert(self._selectTaskIdList, taskId)
end

function TeacherPlanGrowTaskView:_removeSelectTaskId(taskId)
	table.removebyvalue(self._selectTaskIdList, taskId)
end

function TeacherPlanGrowTaskView:_isSelectedOfTaskId(taskId)
	return table.indexof(self._selectTaskIdList, taskId) ~= false
end

function TeacherPlanGrowTaskView:_resetTaskIdList()
	self._selectTaskIdList = {}
end

function TeacherPlanGrowTaskView:_updateTaskScrollerList()
	local dataList = {}
	local taskIdList = TutorSystemModel.instance:getRandomGrowthTaskIdListInTeaPlanGrowTask(self._studentUserId)

	for _, taskId in ipairs(taskIdList) do
		local data = TutorSystemConfig.instance:getTsGrowthTaskData(taskId)

		table.insert(dataList, data)
	end

	self._taskScrollList:reloadData(dataList)
end

function TeacherPlanGrowTaskView:_updateTaskCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "iconGo")
	local imgSelectFrame = goutil.findChild(mainGo, "imgSelectFrame")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local tag = goutil.findChild(mainGo, "tag")
	local mask = goutil.findChild(mainGo, "mask")
	local txtTag = goutil.findChildTextComponent(mainGo, "tag/txtTag")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local isSelected = self:_isSelectedOfTaskId(data.taskId)
	local isHasPublished = TutorSystemModel.instance:isHasPublishedTaskInTeaPlanGrowTask(self._studentUserId, data.taskId)
	local isHasFinished = TutorSystemModel.instance:isHasFinishedTaskInTeaPlanGrowTask(self._studentUserId, data.taskId)
	local path = data.iconPath
	local bgGo = iconGo

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/bigbg/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	txtName.text = data.title
	txtDesc.text = data.desc

	if isHasFinished then
		txtTag.text = "已完成"
	elseif isHasPublished then
		txtTag.text = "已发布"
	end

	GameUtil.SetActive(imgSelect, isSelected)
	GameUtil.SetActive(tag, isHasPublished or isHasFinished)
	GameUtil.SetActive(mask, isHasFinished)
	GameUtil.SetActive(imgSelectFrame, not isHasPublished and not isHasFinished)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTaskCell, self, data))
end

function TeacherPlanGrowTaskView:_clearTaskCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "iconGo")

	uGuiUtil.clearImage(iconGo)
	GameUtil.rmClickHandler(mainGo)
end

function TeacherPlanGrowTaskView:_onClickTaskCell(data)
	local taskId = data.taskId

	if self:_isSelectedOfTaskId(taskId) then
		self:_removeSelectTaskId(taskId)
		self:_onUpdate()

		return
	end

	if TutorSystemModel.instance:isHasPublishedTaskInTeaPlanGrowTask(self._studentUserId, taskId) then
		return
	end

	if TutorSystemModel.instance:isHasFinishedTaskInTeaPlanGrowTask(self._studentUserId, taskId) then
		return
	end

	local taskIdCount = self:_getSelectedTaskIdCount()
	local totalCanPublicTimes = TutorSystemConfig.instance:getTsWeeklyGrowthTaskNum()
	local totalHasPublicTimes = TutorSystemModel.instance:getPublishedTaskCountInTeaPlanGrowTask(self._studentUserId)

	if totalCanPublicTimes <= taskIdCount + totalHasPublicTimes then
		FloatWordMgr.instance:show("选择发布的任务数量已达上限")

		return
	end

	self:_addSelectTaskId(taskId)
	self:_onUpdate()
end

function TeacherPlanGrowTaskView:_onClickBtnPublish()
	if TutorSystemController.instance:isExceedTotalPlanTimesInTeaGrowthTask(self._studentUserId) then
		FloatWordMgr.instance:show("已达到发布上限")

		return
	end

	local taskIdCount = self:_getSelectedTaskIdCount()
	local leftCanPlanTimes = TutorSystemController.instance:getLeftCanPlanTimesInTeaGrowthTask(self._studentUserId)

	if taskIdCount == 0 then
		FloatWordMgr.instance:show("还未选择发布的任务")

		return
	end

	if leftCanPlanTimes < taskIdCount then
		FloatWordMgr.instance:show("选择发布的任务数量超过发布上限")

		return
	end

	local taskIdList = self:_getSelectedTaskIdList()

	TutorSystemController.instance:sendTutorTeacherPublishGrowUpTaskReq(self._studentUserId, taskIdList)
end

function TeacherPlanGrowTaskView:_onClickAutoSend()
	TutorSystemAgent.instance:sendPM_TutorTeacherSwitchAutoPublishGrowUpTaskReq(not self._isAutoSendTask)
end

return TeacherPlanGrowTaskView
