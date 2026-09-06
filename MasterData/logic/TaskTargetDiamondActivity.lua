-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetDiamondActivity.lua

module("logic.extensions.task.model.target.TaskTargetDiamondActivity", package.seeall)

local TaskTargetDiamondActivity = class("TaskTargetDiamondActivity", TaskTargetBase)

function TaskTargetDiamondActivity:getTargetNum()
	return self.target.times
end

return TaskTargetDiamondActivity
