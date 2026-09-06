-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetAchievement.lua

module("logic.extensions.task.model.target.TaskTargetAchievement", package.seeall)

local TaskTargetAchievement = class("TaskTargetAchievement", TaskTargetBase)

function TaskTargetAchievement:getTargetNum()
	if self.target then
		return self.target.times
	end

	return nil
end

return TaskTargetAchievement
