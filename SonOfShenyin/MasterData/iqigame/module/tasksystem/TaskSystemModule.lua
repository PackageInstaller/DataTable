-- chunkname: @IQIGame\\Module\\TaskSystem\\TaskSystemModule.lua

TaskSystemModule = {
	SubmitTaskMark = false,
	taskSystemDataDic = {},
	trunkConfigDic = {}
}

local TaskSystemData = require("IQIGame.Module.TaskSystem.TaskSystemData")
local this = TaskSystemModule

function TaskSystemModule.Initialize()
	TaskSystemModule.InitData()
	TaskSystemModule.AddEventListeners()

	TaskSystemModule.isInit = true
end

function TaskSystemModule.Shutdown()
	TaskSystemModule.RemoveEventListeners()
end

function TaskSystemModule.AddEventListeners()
	return
end

function TaskSystemModule.RemoveEventListeners()
	return
end

function TaskSystemModule.InitData()
	TaskSystemModule.taskSystemDataDic = {}
	TaskSystemModule.trunkConfigDic = {}
	TaskSystemModule.submitTaskMark = nil
	TaskSystemModule.hasFinishTaskList = {}
	TaskSystemModule.hasFinishTaskListValueByTaskID = {}
	TaskSystemModule.sortType = {
		Id = 2,
		Schedule = 3,
		Weight_ID = 1,
		Status_ID = 4
	}
	TaskSystemModule.sortType2SortFunc = {
		[TaskSystemModule.sortType.Weight_ID] = TaskSystemModule.TaskSortWeightID,
		[TaskSystemModule.sortType.Id] = TaskSystemModule.TaskSortId,
		[TaskSystemModule.sortType.Schedule] = TaskSystemModule.TaskSortSchedule,
		[TaskSystemModule.sortType.Status_ID] = TaskSystemModule.TaskSortStatusID
	}
end

function TaskSystemModule.Reload(TaskPODList, finishTasks, finishedTaskTimes)
	for _, v in pairsCfg(TaskPODList) do
		TaskSystemModule.CreateTaskData(v)
	end

	TaskSystemModule.hasFinishTaskList = finishTasks
	TaskSystemModule.hasFinishTaskListValueByTaskID = {}

	for k, v in pairs(TaskSystemModule.hasFinishTaskList) do
		table.insert(TaskSystemModule.hasFinishTaskListValueByTaskID, k)
	end

	TaskSystemModule.hasFinishTaskTimesList = finishedTaskTimes
end

function TaskSystemModule.GetTaskHasFinishedList()
	return TaskSystemModule.hasFinishTaskList
end

function TaskSystemModule.GetFinishedTaskWithID(taskID)
	return TaskSystemModule.hasFinishTaskList[taskID]
end

function TaskSystemModule.CheckTaskIsFinished(taskPod)
	local value = false

	if TaskSystemModule.GetFinishedTaskWithID(taskPod.cid) then
		value = true

		return value
	end

	if taskPod.status == Constant.TaskStatus.hadGot then
		value = true
	end

	return value
end

function TaskSystemModule.SetIsGettingAll(value)
	TaskSystemModule.isGettingAll = value
end

function TaskSystemModule.GetIsGettingAll()
	return TaskSystemModule.isGettingAll
end

function TaskSystemModule.GetTaskIsObtain(taskId)
	return TaskSystemModule.taskSystemDataDic[taskId] and true or false
end

function TaskSystemModule.CreateTaskData(TaskDataPod)
	local taskSystemData

	if TaskSystemModule.taskSystemDataDic[TaskDataPod.cid] == nil then
		taskSystemData = TaskSystemData.New()

		taskSystemData:Initialize(TaskDataPod)

		TaskSystemModule.taskSystemDataDic[taskSystemData.cid] = taskSystemData
	else
		taskSystemData = TaskSystemModule.taskSystemDataDic[TaskDataPod.cid]

		taskSystemData:Initialize(TaskDataPod)
	end
end

function TaskSystemModule.IsCanGetAward(mainType, extendType)
	local filteredTasks = TaskSystemModule.GetTaskListByPlayer(mainType, extendType)

	if filteredTasks == nil or #filteredTasks == 0 then
		return false
	end

	for _, itemData in pairs(filteredTasks) do
		if itemData.status == Constant.TaskStatus.hasDone then
			return true
		end
	end

	return false
