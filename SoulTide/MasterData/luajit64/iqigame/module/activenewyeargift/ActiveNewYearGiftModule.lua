-- chunkname: @IQIGame\\Module\\ActiveNewYearGift\\ActiveNewYearGiftModule.lua

local m = {}

function m.Reload()
	return
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetNewYearGiftExchangeCount(operateEventID, cfgID)
	local exchangeNum = 0
	local maxNum = CfgTreasureHuntGiftListTable[cfgID].LimitTime
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		m.tsData = operationEventDataPOD.treasureHuntDataPOD

		if m.tsData and m.tsData.exchangeGiftRecords then
			exchangeNum = m.tsData.exchangeGiftRecords[cfgID]

			if exchangeNum == nil then
				exchangeNum = 0
			end
		end
	end

	return exchangeNum, maxNum
end

function m.GetNewYearGiftState(operateEventID, cfgID)
	local state = 1
	local cfgNewYearGift = CfgTreasureHuntGiftListTable[cfgID]
	local exchangeNum, maxNum = m.GetNewYearGiftExchangeCount(operateEventID, cfgID)

	if maxNum <= exchangeNum then
		state = 3
	else
		for i = 1, #cfgNewYearGift.NeedItem, 2 do
			local needID = cfgNewYearGift.NeedItem[i]
			local needNum = cfgNewYearGift.NeedItem[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(needID)

			if haveNum < needNum then
				state = 2

				break
			end
		end
	end

	return state
end

function m.CheckAllNewYearGiftRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_NewYear_Gift then
				local top = m.CheckNewYearGiftRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckNewYearGiftRedPoint(operateEventID)
	if ActiveOperationEventModule.CheckIsOpen(operateEventID) then
		local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

		if operationEventDataPOD and operationEventDataPOD.dataCfgId > 0 then
			local cfgNewYearGiftGlobal = CfgTreasureHuntGlobalTable[operationEventDataPOD.dataCfgId]

			for i, v in pairsCfg(CfgTreasureHuntGiftListTable) do
				if v.Team == cfgNewYearGiftGlobal.Id then
					local state = m.GetNewYearGiftState(operateEventID, v.Id)

					if state == 1 then
						return true
					end
				end
			end
		end
	end

	return false
end

function m.Shutdown()
	return
end

function m.ExchangeTreasureGift(eventId, giftId)
	net_operationsTreasureHunt.exchangeTreasureGift(eventId, giftId)
end

function m.ExchangeTreasureGiftResult(list)
	if #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end
end

ActiveNewYearGiftModule = m
