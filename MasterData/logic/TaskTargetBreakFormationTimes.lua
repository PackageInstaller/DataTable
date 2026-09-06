-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetBreakFormationTimes.lua

module("logic.extensions.task.model.target.TaskTargetBreakFormationTimes", package.seeall)

local TaskTargetBreakFormationTimes = class("TaskTargetBreakFormationTimes", TaskTargetBase)

function TaskTargetBreakFormationTimes:getTargetNum()
	return self.target.times
end

return TaskTargetBreakFormationTimes
