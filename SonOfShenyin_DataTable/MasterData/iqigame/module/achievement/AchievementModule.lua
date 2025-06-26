-- chunkname: @IQIGame\\Module\\Achievement\\AchievementModule.lua

AchievementModule = {}

function AchievementModule.Initialize()
	AchievementModule._InitData()
	AchievementModule._CreateAllAchievementItemList()
end

function AchievementModule._InitData()
	AchievementModule.achievementTaskList = {}
	AchievementModule.achievementParentList = {}
	AchievementModule.allAchievementItemList = {}
end

function AchievementModule.ShutDown()
	return
end

function AchievementModule._CreateAchievementParentList()
	for _, taskPOD in pairs(AchievementModule.achievementTaskList) do
		if AchievementModule.CheckIsAchievementTaskParent(taskPOD.cid) then
			table.insert(AchievementModule.achievementParentList, taskPOD)
		end
	end

	for i, _ in pairs(TaskSystemModule.hasFinishTaskList) do
		if TaskSystemModule.CheckTaskMainTypeAndExtendType(i, Constant.MainTaskType.Achievement, Constant.ExtendTaskType.Achievement) then
			local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(i)
			local taskPod = {
				cid = i,
				type = cfgTask.Type,
				schedule = cfgTask.NeedSchedule,
				schedule = cfgTask.NeedSchedule,
				status = Constant.TaskStatus.hadGot
			}

			table.insert(AchievementModule.achievementParentList, taskPod)
		end
	end

	table.sort(AchievementModule.achievementParentList, function(a, b)
		return a.cid < b.cid
	end)
end

function AchievementModule._CreateAllAchievementItemList()
	AchievementModule.allAchievementItemList = WarehouseModule.GetItemDataByTypes({
		Constant.ItemType.AchievementItem
	})
end

function AchievementModule._SortFunctionWithStatus(a, b)
	if a.status == Constant.TaskStatus.hasDone and b.status == Constant.TaskStatus.hasDone then
		return tonumber(a.completeTime) > tonumber(b.completeTime)
	elseif a.status == Constant.TaskStatus.hasDone and b.status ~= Constant.TaskStatus.hasDone then
		return true
	elseif a.status ~= Constant.TaskStatus.hasDone and b.status == Constant.TaskStatus.hasDone then
		return false
	elseif a.status ~= Constant.TaskStatus.hasDone and b.status ~= Constant.TaskStatus.hasDone then
		return a.cid < b.cid
	end
end

function AchievementModule._DisplayItemSortFunction(a, b)
	if AchievementModule.CheckItemIsDisplay(a.Id) and AchievementModule.CheckItemIsDisplay(b.Id) then
		return a.Id < b.Id
	elseif not AchievementModule.CheckItemIsDisplay(a.Id) and not AchievementModule.CheckItemIsDisplay(b.Id) then
		return a.Id < b.Id
	else
		return AchievementModule.CheckItemIsDisplay(a.Id) and true or false
	end
end

function AchievementModule._SortFunctionWithCompleteTime(a, b)
	if a.completeTime and b.completeTime then
		return tonumber(a.completeTime) > tonumber(b.completeTime)
	end
end

function AchievementModule.CreateAchievementTaskListFromServer(TaskPODList)
	for _, taskPOD in pairs(TaskPODList) do
		if AchievementModule.CheckIsAchievementTask(taskPOD) then
			AchievementModule.achievementTaskList[taskPOD.cid] = taskPOD
		end
	end

	AchievementModule._CreateAchievementParentList()
end

function AchievementModule.FilterTasks(mainType, extendType)
	local filteredTasks = {}

	for _, taskPOD in pairs(AchievementModule.achievementTaskList) do
		if TaskSystemModule.CheckTaskMainTypeAndExtendType(taskPOD.cid, mainType, extendType) then
			table.insert(filteredTasks, taskPOD)
		end
	end

	return filteredTasks
end

function AchievementModule.CheckParent(subTaskID, parentTaskID)
	local parentTaskConfig = CfgTaskTable[parentTaskID]

	if parentTaskConfig.Children then
		local subTaskPOD = AchievementModule.achievementTaskList[subTaskID]
		local childrenArray = string.split(parentTaskConfig.Children, "|")
		local mainType = tonumber(childrenArray[1])
		local extendType = {
			tonumber(childrenArray[2])
		}

		return TaskSystemModule.CheckTaskMainTypeAndExtendType(subTaskPOD.cid, mainType, extendType)
	end
end

