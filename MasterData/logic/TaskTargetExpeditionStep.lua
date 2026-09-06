-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetExpeditionStep.lua

module("logic.extensions.task.model.target.TaskTargetExpeditionStep", package.seeall)

local TaskTargetExpeditionStep = class("TaskTargetExpeditionStep", TaskTargetBase)

function TaskTargetExpeditionStep:getTargetNum()
	return self.target.times
end

return TaskTargetExpeditionStep
