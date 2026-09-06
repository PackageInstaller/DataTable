-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetDailyActivity.lua

module("logic.extensions.task.model.target.TaskTargetDailyActivity", package.seeall)

local TaskTargetDailyActivity = class("TaskTargetDailyActivity", TaskTargetBase)

function TaskTargetDailyActivity:getTargetNum()
	if self.target then
		return self.target.number
	end

	return nil
end

function TaskTargetDailyActivity:getDesc()
	local instruction = TaskConfig.instance:getTaskInstruction(self.target.instruction)

	return instruction .. "（" .. self._toprogress .. "/" .. self:getTargetNum() .. "）"
end

return TaskTargetDailyActivity
