-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/task/TaskFactory.lua

module("logic.extensions.task.model.task.TaskFactory", package.seeall)

TaskFactory = {}

function TaskFactory.createTask(id)
	local taskCo = TaskConfig.instance:getTaskCo(id)

	if taskCo then
		return TaskBase.New(taskCo)
	end
end

return TaskFactory
