-- chunkname: @IQIGame\\Module\\ActiveWeekend\\ActiveWeekendModule.lua

ActiveWeekendModule = {}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function ActiveWeekendModule.GetGrowDayTaskDatum(weekIndex, dayIndex)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NEW_PLAYER_GROW_UP_TASK, {
		weekIndex * 10 + dayIndex
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.NEW_PLAYER_GROW_UP_TASK, {
		weekIndex * 10 + dayIndex
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

function ActiveWeekendModule.GetGrowScoreTaskDatum()
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NEW_PLAYER_GROW_UP_TASK, {
		10
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.NEW_PLAYER_GROW_UP_TASK, {
		10
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
		if a.cid < b.cid then
			return true
		else
			return false
		end
	end)

	return ret
end

function ActiveWeekendModule.CheckExistWeekendTask()
	for weekIndex = 1, 2 do
		for dayIndex = 1, 7 do
			local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NEW_PLAYER_GROW_UP_TASK, {
				weekIndex * 10 + dayIndex
			})

			if #processing > 0 then
				return true
			end
		end
	end

	return #TaskModule.GetTaskProcessing(TaskModule.TaskType.NEW_PLAYER_GROW_UP_TASK, {
		10
	}) > 0
end

function ActiveWeekendModule.CheckRedPoint()
	local ret = false

	for i = 1, 2 do
		if ActiveWeekendModule.CheckRedPointOnWeek(i) then
			ret = true

			break
		end
	end

	return ret
end

function ActiveWeekendModule.CheckRedPointOnWeek(weekIndex)
	local ret = false

	if not ActiveWeekendModule.CheckTopToggleCanClick(weekIndex) then
		return false
	end

	for i = 1, 7 do
		if ActiveWeekendModule.CheckRedPointOnGrowDay(weekIndex, i) then
			ret = true

			break
		end
	end

	if not ret then
		local datum = ActiveWeekendModule.GetGrowScoreTaskDatum()

		for i, v in pairs(datum) do
			if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
				ret = true

				break
			end
		end
	end

	return ret
end

function ActiveWeekendModule.CheckRedPointOnGrowDay(weekIndex, dayIndex)
	local ret = false

	if not ActiveWeekendModule.CheckTabLeftToggleCanClick(weekIndex, dayIndex) then
		return false
	end

	local datum = ActiveWeekendModule.GetGrowDayTaskDatum(weekIndex, dayIndex)

	for i, v in pairs(datum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			ret = true

			break
		end
	end

	return ret
end

function ActiveWeekendModule.CheckIsInValidDay(day)
	return false
end

function ActiveWeekendModule.CheckTopToggleCanClick(weekIndex)
	local curDay = ActiveWeekendModule.GetCurDay()

	return curDay >= (weekIndex - 1) * 7 + 1
end

function ActiveWeekendModule.CheckTabLeftToggleCanClick(weekIndex, day)
	local curDay = ActiveWeekendModule.GetCurDay()
	local checkDay = (weekIndex - 1) * 7 + day

	return checkDay <= curDay
end

function ActiveWeekendModule.GetCurDay()
	local dateTableNow = getDateTimeTable(PlayerModule.GetServerTime())
	local dateTableCreate = getDateTimeTable(PlayerModule.PlayerInfo.baseInfo.createTime - 14400)
	local timeNow = os.time({
		day = dateTableNow.day,
		month = dateTableNow.month,
		year = dateTableNow.year,
		hour = dateTableNow.hour,
		minute = dateTableNow.min,
		second = dateTableNow.sec
	})
	local timeCreate = os.time({
		hour = 4,
		second = 0,
		minute = 0,
		day = dateTableCreate.day,
		month = dateTableCreate.month,
		year = dateTableCreate.year
	})

	timeNow = math.max(timeNow, timeCreate)

	local dayCount = math.floor((timeNow - timeCreate) / 86400) + 1

	return dayCount
end
