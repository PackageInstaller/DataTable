-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetCollPets.lua

module("logic.extensions.task.model.target.TaskTargetCollPets", package.seeall)

local TaskTargetCollPets = class("TaskTargetCollPets", TaskTargetBase)

function TaskTargetCollPets:getTargetNum()
	if self.target then
		return self.target.petNumber
	end

	return nil
end

return TaskTargetCollPets