end

function TaskSystemModule.IsCanGetAwards(mainType, extendType)
	local filteredTasks = TaskSystemModule.GetTaskListByPlayer(mainType, extendType)

	if filteredTasks == nil or #filteredTasks == 0 then
		return false
	end

	local index = 0

	for i = 1, #filteredTasks do
		local task = filteredTasks[i]

		if task.status == Constant.TaskStatus.hasDone then
			index = index + 1

			if index >= 1 then
				return true
			end
		end
	end

	return false
end

function TaskSystemModule.GetCanReceiveTaskIDList(taskList)
	local canReceiveIDList = {}

	for i = 1, #taskList do
		for j = 1, #taskList[i] do
			if taskList[i][j].status == Constant.TaskStatus.hasDone then
				table.insert(canReceiveIDList, taskList[i][j].cid)
			end
		end
	end

	return canReceiveIDList
end

function TaskSystemModule.GetSortForTypeDataList(mainType, extendType, sortType, isNotIgnore, isPlayer)
	local filteredTasks = {}

	if isPlayer then
		filteredTasks = TaskSystemModule.GetTaskListByPlayer(mainType, extendType)
	else
		filteredTasks = TaskSystemModule.GetTaskListByConfig(mainType, extendType)
	end

	if #filteredTasks == 0 then
		return filteredTasks
	end

	for i = #filteredTasks, 1, -1 do
		local isAdd = true
		local isOpen = true
		local task = filteredTasks[i]

		if task.cfgTaskConfig.JumpType ~= 0 and mainType ~= Constant.MainTaskType.Main then
			local functionCfg = CfgFunctionTable[task.cfgTaskConfig.JumpType]

			if functionCfg.FuncSwitchOpen ~= 0 then
				if functionCfg.FuncSwitchOpen == Constant.UnlockType.FUNC_DAILY_DUP then
					local conditionResults = ConditionModule.CheckMultiple(CfgDupTagTable[functionCfg.Params[1]].UnlockConditionId)

					isOpen = ConditionModule.CheckMultipleAllIsPass(conditionResults) and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_DAILY_DUP)
				else
					isOpen = JumpModule.CheckConditionIsPass(functionCfg)
				end
			end

			isAdd = isOpen
		end

		if not isNotIgnore and task.status == Constant.TaskStatus.hadGot or not isAdd then
			table.remove(filteredTasks, i)
		end
	end

	if sortType ~= nil then
		filteredTasks = TaskSystemModule.TaskSortFunc(sortType, filteredTasks)
	else
		filteredTasks = TaskSystemModule.TaskSortFunc(TaskSystemModule.sortType.Weight_ID, filteredTasks)
	end

	return filteredTasks
end

function TaskSystemModule.GetFinishedTaskDataList(mainType, extendType)
	local data = {}

	for i, _ in pairs(TaskSystemModule.hasFinishTaskList) do
		local cfgTask = CfgUtil.GetTaskCfgWithID(i)

		if TaskSystemModule.MatchTask(cfgTask, mainType, extendType) then
			local taskData = TaskSystemModule.CreateTempTaskData(i, Constant.TaskStatus.hadGot)

			table.insert(data, taskData)
		end
	end

	table.sort(data, function(a, b)
		return a.cid > b.cid
	end)

	return data
end

function TaskSystemModule.MatchTask(taskCfg, taskType, typeExtend)
	if taskType ~= -1 and taskType ~= taskCfg.Type then
		return false
	end

	local bool = false

	if typeExtend then
		for i, v in ipairs(typeExtend) do
			if i > #taskCfg.TypeExtend then
				bool = false

				break
			end

			if typeExtend[i] == -1 or typeExtend[i] == taskCfg.TypeExtend[i] then
				bool = true
			else
				bool = false

				break
			end
		end
	else
		bool = true
	end

	return bool
end

function TaskSystemModule.TaskSortWeightID(tb1, tb2)
	if tb1.sortWeight < tb2.sortWeight then
		return true
	elseif tb1.sortWeight == tb2.sortWeight then
		if tb1.cid < tb2.cid then
			return true
		end

		return false
	else
		return false
	end
end

