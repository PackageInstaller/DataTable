-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/step/TaskComp.lua

module("logic.extensions.task.model.task.TaskComp", package.seeall)

local TaskComp = {}
local taskOrders = {
	[GameEnum.TaskType.Main] = 1,
	[GameEnum.TaskType.Festival] = 2,
	[GameEnum.TaskType.Guide] = 3,
	[GameEnum.TaskType.Branch] = 4,
	[GameEnum.TaskType.Daily] = 5,
	[GameEnum.TaskType.ColorfulEggs] = 6
}

function TaskComp.compSteps(first, second)
	if first == second then
		return false
	end

	local stateF = first:getState()
	local stateS = second:getState()

	if stateF ~= stateS then
		if stateF == TaskConst.TSTEP_S_COMPELETED then
			return true
		end

		if stateS == TaskConst.TSTEP_S_COMPELETED then
			return false
		end
	end

	local typeF = first.task:getTaskType()
	local typeS = second.task:getTaskType()

	typeF = taskOrders[typeF]
	typeS = taskOrders[typeS]

	if typeF < typeS then
		return true
	end

	if typeS < typeF then
		return false
	end

	return false
end

return TaskComp
