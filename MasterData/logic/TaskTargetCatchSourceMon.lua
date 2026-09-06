-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetCatchSourceMon.lua

module("logic.extensions.task.model.target.TaskTargetCatchSourceMon", package.seeall)

local TaskTargetCatchSourceMon = class("TaskTargetCatchSourceMon", TaskTargetBase)

function TaskTargetCatchSourceMon:getTargetNum()
	return self.target.catchTimes
end

return TaskTargetCatchSourceMon
