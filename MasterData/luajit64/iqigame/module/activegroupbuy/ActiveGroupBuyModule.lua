-- chunkname: @IQIGame\\Module\\ActiveGroupBuy\\ActiveGroupBuyModule.lua

local m = {}

function m.Reload()
	return
end

function m.GetServerBuyCount(groupBuyPackCID, eventCfgId)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(eventCfgId)
	local buyCount, totalCount

	if operationEventDataPOD then
		m.gpData = operationEventDataPOD.gpData

		if m.gpData and m.gpData.buyCount then
			buyCount = m.gpData.buyCount[groupBuyPackCID]
		end
	end

	if m.commonDataPOD and m.commonDataPOD.totalCount then
		totalCount = m.commonDataPOD.totalCount[groupBuyPackCID]
	end

	if buyCount == nil then
		buyCount = 0
	end

	if totalCount == nil then
		totalCount = 0
	end

	return buyCount, totalCount
end

function m.GetDiscountData(groupBuyPackCID, eventCfgId)
	local currentDiscountData, nextDiscountData
	local index = 0
	local buyCount, totalCount = ActiveGroupBuyModule.GetServerBuyCount(groupBuyPackCID, eventCfgId)
	local cfgBuyPack = CfgGroupBuyPackTable[groupBuyPackCID]

	for i = 1, #cfgBuyPack.Discount do
		local data = cfgBuyPack.Discount[i]
		local count = data[2]

		if count <= totalCount then
			index = i
			currentDiscountData = data
		elseif nextDiscountData == nil then
			nextDiscountData = data
		end
	end

	if nextDiscountData == nil then
		nextDiscountData = cfgBuyPack.Discount[#cfgBuyPack.Discount]
	end

	return currentDiscountData, nextDiscountData, index
end

function m.GetTotalRebate(groupBuyID)
	local tab = {}
	local OperationEventPOD = ActiveOperationEventModule.GetActiveOperationData(groupBuyID)

	if OperationEventPOD then
		local cfgGroupBuyGlobal = CfgGroupBuyGlobalTable[OperationEventPOD.dataCfgId]

		for i, v in pairs(cfgGroupBuyGlobal.Items) do
			local cfgGroupBuyPack = CfgGroupBuyPackTable[v]
			local buyCount, totalCount = m.GetServerBuyCount(v, groupBuyID)
			local currentData, nextData = m.GetDiscountData(v, groupBuyID)
			local spendID = 0
			local spendNum = 0

			if cfgGroupBuyPack.payPoint > 0 then
				spendID = Constant.ItemID.ID_PAYPOINT_SHOW
				spendNum = cfgGroupBuyPack.payPoint
			elseif #cfgGroupBuyPack.Price > 0 then
				spendID = cfgGroupBuyPack.Price[1]
				spendNum = cfgGroupBuyPack.Price[2]
			end

			if currentData then
				local num = spendNum * buyCount * currentData[1]

				if tab[spendID] == nil then
					tab[spendID] = 0
				end

				tab[spendID] = tab[spendID] + num
			end
		end
	end

	return tab
end

function m.Shutdown()
	return
end

function m.GroupPurchaseBuy(eventId, idx, num)
	m.groupBuyID = eventId

	net_operationsGroupPurchase.groupPurchaseBuy(eventId, idx, num)
end

function m.GetGroupPurchaseCommonData(cfgId)
	net_centerEventGroupPurchase.getGroupPurchaseCommonData(cfgId)
end

function m.GetGroupPurchaseCommonDataResult(pod)
	m.commonDataPOD = pod

	EventDispatcher.Dispatch(EventID.UpdateOperationsEvent)
end

function m.GroupPurchaseBuyResult(list, pod)
	ActiveOperationEventModule.UpdateOperationEventData(pod)

	if #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end

	ActiveGroupBuyModule.GetGroupPurchaseCommonData(m.groupBuyID)

	m.groupBuyID = nil
end

ActiveGroupBuyModule = m
