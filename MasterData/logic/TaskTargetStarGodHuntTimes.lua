-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetStarGodHuntTimes.lua

module("logic.extensions.task.model.target.TaskTargetStarGodHuntTimes", package.seeall)

local TaskTargetStarGodHuntTimes = class("TaskTargetStarGodHuntTimes", TaskTargetBase)

function TaskTargetStarGodHuntTimes:getTargetNum()
	return self.target.times
end

return TaskTargetStarGodHuntTimes
