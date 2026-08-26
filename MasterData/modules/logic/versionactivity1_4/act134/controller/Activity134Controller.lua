-- chunkname: @modules/logic/versionactivity1_4/act134/controller/Activity134Controller.lua

module("modules.logic.versionactivity1_4.act134.controller.Activity134Controller", package.seeall)

local Activity134Controller = class("Activity134Controller", BaseController)

function Activity134Controller:onInit()
	return
end

function Activity134Controller:onInitFinish()
	return
end

function Activity134Controller:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, self._onDeleteTaskList, self)
end

function Activity134Controller:_onUpdateTaskList(msg)
	local hasChange = Activity134Model.instance:setTasksInfo(msg.taskInfo)

	if hasChange then
		Activity134Controller.instance:dispatchEvent(Activity134Event.OnTaskUpdate)
		Activity134Controller.instance:dispatchEvent(Activity134Event.OnRedDotUpdate)
	end
end

function Activity134Controller:_onDeleteTaskList(msg)
	local hasChange = Activity134Model.instance:deleteInfo(msg.taskIds)

	if hasChange then
		Activity134Controller.instance:dispatchEvent(Activity134Event.OnTaskUpdate)
		Activity134Controller.instance:dispatchEvent(Activity134Event.OnRedDotUpdate)
	end
end

function Activity134Controller:openActivity134MainView(actId)
	Activity134Rpc.instance:sendGet134InfosRequest(actId, function()
		ViewMgr.instance:openView(ViewName.Activity134View, {
			activityId = actId
		})
	end)
end

function Activity134Controller:openActivity134TaskView()
	ViewMgr.instance:openView(ViewName.Activity134TaskView)
end

function Activity134Controller:reInit()
	return
end

Activity134Controller.instance = Activity134Controller.New()

return Activity134Controller
