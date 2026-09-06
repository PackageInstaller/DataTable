-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetStarGodEquipTimes.lua

module("logic.extensions.task.model.target.TaskTargetStarGodEquipTimes", package.seeall)

local TaskTargetStarGodEquipTimes = class("TaskTargetStarGodEquipTimes", TaskTargetBase)

function TaskTargetStarGodEquipTimes:getTargetNum()
	return self.target.times
end

return TaskTargetStarGodEquipTimes