function AchievementModule.GetSubTasksByParentTask(parentTaskID)
	local taskConfig = CfgTaskTable[parentTaskID]

	if taskConfig.Children then
		local childrenArray = string.split(taskConfig.Children, "|")
		local mainType = tonumber(childrenArray[1])
		local extendType = {
			tonumber(childrenArray[2])
		}

		return AchievementModule.FilterTasks(mainType, extendType)
	end
end

function AchievementModule.GetSortTaskList(parentTaskID)
	local taskList = {}
	local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(parentTaskID)
	local list = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Achievement, {
		cfgTask.TypeExtend[1],
		1
	})

	for k, task in pairs(list) do
		table.insert(taskList, task)
	end

	return taskList
end

function AchievementModule.GetHadDoneTasksWithType(type)
	local hadDoneTaskList = {}
	local hadFinishedTask = TaskSystemModule.hasFinishTaskList

	for i, v in pairsCfg(hadFinishedTask) do
		local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(i)

		if cfgTask.Type == type then
			table.insert(hadDoneTaskList, i)
		end
	end

	return hadDoneTaskList
end

function AchievementModule.GetHadDoneTasksProgress(type)
	local progressNum = 0
	local hadDoneTaskList = AchievementModule.GetHadDoneTasksWithType(type)

	for _, v in pairsCfg(hadDoneTaskList) do
		local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(v)

		progressNum = progressNum + cfgTask.PercentNum
	end

	return progressNum
end

function AchievementModule.GetAchievementParentList()
	AchievementModule.achievementParentList = {}

	local list = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Achievement, Constant.ExtendTaskType.AchievementParent)

	for k, task in pairs(list) do
		table.insert(AchievementModule.achievementParentList, task)
	end

	return AchievementModule.achievementParentList
end

function AchievementModule.GetAchievementParentTask(parentID)
	for _, v in pairs(AchievementModule.achievementParentList) do
		if v.cid == parentID then
			return v
		end
	end
end

function AchievementModule.GetAchievementBagHasItems()
	return WarehouseModule.GetWarehouseItemWithType(Constant.ItemType.AchievementItem)
end

function AchievementModule.GetAchievementBagAllItems()
	return AchievementModule.allAchievementItemList
end

function AchievementModule.GetAchievementDisplayList()
	return AchievementModule.achievementDisplayList
end

function AchievementModule.GetSortAchievementAllBagItemsList(hasType, iconType)
	local list = {}

	if hasType == Constant.AchievementDisplayHasSelectType.Has then
		for _, v in pairs(AchievementModule.allAchievementItemList) do
			if WarehouseModule.GetItemDataByCfgID(v.Id) then
				table.insert(list, v)
			end
		end
	elseif hasType == Constant.AchievementDisplayHasSelectType.All then
		list = Clone(AchievementModule.allAchievementItemList)
	elseif hasType == Constant.AchievementDisplayHasSelectType.NotHave then
		for _, v in pairs(AchievementModule.allAchievementItemList) do
			if not WarehouseModule.GetItemDataByCfgID(v.Id) then
				table.insert(list, v)
			end
		end
	end

	local finalList = {}

	if iconType == Constant.AchievementDisplayIconSelectType.All then
		finalList = list
	elseif iconType == Constant.AchievementDisplayIconSelectType.BigIcon then
		for _, v in pairs(list) do
			if v.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.AchievementItem].BigIcon then
				table.insert(finalList, v)
			end
		end
	elseif iconType == Constant.AchievementDisplayIconSelectType.MediumIcon then
		for _, v in pairs(list) do
			if v.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.AchievementItem].MiddleIcon then
				table.insert(finalList, v)
			end
		end
	elseif iconType == Constant.AchievementDisplayIconSelectType.SmallIcon then
		for _, v in pairs(list) do
			if v.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.AchievementItem].SmallIcon then
				table.insert(finalList, v)
			end
		end
	end

	if UIModule.HasUI(Constant.UIControllerName.AchievementDisplayUI) then
		EventDispatcher.Dispatch(EventID.AchievementDisplayUISortByEditItem, finalList)
	else
		table.sort(finalList, AchievementModule._DisplayItemSortFunction)
	end

	return finalList
end

function AchievementModule.CheckItemIsDisplay(ID)
	for _, v in pairs(AchievementModule.achievementDisplayList) do
		if v.cid == ID then
			return true
		end
	end

	return false
end

function AchievementModule.CheckIsAchievementTask(taskPOD)
	return taskPOD.type == Constant.MainTaskType.Achievement
