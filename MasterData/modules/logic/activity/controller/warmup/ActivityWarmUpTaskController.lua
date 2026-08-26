-- chunkname: @modules/logic/activity/controller/warmup/ActivityWarmUpTaskController.lua

module("modules.logic.activity.controller.warmup.ActivityWarmUpTaskController", package.seeall)

local ActivityWarmUpTaskController = class("ActivityWarmUpTaskController", BaseController)

function ActivityWarmUpTaskController:onInit()
	return
end

function ActivityWarmUpTaskController:reInit()
	return
end

function ActivityWarmUpTaskController:init(actId, selectedDay)
	self._actId = actId

	ActivityWarmUpTaskListModel.instance:setSelectedDay(selectedDay or 1)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.updateDatas, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.updateDatas, self)
end

function ActivityWarmUpTaskController:release()
	self._actId = nil

	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self.updateDatas, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self.updateDatas, self)
	ActivityWarmUpTaskListModel.instance:release()
end

function ActivityWarmUpTaskController:updateDatas()
	if not self._actId then
		logNormal("no actId enable!")

		return
	end

	ActivityWarmUpTaskListModel.instance:init(self._actId)
	ActivityWarmUpTaskListModel.instance:updateDayList()
	self:dispatchEvent(ActivityWarmUpEvent.TaskListUpdated)
	self:dispatchEvent(ActivityWarmUpEvent.TaskListInit)
end

function ActivityWarmUpTaskController:changeSelectedDay(day)
	ActivityWarmUpTaskListModel.instance:setSelectedDay(day)
	ActivityWarmUpTaskListModel.instance:updateDayList()
	self:dispatchEvent(ActivityWarmUpEvent.TaskDayChanged)
end

ActivityWarmUpTaskController.instance = ActivityWarmUpTaskController.New()

LuaEventSystem.addEventMechanism(ActivityWarmUpTaskController.instance)

return ActivityWarmUpTaskController
