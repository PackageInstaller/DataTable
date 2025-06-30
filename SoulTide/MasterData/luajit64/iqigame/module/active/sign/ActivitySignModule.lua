-- chunkname: @IQIGame\\Module\\Active\\Sign\\ActivitySignModule.lua

ActivitySignModule = {}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function ActivitySignModule.GetTaskDatum()
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.ACTIVITY_SIGN)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.ACTIVITY_SIGN)

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(ret, uiTaskData)
	end

	table.sort(ret, function(a, b)
		return a.cid < b.cid
	end)

	return ret
end

function ActivitySignModule.CheckRedPoint(viewID)
	if not ActiveOperationEventModule.CheckIsOpen(viewID) then
		return false
	end

	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(viewID)

	if not operationEventDataPOD then
		return false
	end

	local taskDatum = ActivitySignModule.GetTaskDatum()

	for i, v in pairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end
	end

	return false
end

function ActivitySignModule.CheckRedPointByType()
	for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
		local cfg = CfgOperateEventsControlTable[v.eventCfgId]

		if cfg.Type == Constant.Activity_Operation_Type.Activity_Sign and ActivitySignModule.CheckRedPoint(v.eventCfgId) then
			return true
		end
	end

	return false
end

function ActivitySignModule.GetReward(taskCid)
	TaskModule.SendCommitTaskMsg(taskCid)
end
