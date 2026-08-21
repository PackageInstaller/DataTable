-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\AdvanceTaskUtils.lua

local ResAdvanceTaskClient = require("ClientData/ResAdvanceTaskClient")
local ResAdvanceTask = require("ClientData/ResAdvanceTask")
local ResAdvanceStep = require("ClientData/ResAdvanceStep")
local ResAdvanceMisc = require("ClientData/ResAdvanceMisc")
local AdvanceTaskUtils = {}

function AdvanceTaskUtils.getGroupSvrData(groupId)
	if not CurAvatar.advanceTaskGroup or not CurAvatar.advanceTaskGroup[groupId] then
		return
	end

	return CurAvatar.advanceTaskGroup[groupId]
end

AdvanceTaskUtils.STEP_STATE = {
	SUPER_GOT = 4,
	COMPLETE = 2,
	NORMAL_GOT = 3,
	IN_PROCESS = 1
}

function AdvanceTaskUtils.getStepState(groupId, stepId)
	local groupInfo = AdvanceTaskUtils.getGroupSvrData(groupId)

	if groupInfo then
		if groupInfo.stepStatus[stepId] == Const.TASK_STATUS.IN_PROCESS then
			return AdvanceTaskUtils.STEP_STATE.IN_PROCESS
		elseif groupInfo.stepSuperGot[stepId] then
			return AdvanceTaskUtils.STEP_STATE.SUPER_GOT
		elseif groupInfo.stepNormalGot[stepId] then
			return AdvanceTaskUtils.STEP_STATE.NORMAL_GOT
		else
			return AdvanceTaskUtils.STEP_STATE.COMPLETE
		end
	end
end

function AdvanceTaskUtils.getStepsProcess(groupId)
	local groupInfo = AdvanceTaskUtils.getGroupSvrData(groupId)

	if groupInfo then
		return groupInfo.completeSetp, groupInfo.totalStep
	end
end

function AdvanceTaskUtils.getAdvanceTaskStatus(groupId, taskId)
	local groupInfo = AdvanceTaskUtils.getGroupSvrData(groupId)

	if groupInfo then
		return groupInfo.taskStates[taskId]
	end
end

function AdvanceTaskUtils.getAdvanceTaskProcess(groupId, taskId)
	if not ResAdvanceTask[groupId] or not ResAdvanceTask[groupId][taskId] then
		return
	end

	local achieveType = ResAdvanceTask[groupId][taskId].action_type
	local totalProcess = ResAdvanceTask[groupId][taskId].action_param
	local nowProcess = math.min(totalProcess, CurAvatar:getAchieveProcessByType(achieveType))
	local isQuality = totalProcess <= nowProcess

	if CurAvatar:_taskTypeNeedFix(achieveType) then
		totalProcess = 1
		nowProcess = isQuality and 1 or 0
	end

	return nowProcess, totalProcess
end

function AdvanceTaskUtils.getAdvanceGroupData(groupId)
	if not ResAdvanceTask[groupId] then
		return
	end

	return ResAdvanceTask[groupId]
end

function AdvanceTaskUtils.getAdvanceGroupClientData(groupId, taskId)
	if not ResAdvanceTaskClient[groupId] or not ResAdvanceTaskClient[groupId][taskId] then
		return
	end

	return ResAdvanceTaskClient[groupId][taskId]
end

function AdvanceTaskUtils.getAdvanceStepData(groupId)
	if not ResAdvanceStep[groupId] then
		return
	end

	return ResAdvanceStep[groupId]
end

function AdvanceTaskUtils.getAdvanceMiscData(groupId)
	if not ResAdvanceMisc[groupId] then
		return
	end

	return ResAdvanceMisc[groupId]
end

return AdvanceTaskUtils
