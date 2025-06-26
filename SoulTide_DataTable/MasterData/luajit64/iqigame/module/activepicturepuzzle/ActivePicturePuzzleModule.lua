-- chunkname: @IQIGame\\Module\\ActivePicturePuzzle\\ActivePicturePuzzleModule.lua

local m = {}
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function m.Reload()
	return
end

function m.Shutdown()
	return
end

function m.GetPuzzleRewards(picturePuzzleID)
	local tab = {}
	local OperationEventPOD = ActiveOperationEventModule.GetActiveOperationData(picturePuzzleID)

	if OperationEventPOD then
		local cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[OperationEventPOD.dataCfgId]

		for i, v in pairsCfg(CfgPuzzlesRewardTable) do
			if cfgPuzzlesGlobal.Id == v.PuzzlesGlobal then
				local t = table.clone(v)

				table.insert(tab, t)
			end
		end

		table.sort(tab, function(a, b)
			return a.Id < b.Id
		end)
	end

	return tab
end

function m.GetMaxProgressStatus(picturePuzzleID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(picturePuzzleID)

	if operationEventDataPOD then
		m.ipData = operationEventDataPOD.ipData

		if m.ipData then
			return m.ipData.unlockedRewardsIdx
		end
	end

	return 0
end

function m.GetMaxProgress(picturePuzzleID)
	local len = 0
	local OperationEventPOD = ActiveOperationEventModule.GetActiveOperationData(picturePuzzleID)

	if OperationEventPOD then
		local cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[OperationEventPOD.dataCfgId]

		len = #cfgPuzzlesGlobal.ProgressReward / 3
	end

	return len
end

function m.GetCompletedProgress(picturePuzzleID)
	local tab = m.GetPuzzleRewards(picturePuzzleID)
	local completedNum = 0
	local totalNum = #tab

	for i = 1, #tab do
		local cfgPuzzleReward = tab[i]

		if cfgPuzzleReward then
			local state = m.GetPicRewardState(picturePuzzleID, cfgPuzzleReward.Id)

			if state == 1 or state == 2 then
				completedNum = completedNum + 1
			end
		end
	end

	return completedNum, totalNum
end

function m.GetProgressReward(picturePuzzleID)
	local getRewardIndex = m.GetMaxProgressStatus(picturePuzzleID)
	local tab
	local OperationEventPOD = ActiveOperationEventModule.GetActiveOperationData(picturePuzzleID)

	if OperationEventPOD then
		local cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[OperationEventPOD.dataCfgId]
		local len = #cfgPuzzlesGlobal.ProgressReward
		local index = 0

		for i = 1, len, 3 do
			index = index + 1

			if getRewardIndex < index then
				local progressNum = cfgPuzzlesGlobal.ProgressReward[i]
				local rewardID = cfgPuzzlesGlobal.ProgressReward[i + 1]
				local rewardNum = cfgPuzzlesGlobal.ProgressReward[i + 2]

				tab = {
					progressNum,
					rewardID,
					rewardNum
				}

				break
			end
		end

		if tab == nil then
			tab = {
				cfgPuzzlesGlobal.ProgressReward[len - 2],
				cfgPuzzlesGlobal.ProgressReward[len - 1],
				cfgPuzzlesGlobal.ProgressReward[len]
			}
		end
	end

	return tab
end

function m.GetPictureUnlockPlace(picturePuzzleID)
	local openNum = 0
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(picturePuzzleID)

	if operationEventDataPOD then
		m.ipData = operationEventDataPOD.ipData

		if m.ipData and m.ipData.unlockedPlace then
			openNum = #m.ipData.unlockedPlace
		end
	end

	return openNum
end

function m.GetPicturePuzzlePosState(picturePuzzleID, pos)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(picturePuzzleID)

	if operationEventDataPOD then
		m.ipData = operationEventDataPOD.ipData

		if m.ipData and table.indexOf(m.ipData.unlockedPlace, pos) ~= -1 then
			return true
		end
	end

	return false
end

function m.GetPicRewardState(picturePuzzleID, cfgPuzzleRewardID)
	local state = 3
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(picturePuzzleID)

	if operationEventDataPOD then
		m.ipData = operationEventDataPOD.ipData

		if m.ipData then
			if table.indexOf(m.ipData.gotRewards, cfgPuzzleRewardID) ~= -1 then
				state = 1
			elseif table.indexOf(m.ipData.rewards, cfgPuzzleRewardID) ~= -1 then
				state = 2
			end
		end
	end

	return state
end

function m.CheckAllRedPoint()
	for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
		local cfg = CfgOperateEventsControlTable[v.eventCfgId]

		if cfg.Type == Constant.Activity_Operation_Type.Activity_PicturePuzzle then
			local top = m.CheckRedPoint(v.eventCfgId)

			if top then
				return true
			end
		end
	end

	return false
end

function m.CheckRedPoint(picturePuzzleID)
	if not ActiveOperationEventModule.CheckIsOpen(picturePuzzleID) then
		return false
	end

	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(picturePuzzleID)

	if operationEventDataPOD then
		m.ipData = operationEventDataPOD.ipData
	end

	local progressReward = m.GetProgressReward(picturePuzzleID)
	local progressState = progressReward[1]
	local openNum = 0

	if m.ipData then
		openNum = #m.ipData.unlockedPlace
	end

	local openNum = m.GetPictureUnlockPlace(picturePuzzleID)

	if progressState > m.GetMaxProgressStatus(picturePuzzleID) and openNum >= progressReward[1] then
		return true
	end

	local rewardTab = m.GetPuzzleRewards(picturePuzzleID)

	for i = 1, #rewardTab do
		local cfgPuzzleReward = rewardTab[i]

		if cfgPuzzleReward then
			local state = m.GetPicRewardState(picturePuzzleID, cfgPuzzleReward.Id)

			if state == 2 then
				return true
			end
		end
	end

	local count, totalCount = m.GetCompletedProgress(picturePuzzleID)

	if count < totalCount then
		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.PUZZLE_PIECES)
		local eventPOD = ActiveOperationEventModule.GetActiveOperationData(picturePuzzleID)

		if eventPOD then
			local cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[eventPOD.dataCfgId]
			local nextOpen = openNum + 1

			if nextOpen > #cfgPuzzlesGlobal.UnlockCost then
				nextOpen = #cfgPuzzlesGlobal.UnlockCost
			end

			local needNum = cfgPuzzlesGlobal.UnlockCost[nextOpen]

			if needNum <= have then
				return true
			end
		end
	end

	return false
