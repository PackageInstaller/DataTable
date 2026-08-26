-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_TaskView.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskView", package.seeall)

local V2a4_WarmUp_TaskView = class("V2a4_WarmUp_TaskView", BaseView)

function V2a4_WarmUp_TaskView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_TaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V2a4_WarmUp_TaskView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V2a4_WarmUp_TaskView:_btncloseOnClick()
	self:closeThis()
end

function V2a4_WarmUp_TaskView:_editableInitView()
	return
end

function V2a4_WarmUp_TaskView:onUpdateParam()
	Activity125Controller.instance:sendGetTaskInfoRequest(self._fallbackCheckIsFinishedReadTasks, self)
end

function V2a4_WarmUp_TaskView:onOpen()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refresh, self)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, self._refresh, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._refresh, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
	self:onUpdateParam()
end

function V2a4_WarmUp_TaskView:onClose()
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self._refresh, self)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, self._refresh, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._refresh, self)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
end

function V2a4_WarmUp_TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

function V2a4_WarmUp_TaskView:_refresh()
	V2a4_WarmUp_TaskListModel.instance:setTaskList()
end

function V2a4_WarmUp_TaskView:_onFinishTask()
	self:_refresh()
	V2a4_WarmUpController.instance:dispatchEventUpdateActTag()
end

function V2a4_WarmUp_TaskView:_fallbackCheckIsFinishedReadTasks(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	local actId = self.viewContainer:actId()
	local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity125, actId)

	if not taskMoList or #taskMoList == 0 then
		return
	end

	local sum_help_npc = Activity125Config.instance:getTaskCO_ReadTask_Tag(actId, ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc)
	local refList = {}

	for _, taskMo in ipairs(taskMoList) do
		local CO = taskMo.config
		local taskType = taskMo.type
		local taskId = taskMo.id
		local has = taskMo.progress

		if sum_help_npc[taskId] and not taskMo.hasFinished then
			has = Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)

			local clientlistenerParam = CO.clientlistenerParam
			local need = tonumber(clientlistenerParam) or has + 1

			V2a4_WarmUpController.instance:appendCompleteTask(refList, taskType, taskId, has, need)
		end
	end

	if #refList > 0 then
		V2a4_WarmUpController.instance:sendFinishReadTaskRequest(refList)
	end
end

return V2a4_WarmUp_TaskView