function TaskSystemModule.TaskSortId(tb1, tb2)
	return tb1.cid < tb2.cid
end

function TaskSystemModule.TaskSortSchedule(tb1, tb2)
	return tb1.needSchedule < tb2.needSchedule
end

local statusPriority = {
	[Constant.TaskStatus.hasDone] = 1,
	[Constant.TaskStatus.doing] = 2,
	[Constant.TaskStatus.hadGot] = 3
}

function TaskSystemModule.TaskSortStatusID(tb1, tb2)
	if statusPriority[tb1.status] ~= statusPriority[tb2.status] then
		return statusPriority[tb1.status] < statusPriority[tb2.status]
	else
		return tb1.cid < tb2.cid
	end
end

function TaskSystemModule.TaskSortFunc(sortType, listData)
	local sortFunction = TaskSystemModule.sortType2SortFunc[sortType]

	table.sort(listData, sortFunction)

	return listData
end

function TaskSystemModule.GetActivityTotalSchedule(mainType, extendType)
	local activeList = TaskSystemModule.GetSortForTypeDataList(mainType, extendType, TaskSystemModule.sortType.Schedule, true)

	return activeList[getTableLength(activeList)].needSchedule
end

function TaskSystemModule.GetActivityCurrentSchedule(mainType, extendType)
	local curSchedule, itemData

	if mainType == Constant.MainTaskType.Daily then
		itemData = WarehouseModule.GetItemDataByCfgID(Constant.ItemCid.DayActivity)
	elseif mainType == Constant.MainTaskType.Weekly then
		itemData = WarehouseModule.GetItemDataByCfgID(Constant.ItemCid.WeeklyActivity)
	end

	curSchedule = not itemData and 0 or itemData.num

	return curSchedule
end

function TaskSystemModule:GetSubmitTaskMark()
	return TaskSystemModule.submitTaskMark
end

function TaskSystemModule:SetSubmitTaskMark(state)
	TaskSystemModule.submitTaskMark = state
end

function TaskSystemModule.GetCfgTaskDataWithID(ID)
	return CfgTaskTable[ID]
end

function TaskSystemModule.GetTaskTypeExtendWithID(ID)
	local cfgTaskConfig = CfgTaskTable[ID]

	if cfgTaskConfig ~= nil then
		local typeCount = #cfgTaskConfig.TypeExtend

		if typeCount == 2 then
			return cfgTaskConfig.TypeExtend[1], cfgTaskConfig.TypeExtend[2]
		elseif typeCount == 1 then
			return cfgTaskConfig.TypeExtend[1], nil
		end
	end

	return nil, nil
end

function TaskSystemModule.CheckTaskMainTypeAndExtendType(taskCID, mainType, extendType)
	if CfgTaskTable[taskCID] == nil then
		logError("任务表未找到" .. taskCID .. "的任务!请检查Task配置表")

		return
	end

	return TaskSystemModule.MatchTask(CfgTaskTable[taskCID], mainType, extendType)
end

function TaskSystemModule.CombineContent(mainType, extendType)
	local content = ""

	content = content .. tostring(mainType)

	if type(extendType) == "table" then
		for i = 1, #extendType do
			content = content .. "," .. tostring(extendType[i])
		end
	end

	return content
end

function TaskSystemModule.SubmitTask(cids)
	TaskSystemModule:SetSubmitTaskMark(true)
	net_task.submit(cids)
end

function TaskSystemModule.SubmitTaskForType(types)
	TaskSystemModule:SetSubmitTaskMark(true)
	net_task.submitType(types)
	TaskSystemModule.SetIsGettingAll(true)
end

function TaskSystemModule.ObtainTask(cid)
	net_task.obtainTask(cid)
end

function TaskSystemModule.RepairTask(taskCid)
	net_task.repairTask(taskCid)
end

function TaskSystemModule.TrackTask(taskCid)
	net_task.trackTask(taskCid)
end

function TaskSystemModule.SubmitResultSucceed(code, cids, shows)
	TaskSystemModule:SetSubmitTaskMark(false)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
	EventDispatcher.Dispatch(EventID.TaskSubmitSucceed, shows)
	EventDispatcher.Dispatch(EventID.NoviceSignEvent)
end

