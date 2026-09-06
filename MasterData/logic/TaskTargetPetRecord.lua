-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetPetRecord.lua

module("logic.extensions.task.model.target.TaskTargetPetRecord", package.seeall)

local TaskTargetPetRecord = class("TaskTargetPetRecord", TaskTargetBase)

function TaskTargetPetRecord:getTargetNum()
	return self.target.petNumber
end

return TaskTargetPetRecord
