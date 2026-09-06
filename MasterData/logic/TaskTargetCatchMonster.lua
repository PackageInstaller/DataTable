-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetCatchMonster.lua

module("logic.extensions.task.model.target.TaskTargetCatchMonster", package.seeall)

local TaskTargetCatchMonster = class("TaskTargetCatchMonster", TaskTargetBase)

function TaskTargetCatchMonster:getTargetNum()
	return self.target.catchTimes
end

return TaskTargetCatchMonster