function TaskSystemModule.SubmitResultForTypeSucceed(code, shows)
	TaskSystemModule:SetSubmitTaskMark(false)

	TaskSystemModule.hasDayActivityAward = false
	TaskSystemModule.hasWeekActivityAward = false

	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
	TaskSystemModule.SetIsGettingAll(false)
	EventDispatcher.Dispatch(EventID.ActivityPassUIRefreshPassInfo)
	EventDispatcher.Dispatch(EventID.TaskSubmitSucceed, shows)
	EventDispatcher.Dispatch(EventID.AchievementUIRefresh)
end

function TaskSystemModule.NotifyTask(taskPODs)
	for i, taskPOD in pairs(taskPODs) do
		local taskSystemData = TaskSystemModule.taskSystemDataDic[taskPOD.cid]

		if taskSystemData == nil then
			TaskSystemModule.CreateTaskData(taskPOD)
		else
			taskSystemData:Initialize(taskPOD)

			if taskSystemData.status == Constant.TaskStatus.hasDone then
				if TaskSystemModule.CheckTaskMainTypeAndExtendType(taskPOD.cid, Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Activity) then
					TaskSystemModule.hasDayActivityAward = true
				end

				if TaskSystemModule.CheckTaskMainTypeAndExtendType(taskPOD.cid, Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Activity) then
					TaskSystemModule.hasWeekActivityAward = true
				end
			end
		end

		EventDispatcher.Dispatch(EventID.CommonDialogControl_Action_GetTask, taskPOD.cid)
	end

	EventDispatcher.Dispatch(EventID.TaskNotifyTask, taskPODs)
	AchievementModule.NotifyTaskRefresh(taskPODs)
	EventDispatcher.Dispatch(EventID.ActivityPassUIRefreshPassInfo)
	EventDispatcher.Dispatch(EventID.DiceGameTaskUIRefreshEvent)
end

function TaskSystemModule.NotifyRemove(toRemoveTaskCIDs)
	local hasWeekActivity = false
	local hasDayActivity = false

	for i = 1, getCfgTableLength(toRemoveTaskCIDs) do
		ActivityPassModule.RemovePassTask(toRemoveTaskCIDs[i])
		AchievementModule.NotifyRemoveTask(toRemoveTaskCIDs[i])

		for taskCID, taskSystemData in pairs(TaskSystemModule.taskSystemDataDic) do
			if taskSystemData.cid == toRemoveTaskCIDs[i] then
				if TaskSystemModule.CheckTaskMainTypeAndExtendType(taskCID, Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Activity) then
					hasWeekActivity = true
				end

				if TaskSystemModule.CheckTaskMainTypeAndExtendType(taskCID, Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Activity) then
					hasDayActivity = true
				end

				if not TaskSystemModule.CheckTaskMainTypeAndExtendType(taskCID, Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Activity) and not TaskSystemModule.CheckTaskMainTypeAndExtendType(taskCID, Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Activity) then
					break
				end
			end
		end

		TaskSystemModule.taskSystemDataDic[toRemoveTaskCIDs[i]] = nil
	end

	if toRemoveTaskCIDs ~= nil and #toRemoveTaskCIDs > 0 then
		EventDispatcher.Dispatch(EventID.TaskNotifyRemove, toRemoveTaskCIDs)
	end

	EventDispatcher.Dispatch(EventID.ActivityPassUIRefreshPassInfo)
end

function TaskSystemModule.NotifyRemoveFinish(tasks)
	for i, _ in pairs(tasks) do
		for j, v in pairs(TaskSystemModule.hasFinishTaskList) do
			if i == j then
				table.remove(v)
			end
		end
	end

	EventDispatcher.Dispatch(EventID.ActivityPassUIRefreshPassInfo)
	EventDispatcher.Dispatch(EventID.AchievementUIRefresh)
end

