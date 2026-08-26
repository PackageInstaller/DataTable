-- chunkname: @modules/logic/versionactivity1_4/act133/controller/Activity133Controller.lua

module("modules.logic.versionactivity1_4.act133.controller.Activity133Controller", package.seeall)

local Activity133Controller = class("Activity133Controller", BaseController)

function Activity133Controller:onInit()
	return
end

function Activity133Controller:onInitFinish()
	return
end

function Activity133Controller:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, self._onDeleteTaskList, self)
end

function Activity133Controller:_onUpdateTaskList(msg)
	local hasChange = Activity133Model.instance:setTasksInfo(msg.taskInfo)

	if hasChange then
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnTaskUpdate)
	end
end

function Activity133Controller:_onDeleteTaskList(msg)
	local hasChange = Activity133Model.instance:deleteInfo(msg.taskIds)

	if hasChange then
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnTaskUpdate)
	end
end

function Activity133Controller:openActivity133MainView(actId)
	Activity133Rpc.instance:sendGet133InfosRequest(actId, function()
		ViewMgr.instance:openView(ViewName.Activity133View, {
			actId = actId
		})
	end)
end

function Activity133Controller:openActivity133TaskView(actId)
	ViewMgr.instance:openView(ViewName.Activity133TaskView, {
		actId = actId
	})
end

function Activity133Controller:reInit()
	return
end

Activity133Controller.instance = Activity133Controller.New()

return Activity133Controller
