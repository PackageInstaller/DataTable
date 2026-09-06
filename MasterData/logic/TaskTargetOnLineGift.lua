-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetOnLineGift.lua

module("logic.extensions.task.model.target.TaskTargetOnLineGift", package.seeall)

local TaskTargetOnLineGift = class("TaskTargetOnLineGift", TaskTargetBase)

function TaskTargetOnLineGift:getTargetNum()
	return self.target.times
end

return TaskTargetOnLineGift
