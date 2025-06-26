-- chunkname: @IQIGame\\Module\\Active\\ActiveModule.lua

ActiveModule = {}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function ActiveModule.Reload()
	ActiveModule.moonStartTime = cfgDateTimeToTimeStamp(ActivityUIApi:GetString("moodStartDate"), PlayerModule.TimeZone)
	ActiveModule.moonEndTime = cfgDateTimeToTimeStamp(ActivityUIApi:GetString("moodEndDate"), PlayerModule.TimeZone)
	ActiveModule.nationalDayStartTime = cfgDateTimeToTimeStamp(ActivityUIApi:GetString("nationalDayStartDate"), PlayerModule.TimeZone)
	ActiveModule.nationalDayEndTime = cfgDateTimeToTimeStamp(ActivityUIApi:GetString("nationalDayEndDate"), PlayerModule.TimeZone)
end

function ActiveModule.GetSignInTaskDatum()
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.ROOKIE_TASK, {
		1
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.ROOKIE_TASK, {
		1
	})
	local tempList = {}

	for i, v in pairs(processing) do
		local data = TaskUIData.New(v.cid, v.finNum, v.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, v.createTime)

		tempList[#tempList + 1] = data
	end

	for i, v in pairs(finished) do
		local cfgTaskData = CfgMainQuestTable[v]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local data = TaskUIData.New(v, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		tempList[#tempList + 1] = data
	end

	table.sort(tempList, function(a, b)
		return a.cid < b.cid
	end)

	return tempList
end

function ActiveModule.GetRookieTaskDatum(type, childType)
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
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
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

function ActiveModule.GetFirstRechargeTaskData()
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.FIRST_RECHARGE_TASK)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.FIRST_RECHARGE_TASK)
	local tempList = {}

	for i, v in pairs(processing) do
		local data = TaskUIData.New(v.cid, v.finNum, v.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, v.createTime)

		tempList[#tempList + 1] = data
	end

	for i, v in pairs(finished) do
		local cfgTaskData = CfgMainQuestTable[v]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local data = TaskUIData.New(v, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		tempList[#tempList + 1] = data
	end

	if #tempList == 0 then
		for i, v in pairsCfg(CfgMainQuestTable) do
			if v.Type == TaskModule.TaskType.FIRST_RECHARGE_TASK then
				local cfgTaskData = v
				local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
				local data = TaskUIData.New(cfgTaskData.Id, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

				tempList[#tempList + 1] = data
			end
		end
	end

	return tempList[1]
end

function ActiveModule.CheckRedPointOnFirstRecharge()
	local rechargeTask = ActiveModule.GetFirstRechargeTaskData()

	if rechargeTask.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and rechargeTask.CurrentNum >= rechargeTask.TargetNum then
		return true
	end

	return false
end

function ActiveModule.CheckRedPointOnActiveRookie()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.ACTIVE_ROOKIE) == false then
		return false
	end

	local subTypeMax = 0

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.ROOKIE_TASK and subTypeMax < v.TypeParam[1] then
			subTypeMax = v.TypeParam[1]
		end
	end

	for i = 1, subTypeMax do
		local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.ROOKIE_TASK, {
			i
		})

		for i, v in pairs(tasks) do
			if v.finNum >= v.tgtNum then
				return true
			end
		end
	end

	return false
end

function ActiveModule.CheckRedPointOnActiveRookieTask(subType)
	local tasks = TaskModule.GetTaskProcessing(TaskModule.TaskType.ROOKIE_TASK, {
		subType
	})

	for i, v in pairs(tasks) do
		if v.finNum >= v.tgtNum then
			return true
		end
	end

	return false
end

function ActiveModule.CheckExistRookieTask()
	local subTypeMax = 0

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.ROOKIE_TASK and subTypeMax < v.TypeParam[1] then
			subTypeMax = v.TypeParam[1]
		end
	end

	for i = 1, subTypeMax do
		if #TaskModule.GetTaskProcessing(TaskModule.TaskType.ROOKIE_TASK, {
			i
		}) > 0 then
			return true
		end
	end

	return false
end

function ActiveModule.GetMoonTaskDatum()
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.MOON_TASK, {
		1
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.MOON_TASK, {
		1
	})
	local serverTime = PlayerModule.GetServerTime()
	local tempList = {}

	for i, v in pairs(processing) do
		local cfgData = CfgMainQuestTable[v.cid]
		local startTime = cfgDateTimeToTimeStamp(cfgData.StartTime, PlayerModule.TimeZone)
		local endTime = cfgDateTimeToTimeStamp(cfgData.EndTime, PlayerModule.TimeZone)
		local finNum = v.finNum

		if serverTime < startTime or endTime < serverTime then
			finNum = 0
		end

		local data = TaskUIData.New(v.cid, finNum, v.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, v.createTime)

		tempList[#tempList + 1] = data
	end

	for i, v in pairs(finished) do
		local cfgTaskData = CfgMainQuestTable[v]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local data = TaskUIData.New(v, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		tempList[#tempList + 1] = data
	end

	table.sort(tempList, function(a, b)
		return a.cid < b.cid
	end)

	return tempList
end

function ActiveModule.CheckRedPointOnMoon()
	if not ActiveModule.CheckMoonIsOpened() then
		return false
	end

	local taskDatum = ActiveModule.GetMoonTaskDatum()

	for i, v in ipairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end
	end

	return false
end

function ActiveModule.CheckMoonIsOpened()
	return ActiveModule.GetMoonDateState() == 2
end

function ActiveModule.GetMoonDateState()
	local serverTime = PlayerModule.GetServerTime()

	if serverTime > ActiveModule.moonEndTime then
		return 3
	elseif serverTime < ActiveModule.moonStartTime then
		return 1
	else
		return 2
	end
end

function ActiveModule.GetNationalDayTaskDatum()
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NATIONAL_DAY, {
		1
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.NATIONAL_DAY, {
		1
	})
	local serverTime = PlayerModule.GetServerTime()
	local tempList = {}

	for i, v in pairs(processing) do
		local cfgData = CfgMainQuestTable[v.cid]
		local startTime = cfgDateTimeToTimeStamp(cfgData.StartTime, PlayerModule.TimeZone)
		local endTime = cfgDateTimeToTimeStamp(cfgData.EndTime, PlayerModule.TimeZone)
		local finNum = v.finNum

		if serverTime < startTime or endTime < serverTime then
			finNum = 0
		end

		local data = TaskUIData.New(v.cid, finNum, v.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, v.createTime)

		tempList[#tempList + 1] = data
	end

	for i, v in pairs(finished) do
		local cfgTaskData = CfgMainQuestTable[v]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local data = TaskUIData.New(v, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		tempList[#tempList + 1] = data
	end

	table.sort(tempList, function(a, b)
		return a.cid < b.cid
	end)

	return tempList
end

function ActiveModule.CheckRedPointOnNationalDay()
	if not ActiveModule.CheckNationalDayIsOpened() then
		return false
	end

	local taskDatum = ActiveModule.GetNationalDayTaskDatum()

	for i, v in ipairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end
	end

	return false
end

function ActiveModule.CheckNationalDayIsOpened()
	return ActiveModule.GetNationalDayDateState() == 2
end

function ActiveModule.GetNationalDayDateState()
	local serverTime = PlayerModule.GetServerTime()

	if serverTime > ActiveModule.nationalDayEndTime then
		return 3
	elseif serverTime < ActiveModule.nationalDayStartTime then
		return 1
	else
		return 2
	end
end

function ActiveModule.GetLvReachRewardList()
	net_active.getLvReachRewardList()
end

function ActiveModule.GetLvReachRewardListResult(idsList)
	ActiveModule.idsList = idsList

	EventDispatcher.Dispatch(EventID.UpdateUpgradeBigBattle)
end

function ActiveModule.GetLvReachRewardResult(itemList)
	if #itemList then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemList)
	end

	ActiveModule.GetLvReachRewardList()
end

function ActiveModule.Shutdown()
	ActiveModule.idsList = nil
end
