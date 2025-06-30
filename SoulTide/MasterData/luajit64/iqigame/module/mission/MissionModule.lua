-- chunkname: @IQIGame\\Module\\Mission\\MissionModule.lua

MissionModule = {}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function MissionModule.GetNormalShowTaskDatum(childType)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NORMAL_TASK, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.NORMAL_TASK, {
		childType
	})
	local shows = {}
	local processingDic = {}

	for i, taskData in pairs(processing) do
		local cfgData = CfgMainQuestTable[taskData.cid]

		if cfgData.DefaultDisplay == 1 and (not cfgData.AcceptIsHide or taskData.finNum >= taskData.tgtNum) then
			shows[#shows + 1] = taskData
		end

		processingDic[taskData.cid] = taskData
	end

	for i, v in pairs(finished) do
		local cfgData = CfgMainQuestTable[v]

		if cfgData.DefaultDisplay == 1 then
			local nextTaskCid = MissionModule.GetNextUnlockTask(cfgData.UnLockDisplay, processingDic)

			if nextTaskCid ~= 0 then
				local nextTaskData = processingDic[nextTaskCid]

				if nextTaskData ~= nil then
					local nextTaskCfgData = CfgMainQuestTable[nextTaskData.cid]

					if not nextTaskCfgData.AcceptIsHide or nextTaskData.finNum >= nextTaskData.tgtNum then
						shows[#shows + 1] = nextTaskData
					end
				end
			end
		end
	end

	table.sort(shows, function(element1, element2)
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

	for i = 1, #shows do
		local taskData = shows[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	local temp = {}

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]

		if cfgTaskData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
			local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(temp, uiTaskData)
		end
	end

	table.sort(temp, function(a, b)
		if a.cid < b.cid then
			return true
		else
			return false
		end
	end)

	for i, v in ipairs(temp) do
		table.insert(ret, v)
	end

	return ret
end

function MissionModule.GetAllNormalCanGetRewardTaskCids(childType)
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NORMAL_TASK, {
		childType
	})
	local ret = {}

	for i, v in pairs(processing) do
		if v.finNum >= v.tgtNum then
			ret[#ret + 1] = v.cid
		end
	end

	return ret
end

function MissionModule.GetSpecialTaskDatum(type, childType)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(type, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(type, {
		childType
	})

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
		local cfgMainQuestData = CfgMainQuestTable[taskData.cid]

		if not cfgMainQuestData.AcceptIsHide or taskData.finNum >= taskData.tgtNum then
			local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

			table.insert(ret, uiTaskData)
		end
	end

	local temp = {}

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(temp, uiTaskData)
	end

	table.sort(temp, function(a, b)
		if a.cid < b.cid then
			return true
		else
			return false
		end
	end)

	for i, v in ipairs(temp) do
		table.insert(ret, v)
	end

	return ret
end

function MissionModule.GetNextUnlockTask(UnLockDisplay, processingDic)
	local ret

	if UnLockDisplay ~= 0 then
		if processingDic[UnLockDisplay] ~= nil then
			ret = UnLockDisplay
		else
			local cfgData = CfgMainQuestTable[UnLockDisplay]

			if cfgData.UnLockDisplay ~= 0 then
				ret = MissionModule.GetNextUnlockTask(cfgData.UnLockDisplay, processingDic)
			end
		end
	end

	if ret == nil then
		ret = UnLockDisplay
	end

	return ret
end

function MissionModule.CheckRedPointOnNormalTask()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAIN_TASK) == false then
		return false
	end

	local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.NORMAL_TASK)

	for i, v in pairs(tasks) do
		if v.finNum >= v.tgtNum then
			return true
		end
	end

	return false
end

function MissionModule.CheckRedPointOnActive()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.DAILY_ACTIVE) == false then
		return false
	end

	local boxTaskDatum = MissionModule.GetSpecialTaskDatum(TaskModule.TaskType.ACTIVE_TASK, 2)
	local maxScore = 0

	for i, v in pairs(boxTaskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end

		if maxScore < v.TargetNum then
			maxScore = v.TargetNum
		end
	end

	local taskDatum = MissionModule.GetSpecialTaskDatum(TaskModule.TaskType.ACTIVE_TASK, 1)
	local curScore = 0

	for i, v in pairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
			local cfgData = CfgMainQuestTable[v.cid]

			for m, n in ipairs(cfgData.Reward) do
				if m % 2 ~= 0 and n == 102 then
					curScore = curScore + cfgData.Reward[m + 1]
				end
			end
		end
	end

	if curScore < maxScore then
		local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.ACTIVE_TASK)

		for i, v in pairs(tasks) do
			if v.finNum >= v.tgtNum then
				return true
			end
		end
	end

	return false
end

function MissionModule.CheckRedPointOnWeekActive()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.WEEK_ACTIVE) == false then
		return false
	end

	local boxTaskDatum = MissionModule.GetSpecialTaskDatum(TaskModule.TaskType.WEEK_ACTIVE_TASK, 2)
	local maxScore = 0

	for i, v in pairs(boxTaskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end

		if maxScore < v.TargetNum then
			maxScore = v.TargetNum
		end
	end

	local taskDatum = MissionModule.GetSpecialTaskDatum(TaskModule.TaskType.WEEK_ACTIVE_TASK, 1)
	local curScore = 0

	for i, v in pairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
			local cfgData = CfgMainQuestTable[v.cid]

			for m, n in ipairs(cfgData.Reward) do
				if m % 2 ~= 0 and n == 114 then
					curScore = curScore + cfgData.Reward[m + 1]
				end
			end
		end
	end

	if curScore < maxScore then
		local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.WEEK_ACTIVE_TASK)

		for i, v in pairs(tasks) do
			if v.finNum >= v.tgtNum then
				return true
			end
		end
	end

	return false
end
