-- chunkname: @modules/logic/task/controller/TaskController.lua

module("modules.logic.task.controller.TaskController", package.seeall)

local TaskController = class("TaskController", BaseController)

function TaskController:onInit()
	return
end

function TaskController:onInitFinish()
	return
end

function TaskController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function TaskController:reInit()
	return
end

function TaskController:enterTaskView(taskType)
	ViewMgr.instance:openView(ViewName.TaskView, taskType)
end

function TaskController:enterTaskViewCheckUnlock()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		TaskController.instance:enterTaskView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Task))
	end
end

function TaskController:_onDailyRefresh()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Daily,
		TaskEnum.TaskType.Weekly,
		TaskEnum.TaskType.Novice
	})
end

function TaskController:getRewardByLine(getApproach, viewName, param)
	self._priority = self._priority or 10000
	self._priority = self._priority - 1

	PopupController.instance:addPopupView(self._priority, viewName, param)
end

TaskController.instance = TaskController.New()

return TaskController
