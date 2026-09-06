-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetSanXiao.lua

module("logic.extensions.task.model.target.TaskTargetSanXiao", package.seeall)

local TaskTargetSanXiao = class("TaskTargetSanXiao", TaskTargetBase)

function TaskTargetSanXiao:getTargetNum()
	return self.target.times
end

return TaskTargetSanXiao
