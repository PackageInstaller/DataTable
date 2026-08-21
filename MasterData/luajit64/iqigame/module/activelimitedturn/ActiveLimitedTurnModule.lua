-- chunkname: @IQIGame\\Module\\ActiveLimitedTurn\\ActiveLimitedTurnModule.lua

local m = {}
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function m.Reload()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.CheckAllLimitedTurnRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_Limited_Turn then
				local top = m.CheckLimitedTurnRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckLimitedTurnRedPoint(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		local taskData = m.GetTaskDataList()

		for i, v in pairs(taskData) do
			if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
				return true
			end
		end

		local have, needNum = m.GetCostItemNum(operateEventID)

		return needNum <= have
	end

	return false
end

function m.GetCfgData(operateEventID)
	local tab = {}
	local operationEventDataPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

	if operationEventDataPOD then
		local cfgTurntableGlobal = CfgLimitedTurntableGlobalTable[operationEventDataPOD.dataCfgId]

		for i, v in pairsCfg(CfgLimitedTurntableGroupTable) do
			if v.Group == cfgTurntableGlobal.RewardsGroup then
				table.insert(tab, v)
			end
		end

		table.sort(tab, function(a, b)
			return a.Sort < b.Sort
		end)
	end

	return tab
end

function m.GetCostItemNum(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		local cfgGlobalData = CfgLimitedTurntableGlobalTable[operationEventDataPOD.dataCfgId]

		return WarehouseModule.GetItemNumByCfgID(cfgGlobalData.CostItem), cfgGlobalData.CostNum, cfgGlobalData.CostItem
	end

	return 0, 0, 0
end

function m.HaveLimitedReward(operateEventID)
	local limitedTurntableGroup = m.GetCfgData(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	for i = 1, #limitedTurntableGroup do
		local cfgData = limitedTurntableGroup[i]

		if cfgData.TotalLimit > 0 then
			local getNum = 0

			if operationEventDataPOD.limitTurnTableDataPOD then
				getNum = operationEventDataPOD.limitTurnTableDataPOD.getAwards[cfgData.Id]

				if getNum == nil then
					getNum = 0
				end
			end

			if getNum < cfgData.TotalLimit then
				return true
			end
		end
	end

	return false
end

function m.GetProbability(operateEventID, cid)
	local limitedTurntableGroup = m.GetCfgData(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)
	local totalOdds = 0
	local currentOdds = 0

	for i = 1, #limitedTurntableGroup do
		local getNum = 0
		local cfgData = limitedTurntableGroup[i]

		if cfgData.TotalLimit < 0 then
			totalOdds = totalOdds + cfgData.Odds
		else
			if operationEventDataPOD.limitTurnTableDataPOD then
				getNum = operationEventDataPOD.limitTurnTableDataPOD.getAwards[cfgData.Id]

				if getNum == nil then
					getNum = 0
				end
			end

			if getNum < cfgData.TotalLimit then
				totalOdds = totalOdds + cfgData.Odds
			end
		end

		if cfgData.Id == cid then
			currentOdds = cfgData.TotalLimit > 0 and getNum >= cfgData.TotalLimit and 0 or cfgData.Odds
		end
	end

	return string.format("%0.2f", currentOdds / totalOdds * 100)
end

function m.GetTaskDataList()
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.LIMITED_TURNTABLE_TASK, {
		1
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.LIMITED_TURNTABLE_TASK, {
		1
	})
	local processing1 = TaskModule.GetTaskProcessing(TaskModule.TaskType.LIMITED_TURNTABLE_TASK, {
		2
	})
	local finished1 = TaskModule.GetTaskFinished(TaskModule.TaskType.LIMITED_TURNTABLE_TASK, {
		2
	})

	for i, v in pairs(processing1) do
		table.insert(processing, v)
	end

	for i, v in pairs(finished1) do
		table.insert(finished, v)
	end

	for i = 1, #processing do
		local taskData = processing[i]
		local taskUIData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(taskUIDataList, taskUIData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgMainQuestData = CfgMainQuestTable[taskCid]

		if cfgMainQuestData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
			local taskUIData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(taskUIDataList, taskUIData)
		end
	end

	return taskUIDataList
end

function m.Shutdown()
	m.RemoveListeners()

	m.getHistoryCallBack = nil
	m.limitedDrawCallBack = nil
end

function m.Draw(eventId, type, callBack)
	m.limitedDrawCallBack = callBack

	net_operationsLimitTurntable.draw(eventId, type)
end

function m.GetHistory(eventId, callBack)
	m.getHistoryCallBack = callBack

	net_operationsLimitTurntable.getHistory(eventId)
end

function m.DrawResult(awardsId, list, pod)
	ActiveOperationEventModule.UpdateOperationEventData(pod)

	if m.limitedDrawCallBack then
		m.limitedDrawCallBack(awardsId, list, pod)
	elseif #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end

	m.limitedDrawCallBack = nil
end

function m.GetHistoryResult(history)
	if m.getHistoryCallBack then
		m.getHistoryCallBack(history)
	end

	m.getHistoryCallBack = nil
end

ActiveLimitedTurnModule = m
