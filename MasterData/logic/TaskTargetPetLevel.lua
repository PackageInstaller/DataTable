-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetPetLevel.lua

module("logic.extensions.task.model.target.TaskTargetPetLevel", package.seeall)

local TaskTargetPetLevel = class("TaskTargetPetLevel", TaskTargetBase)

function TaskTargetPetLevel:getTargetNum()
	return self.target.levelTimes
end

return TaskTargetPetLevel