function TaskSystemModule.NotifyFinish(tasks)
	local showSettlementTaskArray = {}

	for _, v in pairs(tasks) do
		TaskSystemModule.hasFinishTaskList[v] = v

		local cfgTask = CfgUtil.GetTaskCfgWithID(v)

		if cfgTask.IsShowReward then
			table.insert(showSettlementTaskArray, v)
		end

		if cfgTask.IsRefreshTrack then
			TaskSystemModule.TrackTask(cfgTask.TypeExtend[1])
		end
	end

	TaskSystemModule.hasFinishTaskListValueByTaskID = {}

	for k, v in pairs(TaskSystemModule.hasFinishTaskList) do
		table.insert(TaskSystemModule.hasFinishTaskListValueByTaskID, k)
	end

	EventDispatcher.Dispatch(EventID.TaskNotifyFinish, tasks)
	EventDispatcher.Dispatch(EventID.ActivityPassUIRefreshPassInfo)
	EventDispatcher.Dispatch(EventID.AchievementUIRefresh)

	if #showSettlementTaskArray > 0 then
		local cfgTask = CfgUtil.GetTaskCfgWithID(showSettlementTaskArray[1])

		table.remove(showSettlementTaskArray, 1)

		local userData = {}

		userData.fightOverPOD = {}
		userData.fightOverPOD.fightResult = Constant.FightResult.ATTACKER_WIN
		userData.fightOverPOD.awards = {}

		local len = #cfgTask.ActionParam

		for i = 1, len, 2 do
			local data = {}

			data.id = 0
			data.cid = cfgTask.ActionParam[i]
			data.num = cfgTask.ActionParam[i + 1]
			data.tag = Constant.DropItemTag.None
			data.srcId = 0

			table.insert(userData.fightOverPOD.awards, data)
		end

		UIModule.Open(Constant.UIControllerName.Settlement_ActionUI, Constant.UILayer.UI, userData)
	end
end

function TaskSystemModule.NotifyRemoveTaskCompleteTime(tasks)
	for i, v in pairsCfg(tasks) do
		TaskSystemModule.hasFinishTaskTimesList[i] = v
	end

	EventDispatcher.Dispatch(EventID.AchievementUIRefresh)
end

function TaskSystemModule.GetTaskListByPlayer(taskType, typeExtend)
	local taskList = {}

	for _, taskSystemData in pairs(TaskSystemModule.taskSystemDataDic) do
		if TaskSystemModule.MatchTask(taskSystemData.cfgTaskConfig, taskType, typeExtend) then
			table.insert(taskList, taskSystemData)
		end
	end

	TaskSystemModule.TaskSortFunc(TaskSystemModule.sortType.Status_ID, taskList)

	return taskList
end

function TaskSystemModule.GetTaskListByConfig(taskType, typeExtend, ignoreSort)
	local taskList = {}

	for k, v in pairs(CfgTaskTable) do
		if TaskSystemModule.MatchTask(v, taskType, typeExtend) then
			local taskData = TaskSystemModule.taskSystemDataDic[k]

			if not taskData then
				if TaskSystemModule.hasFinishTaskList[k] then
					taskData = TaskSystemModule.CreateTempTaskData(k, Constant.TaskStatus.hadGot)
					taskData.completeTime = TaskSystemModule.hasFinishTaskTimesList[k]
				elseif v.IsUnLock == 0 then
					if v.LockShow == 1 then
						taskData = TaskSystemModule.CreateTempTaskData(k, Constant.TaskStatus.doing)
					end
				else
					taskData = TaskSystemModule.CreateTempTaskData(k, Constant.TaskStatus.doing)
				end
			end

			if taskData then
				table.insert(taskList, taskData)
			end
		end
	end

	TaskSystemModule.TaskSortFunc(TaskSystemModule.sortType.Status_ID, taskList)

	return taskList
end

function TaskSystemModule.GetTaskByConfig(cid)
	local v = CfgTaskTable[cid]
	local taskData = TaskSystemModule.taskSystemDataDic[cid]

	if not taskData then
		if TaskSystemModule.hasFinishTaskList[cid] then
			taskData = TaskSystemModule.CreateTempTaskData(cid, Constant.TaskStatus.hadGot)
			taskData.completeTime = TaskSystemModule.hasFinishTaskTimesList[cid]
		else
			taskData = TaskSystemModule.CreateTempTaskData(cid, Constant.TaskStatus.doing)
		end
	end

	return taskData
end

function TaskSystemModule.GetTaskByPlayer(cid)
	local taskData = TaskSystemModule.taskSystemDataDic[cid]

	if not taskData then
		if TaskSystemModule.hasFinishTaskList[cid] then
			taskData = TaskSystemModule.CreateTempTaskData(cid, Constant.TaskStatus.hadGot)
			taskData.completeTime = TaskSystemModule.hasFinishTaskTimesList[cid]
		else
			taskData = nil
		end
	end

	return taskData
