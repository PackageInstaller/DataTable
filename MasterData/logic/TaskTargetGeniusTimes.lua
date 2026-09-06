-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetGeniusTimes.lua

module("logic.extensions.task.model.target.TaskTargetGeniusTimes", package.seeall)

local TaskTargetGeniusTimes = class("TaskTargetGeniusTimes", TaskTargetBase)

function TaskTargetGeniusTimes:getTargetNum()
	return self.target.times
end

return TaskTargetGeniusTimes