end

function m.GetPicturePuzzleTaskData(TypeParam)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.PICTURE_PUZZLE_TASK, TypeParam)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.PICTURE_PUZZLE_TASK, TypeParam)

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

	return ret, processing, finished
end

function m.ImagePuzzleGetUnlockReward(picturePuzzleID, cfgPuzzleRewardID)
	net_operationsImagePuzzle.imagePuzzleGetReward(picturePuzzleID, cfgPuzzleRewardID)
end

function m.ImagePuzzleGetReward(picturePuzzleID)
	local idx = m.GetMaxProgressStatus(picturePuzzleID)
	local max = m.GetMaxProgress(picturePuzzleID)

	if max <= idx then
		return
	end

	net_operationsImagePuzzle.imagePuzzleGetUnlockReward(picturePuzzleID, idx)
end

function m.ImagePuzzleUnlock(picturePuzzleID)
	net_operationsImagePuzzle.imagePuzzleUnlock(picturePuzzleID)
end

function m.ImagePuzzleUnlockResult(pod)
	ActiveOperationEventModule.UpdateOperationEventData(pod)
	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.ImagePuzzleGetUnlockRewardResult(list, pod)
	if #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end

	ActiveOperationEventModule.UpdateOperationEventData(pod)
	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.ImagePuzzleGetRewardResult(list, pod)
	if #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end

	ActiveOperationEventModule.UpdateOperationEventData(pod)
	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

ActivePicturePuzzleModule = m
