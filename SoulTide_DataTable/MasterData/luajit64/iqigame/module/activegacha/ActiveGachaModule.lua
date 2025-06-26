-- chunkname: @IQIGame\\Module\\ActiveGacha\\ActiveGachaModule.lua

ActiveGachaModule = {
	__GachaDrawCallbackList = {}
}

function ActiveGachaModule.Reload()
	return
end

function ActiveGachaModule.SendDraw(eventId, callback)
	table.insert(ActiveGachaModule.__GachaDrawCallbackList, callback)
	net_operationsGachaPool.draw(eventId)
end

function ActiveGachaModule.OnDrawResult(code, awardsId, itemShowPODList, operationEventDataPOD)
	ActiveOperationEventModule.UpdateOperationEventData(operationEventDataPOD)

	if #ActiveGachaModule.__GachaDrawCallbackList > 0 then
		local callback = ActiveGachaModule.__GachaDrawCallbackList[1]

		table.remove(ActiveGachaModule.__GachaDrawCallbackList, 1)
		callback(awardsId, itemShowPODList, operationEventDataPOD)
	end

	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function ActiveGachaModule.Refresh(eventId)
	net_operationsGachaPool.refresh(eventId)
end

function ActiveGachaModule.RefreshResult(pod)
	ActiveOperationEventModule.UpdateOperationEventData(pod)
	EventDispatcher.Dispatch(EventID.UpdateGachaRefreshEvent)
end

function ActiveGachaModule.GetDrawCost()
	local operationEventControlCid = 211104001
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(operationEventControlCid)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operationEventControlCid)

	if eventPOD == nil or operationEventDataPOD == nil then
		return -1, 0
	end

	local cfgGachaPoolGlobalData = CfgGachaPoolGlobalTable[eventPOD.dataCfgId]

	if cfgGachaPoolGlobalData == nil then
		return -1, 0
	end

	local drawCount = #operationEventDataPOD.gachaPoolData.getAwards

	if drawCount >= #cfgGachaPoolGlobalData.Rewards then
		return -1, 0
	end

	local drawDataIndex = drawCount + 1
	local itemCid = 0
	local itemNum = 0

	if #cfgGachaPoolGlobalData.CostItem > 0 then
		itemCid = cfgGachaPoolGlobalData.CostItem[drawDataIndex]
		itemNum = cfgGachaPoolGlobalData.CostNum[drawDataIndex]
	else
		itemCid = Constant.ItemID.ID_PAYPOINT_SHOW
		itemNum = cfgGachaPoolGlobalData.payPoint[drawDataIndex]
	end

	return itemCid, itemNum
end

function ActiveGachaModule.ShowRedPoint()
	local itemCid, itemNum = ActiveGachaModule.GetDrawCost()

	return itemCid ~= -1 and itemNum == 0
end

function ActiveGachaModule.Shutdown()
	ActiveGachaModule.__GachaDrawCallbackList = {}
end
