-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetStarGodQuality.lua

module("logic.extensions.task.model.target.TaskTargetStarGodQuality", package.seeall)

local TaskTargetStarGodQuality = class("TaskTargetStarGodQuality", TaskTargetBase)

function TaskTargetStarGodQuality:getTargetNum()
	return self.target.times
end

return TaskTargetStarGodQuality