end

function TaskSystemModule.CreateTempTaskData(taskCid, status)
	local cfgTackConfig = TaskSystemModule.GetCfgTaskDataWithID(taskCid)

	if cfgTackConfig == nil then
		logError("TaskSystemModule.CreateTempTaskData:  无法找到 taskCid={0} 的任务表数据.", taskCid)

		return
	end

	local taskDataPod = {
		cid = taskCid,
		type = cfgTackConfig.Type,
		status = status,
		schedule = status == Constant.TaskStatus.hadGot and cfgTackConfig.NeedSchedule or 0,
		needSchedule = cfgTackConfig.NeedSchedule
	}
	local taskSystemData = TaskSystemData.New()

	taskSystemData:Initialize(taskDataPod)

	taskSystemData.virtual = true

	return taskSystemData
end

function TaskSystemModule.isFinishAll(taskType, typeExtend)
	local taskList = {}

	for k, v in pairs(CfgTaskTable) do
		if TaskSystemModule.MatchTask(v, taskType, typeExtend) then
			local taskData = TaskSystemModule.taskSystemDataDic[k]

			if not taskData then
				if not TaskSystemModule.hasFinishTaskList[k] then
					return false
				end
			elseif taskData.status ~= Constant.passTaskStatus.hadGot then
				return false
			end
		end
	end

	return true
end

function TaskSystemModule.GetTaskDataByCid(taskCid)
	local taskData = TaskSystemModule.taskSystemDataDic[taskCid]

	return taskData
end

function TaskSystemModule.ObtainTaskResult()
	return
end

function TaskSystemModule.OnTaskJump(taskCid)
	local cfgTask = CfgUtil.GetTaskCfgWithID(taskCid)
	local lvTaskArray = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.RPGMain, {
		taskCid,
		Constant.RPGTaskType.LvChildTask
	}, TaskSystemModule.sortType.Id, true, true)

	for i = 1, #lvTaskArray do
		if not TaskSystemModule.CheckTaskIsFinished(lvTaskArray[i]) then
			NoticeModule.ShowNotice(11030)

			return
		end
	end

	local childTask = WorldMapModule.GetCurrentChildTaskByParentTaskId(taskCid, cfgTask.Type)

	if childTask then
		if cfgTask.TimeType == Constant.RPGTaskTimeType.Night and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Day then
			NoticeModule.ShowNotice(12022)

			return
		elseif cfgTask.TimeType == Constant.RPGTaskTimeType.Day and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Night then
			NoticeModule.ShowNotice(12021)

			return
		end
	end

	local actionData = WorldMapModule.GetActionByTaskId(taskCid)

	if actionData then
		local componentData = WorldMapModule.GetComponentDataWithId(actionData.compCid)

		if not componentData then
			logError(string.format("【RPG】角色传送没有找到行为 id = %s,所属组件id = %s的组件数据", actionData.cid, actionData.compCid))

			return
		end

		local transPos = componentData:GetCfg().TransmitPoint
		local pos

		if transPos[1] and transPos[2] and transPos[3] then
			pos = Vector3.New(transPos[1], transPos[2], transPos[3])
		else
			pos = Vector3.New(componentData.pos.x + 3, componentData.pos.y, componentData.pos.z)
		end

		WorldMapModule.EnterRoom(actionData:GetRoomId(), true, pos and WorldMapModule.PackingEnterRoomData(pos) or nil)
	elseif cfgTask.Type == Constant.MainTaskType.RPGMain then
		local roomId = WorldMapModule.GetRoomIDWithTag(Constant.RPGTagType.MainTag)

		if roomId then
			WorldMapModule.EnterRoom(roomId, true)
		end
	elseif cfgTask.Type == Constant.MainTaskType.RPGBranch then
		local roomId = WorldMapModule.GetRoomIDWithTag(Constant.RPGTagType.BranchTag)

		if roomId then
			WorldMapModule.EnterRoom(roomId, true)
		end
	end

	UIModule.CloseAllUIFrom({
		Constant.UIControllerName.MainUI
	})
	EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, false)
end
