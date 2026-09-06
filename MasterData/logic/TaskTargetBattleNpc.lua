-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetBattleNpc.lua

module("logic.extensions.task.model.target.TaskTargetBattleNpc", package.seeall)

local TaskTargetBattleNpc = class("TaskTargetBattleNpc", TaskTargetBase)

function TaskTargetBattleNpc:getTargetNum()
	if self.target then
		return self.target.monsterTimes
	end

	return nil
end

return TaskTargetBattleNpc
