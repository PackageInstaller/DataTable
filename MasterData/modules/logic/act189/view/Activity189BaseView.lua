-- chunkname: @modules/logic/act189/view/Activity189BaseView.lua

module("modules.logic.act189.view.Activity189BaseView", package.seeall)

local Activity189BaseView = class("Activity189BaseView", BaseView)

function Activity189BaseView:onOpen()
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, self._refresh, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
	self:onUpdateParam()
end

function Activity189BaseView:onUpdateParam()
	Activity189Controller.instance:sendGetTaskInfoRequest(self._refresh, self)
end

function Activity189BaseView:onClose()
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, self._refresh, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishTask, self)
end

function Activity189BaseView:_refresh()
	Activity189_TaskListModel.instance:setTaskList(self:actId())
end

function Activity189BaseView:_getTaskType()
	return Activity189Config.instance:getTaskType()
end

function Activity189BaseView:_onUpdateTaskList(msg)
	if not msg then
		return
	end

	local taskInfo = msg.taskInfo
	local taskType = self:_getTaskType()

	for _, v in ipairs(taskInfo or {}) do
		if v.type == taskType then
			self:_refresh()

			break
		end
	end
end

function Activity189BaseView:_onFinishTask()
	self:_refresh()
	Activity189Controller.dispatchEventUpdateActTag(self:actId())
end

function Activity189BaseView:getRemainTimeStr()
	local remainTimeSec = Activity189Model.instance:getRemainTimeSec(self:actId())

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function Activity189BaseView:actId()
	return self.viewContainer:actId()
end

return Activity189BaseView