end

function AchievementModule.CheckIsAchievementTaskParent(taskID)
	local taskConfig = CfgTaskTable[taskID]

	return taskConfig.Children ~= nil and taskConfig.Children ~= ""
end

function AchievementModule.CheckIsSubType(taskID, parentID)
	local taskConfig = CfgTaskTable[parentID]

	if taskConfig.Children then
		local childrenArray = string.split(taskConfig.Children, "|")
		local mainType = tonumber(childrenArray[1])
		local extendType = {
			tonumber(childrenArray[2])
		}

		return TaskSystemModule.CheckTaskMainTypeAndExtendType(taskID, mainType, extendType)
	end
end

function AchievementModule.GetAchievementFinishCount()
	local parentData = AchievementModule.GetAchievementParentList()
	local finishNum = 0
	local sum = 0

	for i = 1, #parentData do
		local parentTaskPod = TaskSystemModule.taskSystemDataDic[parentData[i].cid]

		if parentTaskPod == nil then
			if TaskSystemModule.GetFinishedTaskWithID(parentData[i].cid) then
				finishNum = finishNum + 1
			end
		elseif parentTaskPod.status >= Constant.TaskStatus.hasDone then
			finishNum = finishNum + 1
		end

		local childData = AchievementModule.GetSortTaskList(parentData[i].cid)

		for n = 1, #childData do
			local childTaskPod = TaskSystemModule.taskSystemDataDic[childData[n].cid]

			if childTaskPod == nil then
				if TaskSystemModule.GetFinishedTaskWithID(childData[n].cid) then
					finishNum = finishNum + 1
				end
			elseif childTaskPod.status >= Constant.TaskStatus.hasDone then
				finishNum = finishNum + 1
			end
		end

		sum = sum + 1 + #childData
	end

	return sum, finishNum
end

function AchievementModule.SubmitTask(cids)
	net_task.submit(cids)
end

function AchievementModule.submitTypePassTask(types)
	net_task.submitType(types)
end

function AchievementModule.SaveAchievementDisplay(achieveShows)
	net_player.achieveShow(achieveShows)

	AchievementModule.achievementDisplayListCache = achieveShows
	PlayerModule.PlayerInfo.baseInfo.achieveShow = achieveShows
end

function AchievementModule.NotifyTaskRefresh(tasks)
	local isChange = false

	for _, taskPOD in pairs(tasks) do
		if AchievementModule.CheckIsAchievementTask(taskPOD) then
			local newTask = true
			local needTip = false

			for _, achievementTask in pairs(AchievementModule.achievementTaskList) do
				if achievementTask.cid == taskPOD.cid then
					if achievementTask.status ~= taskPOD.status and taskPOD.status == Constant.TaskStatus.hasDone then
						needTip = true
					end

					achievementTask.schedule = taskPOD.schedule
					achievementTask.status = taskPOD.status
					newTask = false
				end
			end

			if newTask then
				AchievementModule.achievementTaskList[taskPOD.cid] = taskPOD

				if taskPOD.status == Constant.TaskStatus.hasDone then
					needTip = true
				end
			end

			if needTip then
				-- block empty
			end

			isChange = true
		end
	end

	if isChange then
		EventDispatcher.Dispatch(EventID.AchievementUIRefresh)
	end

	if isChange then
		EventDispatcher.Dispatch(EventID.AchievementCollectRefresh)
	end
end

function AchievementModule.NotifyRemoveTask(toRemoveTaskID)
	local isChange = false

	for taskID, _ in pairs(AchievementModule.achievementTaskList) do
		if taskID == toRemoveTaskID then
			AchievementModule.achievementTaskList[taskID] = nil
			isChange = true
		end
	end

	if isChange then
		EventDispatcher.Dispatch(EventID.AchievementUIRefresh)
	end
end

function AchievementModule.Reload(achieveShow)
	AchievementModule.achievementDisplayList = achieveShow

	AchievementModule.CreateAchievementTaskListFromServer(TaskSystemModule.taskSystemDataDic)
end

function AchievementModule.achieveShowResult(code)
	AchievementModule.achievementDisplayList = AchievementModule.achievementDisplayListCache

	NoticeModule.ShowNotice(70003)
	EventDispatcher.Dispatch(EventID.ArchivesMainRefresh)
	EventDispatcher.Dispatch(EventID.AchievementDisplayUISortSaveSucceed)
	EventDispatcher.Dispatch(EventID.AchievementShow)
end
