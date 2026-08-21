-- chunkname: @IQIGame\\Module\\Church\\ChurchModule.lua

ChurchModule = {}

function ChurchModule.ReloadData(data)
	ChurchModule.exchangeRecords = data
end

function ChurchModule.GetExchangeTimes(cfgExchangeData)
	local count = 0

	if ChurchModule.exchangeRecords ~= nil and ChurchModule.exchangeRecords[cfgExchangeData.Id] ~= nil then
		count = ChurchModule.exchangeRecords[cfgExchangeData.Id]
	end

	return count
end

function ChurchModule.GetExchangeInfo(cfgExchangeData)
	local count = ChurchModule.GetExchangeTimes(cfgExchangeData)
	local leftCount = -1

	if cfgExchangeData.Limit > 0 then
		leftCount = cfgExchangeData.Limit - count

		if leftCount < 0 then
			leftCount = 0
		end
	end

	local nextIndex = count + 1

	if cfgExchangeData.Limit > 0 then
		if nextIndex > cfgExchangeData.Limit then
			nextIndex = cfgExchangeData.Limit
		end
	else
		local costLength = 0

		for i = 1, #cfgExchangeData.CostItems do
			local costItemCidNum = cfgExchangeData.CostItems[i]

			if #costItemCidNum > 0 then
				costLength = costLength + 1
			end
		end

		if costLength < nextIndex then
			nextIndex = costLength
		end
	end

	local costItemCid = cfgExchangeData.CostItems[nextIndex][1]
	local costItemNum = cfgExchangeData.CostItems[nextIndex][2]

	return leftCount, costItemCid, costItemNum, nextIndex
end

function ChurchModule.SendExchangeMsg(cid, count)
	ChurchModule.lastExchangeCid = cid

	net_item.exchange(cid, count)
end

function ChurchModule.ResponseExchangeMsg(success, showItems, exchangeRecords, critMultiple)
	if ChurchModule.lastExchangeCid ~= nil then
		local cfgExchangeData = CfgExchangeTable[ChurchModule.lastExchangeCid]

		if cfgExchangeData.Type == 4 then
			EventDispatcher.Dispatch(EventID.EquipComposeSuccess)

			return
		end
	end

	ChurchModule.exchangeRecords = exchangeRecords

	EventDispatcher.Dispatch(EventID.ExChangeItemSuccessEvent, {
		success = success,
		showItems = showItems,
		exchangeRecords = exchangeRecords,
		critMultiple = critMultiple
	})
end

function ChurchModule.SendBatchExchangeMsg(id2CountDic)
	net_item.exchangeBatch(id2CountDic)
end

function ChurchModule.OnSendBatchExchangeMsgResult(successInfo, showItems, exchangeRecords)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, showItems)
	EventDispatcher.Dispatch(EventID.BatchExchangeSuccess)
end

function ChurchModule.NotifyExchangeRecords(exchangeRecords)
	ChurchModule.exchangeRecords = exchangeRecords

	EventDispatcher.Dispatch(EventID.UpdateExChangeEvent)
end
