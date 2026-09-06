-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetStarGodLevel.lua

module("logic.extensions.task.model.target.TaskTargetStarGodLevel", package.seeall)

local TaskTargetStarGodLevel = class("TaskTargetStarGodLevel", TaskTargetBase)

function TaskTargetStarGodLevel:getTargetNum()
	return self.target.times
end

return TaskTargetStarGodLevel
