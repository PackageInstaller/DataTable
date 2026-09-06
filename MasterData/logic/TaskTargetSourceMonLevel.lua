-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetSourceMonLevel.lua

module("logic.extensions.task.model.target.TaskTargetSourceMonLevel", package.seeall)

local TaskTargetSourceMonLevel = class("TaskTargetSourceMonLevel", TaskTargetBase)

function TaskTargetSourceMonLevel:getTargetNum()
	return self.target.times
end

return TaskTargetSourceMonLevel
