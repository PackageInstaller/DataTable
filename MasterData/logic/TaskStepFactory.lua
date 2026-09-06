-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/step/TaskStepFactory.lua

module("logic.extensions.task.model.task.TaskStepFactory", package.seeall)

TaskStepFactory = {}

function TaskStepFactory.createTaskStep(id, task)
	if not id or id == 0 then
		return
	end

	local taskId = task:getTaskId()
	local taskStepCo = TaskConfig.instance:getStepCo(taskId, id)

	if taskStepCo then
		return TaskStepBase.New(taskStepCo, task)
	end
end

return TaskStepFactory
