-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/CorvusTaskView.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.CorvusTaskView", package.seeall)

local CorvusTaskView = class("CorvusTaskView", BaseView)

function CorvusTaskView:onOpen()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refresh, self)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, self._refresh, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
	self:onUpdateParam()
end

function CorvusTaskView:onUpdateParam()
	local c = self.viewContainer

	c:sendGetTaskInfoRequest(self._refresh, self)
end

function CorvusTaskView:onClose()
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self._refresh, self)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, self._refresh, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
end

function CorvusTaskView:_setTaskList()
	local c = self.viewContainer

	c:scrollModel():setTaskListWithGetAll(c:taskType(), c:actId())
end

function CorvusTaskView:_refresh()
	self:_setTaskList()
end

function CorvusTaskView:_onUpdateTaskList(msg)
	if not msg then
		return
	end

	local taskInfo = msg.taskInfo
	local taskType = self:taskType()

	for _, v in ipairs(taskInfo or {}) do
		if v.type == taskType then
			self:_refresh()

			break
		end
	end
end

function CorvusTaskView:_onFinishTask()
	self:_refresh()
end

function CorvusTaskView:taskType()
	return self.viewContainer:taskType()
end

function CorvusTaskView:actId()
	return self.viewContainer:actId()
end

function CorvusTaskView:getActivityRemainTimeStr()
	return self.viewContainer:getActivityRemainTimeStr()
end

return CorvusTaskView
