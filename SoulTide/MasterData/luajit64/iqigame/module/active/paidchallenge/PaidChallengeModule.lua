-- chunkname: @IQIGame\\Module\\Active\\PaidChallenge\\PaidChallengeModule.lua

PaidChallengeModule = {}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function PaidChallengeModule.Reload()
	PaidChallengeModule.isPaid = nil

	for i, v in pairsCfg(CfgOperateEventsControlTable) do
		if v.Type == Constant.Activity_Operation_Type.Activity_Paid_Challenge then
			local eventID = v.Id

			if not ActiveOperationEventModule.CheckIsOpen(eventID) then
				return
			end

			local pod = ActiveOperationEventModule.GetEventDataPOD(eventID)

			if pod ~= nil then
				PaidChallengeModule.isPaid = pod.paidQuestDataPOD.paid
			end
		end
	end
end

function PaidChallengeModule.Shutdown()
	return
end

function PaidChallengeModule.OnNotifyUpdate()
	PaidChallengeModule.Reload()
end

function PaidChallengeModule.GetTaskDatum(type, subType)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(type, {
		subType
	})
	local finished = TaskModule.GetTaskFinished(type, {
		subType
	})

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

function PaidChallengeModule.CheckRedPoint(viewID)
	local taskDatum = PaidChallengeModule.GetTaskDatum(TaskModule.TaskType.PAID_CHALLENGE_TASK, 1)

	for i, v in pairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end
	end

	return false
end
