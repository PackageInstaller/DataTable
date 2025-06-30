-- chunkname: @IQIGame\\Module\\Active\\FurnitureGashapon\\FurnitureGashaponModule.lua

FurnitureGashaponModule = {}

function FurnitureGashaponModule.Reload()
	FurnitureGashaponModule.gachaIdList = {}

	for i, v in pairsCfg(CfgOperateEventsControlTable) do
		if v.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon then
			local eventID = v.Id

			if not ActiveOperationEventModule.CheckIsOpen(eventID) then
				return
			end

			local pod = ActiveOperationEventModule.GetEventDataPOD(eventID)

			if pod.furnitureGachaDataPOD ~= nil then
				FurnitureGashaponModule.gachaCount = pod.furnitureGachaDataPOD.gachaCount
				FurnitureGashaponModule.gachaIdList = pod.furnitureGachaDataPOD.gachaIdList
			end

			break
		end
	end

	if FurnitureGashaponModule.gachaCount == nil then
		FurnitureGashaponModule.gachaCount = 0
	end

	if FurnitureGashaponModule.gachaIdList == nil then
		FurnitureGashaponModule.gachaIdList = {}
	end
end

function FurnitureGashaponModule.Shutdown()
	FurnitureGashaponModule.eventID = nil
end

function FurnitureGashaponModule.OnNotifyUpdate()
	FurnitureGashaponModule.Reload()
end

function FurnitureGashaponModule.CheckRedPoint(viewID)
	if not ActiveOperationEventModule.CheckIsOpen(viewID) then
		return false
	end

	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(viewID)

	if not operationEventDataPOD then
		return false
	end

	local cfgFurLotteryData = CfgFurnitureActivityLotteryGlobalTable[operationEventDataPOD.dataCfgId]

	if FurnitureGashaponModule.gachaCount >= cfgFurLotteryData.MaxTimes then
		return false
	end

	if WarehouseModule.GetItemNumByCfgID(cfgFurLotteryData.Cost1[1]) < cfgFurLotteryData.Cost1[2] and WarehouseModule.GetItemNumByCfgID(cfgFurLotteryData.Cost10[1]) < cfgFurLotteryData.Cost10[2] then
		return false
	end

	return true
end

function FurnitureGashaponModule.CheckRedPointByType()
	for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
		local cfg = CfgOperateEventsControlTable[v.eventCfgId]

		if cfg.Type == Constant.Activity_Operation_Type.Activity_FurnitureGashapon and FurnitureGashaponModule.CheckRedPoint(v.eventCfgId) then
			return true
		end
	end

	return false
end

function FurnitureGashaponModule.CheckisGotFurniture(cid)
	for i, v in pairs(FurnitureGashaponModule.gachaIdList) do
		if cid == v then
			return true
		end
	end

	return false
end

function FurnitureGashaponModule.ReqDraw(eventID, type)
	FurnitureGashaponModule.eventID = eventID
	FurnitureGashaponModule.lastDrawType = type

	net_operationsFurnitureGache.draw(eventID, type)
end

function FurnitureGashaponModule.OnDrawResult(showList)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(FurnitureGashaponModule.eventID)
	local cfgFurLotteryData = CfgFurnitureActivityLotteryGlobalTable[operationEventDataPOD.dataCfgId]

	if cfgFurLotteryData.ShowType == 2 then
		UIModule.Open(Constant.UIControllerName.DailyActivityEffectUI, Constant.UILayer.UI, showList)
	else
		UIModule.Open(Constant.UIControllerName.ActivityFurnitureGashaponUI, Constant.UILayer.UI, {
			FurnitureGashaponModule.lastDrawType,
			showList
		})
	end

	FurnitureGashaponModule.eventID = nil
end
