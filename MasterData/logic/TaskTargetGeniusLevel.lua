-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetGeniusLevel.lua

module("logic.extensions.task.model.target.TaskTargetGeniusLevel", package.seeall)

local TaskTargetGeniusLevel = class("TaskTargetGeniusLevel", TaskTargetBase)

function TaskTargetGeniusLevel:getTargetNum()
	return self.target.levelTimes
end

return TaskTargetGeniusLevel
