-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetPetGenius.lua

module("logic.extensions.task.model.target.TaskTargetPetGenius", package.seeall)

local TaskTargetPetGenius = class("TaskTargetPetGenius", TaskTargetBase)

function TaskTargetPetGenius:getTargetNum()
	return self.target.geniusLevel
end

return TaskTargetPetGenius
