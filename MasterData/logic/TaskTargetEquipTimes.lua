-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetEquipTimes.lua

module("logic.extensions.task.model.target.TaskTargetEquipTimes", package.seeall)

local TaskTargetEquipTimes = class("TaskTargetEquipTimes", TaskTargetBase)

function TaskTargetEquipTimes:getTargetNum()
	return self.target.times
end

return TaskTargetEquipTimes
