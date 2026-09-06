-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetXiaoNuoBuyTimes.lua

module("logic.extensions.task.model.target.TaskTargetXiaoNuoBuyTimes", package.seeall)

local TaskTargetXiaoNuoBuyTimes = class("TaskTargetXiaoNuoBuyTimes", TaskTargetBase)

function TaskTargetXiaoNuoBuyTimes:getTargetNum()
	return self.target.times
end

return TaskTargetXiaoNuoBuyTimes
