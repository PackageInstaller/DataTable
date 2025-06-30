-- chunkname: @IQIGame\\Module\\ActivityTurn\\ActivityTurnModule.lua

ActivityTurnModule = {
	turnTimes = 0
}

function ActivityTurnModule.Reload()
	ActivityTurnModule.AddListeners()
end

function ActivityTurnModule.AddListeners()
	return
end

function ActivityTurnModule.RemoveListeners()
	return
end

function ActivityTurnModule.GetHelpNewbiesDataPOD()
	ActivityTurnModule.turntableDataPOD = nil

	local openActiveID = ActivityTurnModule.GetOpenTurnActive()

	if openActiveID ~= nil then
		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(openActiveID)

		if operationEventDataPOD then
			ActivityTurnModule.turntableDataPOD = operationEventDataPOD.turntableDataPOD
		end
	end

	return ActivityTurnModule.turntableDataPOD
end

function ActivityTurnModule.GetOpenTurnActive()
	local openActiveID
	local openOperationEvent = ActiveOperationEventModule.GetOpenOperationEvent()

	if #openOperationEvent and CfgDiscreteDataTable[6520061].Data[1] == 0 then
		for i = 1, #openOperationEvent do
			local eventID = openOperationEvent[i]

			if CfgOperateEventsControlTable[eventID].Type == Constant.Activity_Operation_Type.Activity_Turn then
				openActiveID = eventID

				break
			end
		end
	end

	return openActiveID
end

function ActivityTurnModule.CheckAllTurnRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_Turn then
				local top = ActivityTurnModule.CheckRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function ActivityTurnModule.Shutdown()
	ActivityTurnModule.RemoveListeners()
end

function ActivityTurnModule.CheckRedPoint(operateEventID)
	if ActiveOperationEventModule.CheckIsOpen(operateEventID) then
		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

		if operationEventDataPOD and operationEventDataPOD.dataCfgId > 0 then
			local cfgActiveTurntableGlobalData = CfgActiveTurntableGlobalTable[operationEventDataPOD.dataCfgId]
			local freeCount = 0

			if operationEventDataPOD.turntableDataPOD then
				freeCount = cfgActiveTurntableGlobalData.DailyFreeChance - operationEventDataPOD.turntableDataPOD.dailyFreeDrawCount
			end

			local haveItemNum = WarehouseModule.GetItemNumByCfgID(cfgActiveTurntableGlobalData.CostItem)

			return freeCount > 0 or haveItemNum >= cfgActiveTurntableGlobalData.CostNum
		end
	end

	return false
end

function ActivityTurnModule.EnterActive()
	ActivityTurnModule.items = {}

	local openActiveID = ActivityTurnModule.GetOpenTurnActive()

	if openActiveID ~= nil then
		local eventPOD = ActiveOperationEventModule.GetActiveOperationData(openActiveID)

		if eventPOD then
			local itemId = 0
			local itemCount = 0
			local cfgActiveTurntableGlobalData = CfgActiveTurntableGlobalTable[eventPOD.dataCfgId]

			for i = 1, #cfgActiveTurntableGlobalData.Rewards do
				local cid = cfgActiveTurntableGlobalData.Rewards[i]
				local cfgActiveTurntableData = CfgActiveTurntableTable[cid]

				itemId = cfgActiveTurntableData.Reward[1]
				itemCount = cfgActiveTurntableData.Reward[2]
				ActivityTurnModule.items[i] = {
					id = itemId,
					count = itemCount,
					rare = cfgActiveTurntableData.Rare
				}
			end

			net_centerEventTurnTable.getTurntableLogInfo(openActiveID)
		end
	end
end

function ActivityTurnModule.Draw(eventID)
	net_operationsTurntable.draw(eventID)

	ActivityTurnModule.rewardIndex = nil
	ActivityTurnModule.uuid = nil
end

function ActivityTurnModule.ReceiveRewardInfo(eventId, name, phone, address)
	net_centerEventTurnTable.reciveRewardInfo(eventId, ActivityTurnModule.uuid, name, phone, address)
end

function ActivityTurnModule.getTurntableLogInfoResult(recordList)
	ActivityTurnModule.records = {}

	for i, v in pairs(recordList) do
		local itemId = 0
		local itemCount = 0

		for id, count in pairs(v.goods) do
			itemId = id
			itemCount = count
		end

		ActivityTurnModule.records[i] = ActivityUIApi:GetString("turn_txtRecord", v.rare, v.pname, itemId, itemCount)
	end

	EventDispatcher.Dispatch(EventID.UpdateTurnEvent)
end

function ActivityTurnModule.DrawResult(turntableId, uuid)
	ActivityTurnModule.rewardIndex = turntableId
	ActivityTurnModule.uuid = uuid

	EventDispatcher.Dispatch(EventID.TurnResultEvent)
end

function ActivityTurnModule.ReceiveRewardInfoResult()
	EventDispatcher.Dispatch(EventID.TurnRewardInfoResult)
end

function ActivityTurnModule.getCharLength(str)
	str = str or ""

	local strLength = 0
	local len = string.len(str)

	while str do
		local fontUTF = string.byte(str, 1)

		if fontUTF == nil then
			break
		end

		if fontUTF > 127 then
			local tmp = string.sub(str, 1, 3)

			strLength = strLength + 1
			str = string.sub(str, 4, len)
		else
			local tmp = string.sub(str, 1, 1)

			strLength = strLength + 1
			str = string.sub(str, 2, len)
		end
	end

	return strLength
end

function ActivityTurnModule:CheckIsMobile(str)
	return string.match(str, "[1][3,4,5,7,8]%d%d%d%d%d%d%d%d%d") == str
end
