-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetJJC.lua

module("logic.extensions.task.model.target.TaskTargetJJC", package.seeall)

local TaskTargetJJC = class("TaskTargetJJC", TaskTargetBase)

function TaskTargetJJC:getTargetNum()
	return self.target.times
end

return TaskTargetJJC
