-- chunkname: @IQIGame\\Module\\Active\\ActivityDollMissionModule.lua

ActivityDollMissionModule = {}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function ActivityDollMissionModule.GetTaskDatum()
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DOLL_TASK)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.DOLL_TASK)

	table.sort(processing, function(element1, element2)
		local task1OK = element1.finNum >= element1.tgtNum
		local task2OK = element2.finNum >= element2.tgtNum

		if task1OK and not task2OK then
			return true
		elseif not task1OK and task2OK then
			return false
		elseif element1.cid < element2.cid then
			return true
		else
			return false
		end
	end)

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	local filteredFinished = {}

	for i, v in ipairs(finished) do
		local cfgTaskData = CfgMainQuestTable[v]

		if cfgTaskData.FinishIsShow == 1 then
			filteredFinished[#filteredFinished + 1] = v
		end
	end

	for i = 1, #filteredFinished do
		local taskCid = filteredFinished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(ret, uiTaskData)
	end

	return ret
end

function ActivityDollMissionModule.CheckRedPoint()
	local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.DOLL_TASK)

	for i, v in pairs(tasks) do
		if v.finNum >= v.tgtNum then
			return true
		end
	end

	return false
end
