-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetHatchEgg.lua

module("logic.extensions.task.model.target.TaskTargetHatchEgg", package.seeall)

local TaskTargetHatchEgg = class("TaskTargetHatchEgg", TaskTargetBase)

function TaskTargetHatchEgg:getTargetNum()
	return self.target.hatchTimes
end

return TaskTargetHatchEgg
