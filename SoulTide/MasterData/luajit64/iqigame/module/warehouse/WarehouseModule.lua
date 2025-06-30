-- chunkname: @IQIGame\\Module\\Warehouse\\WarehouseModule.lua

WarehouseModule = {}
WarehouseModule.AllItems = {}

function WarehouseModule.Reload(items)
	WarehouseModule.AllItems = {}

	for i, v in pairs(items) do
		WarehouseModule.AllItems[i] = ItemData.New(v)
	end
end

function WarehouseModule.Update(items)
	local itemInWarehouse, indexInWarehouse, itemFromServer
	local addItems = {}
	local deleteItems = {}
	local updateItems = {}

	for i = 1, #items do
		itemFromServer = items[i]
		itemInWarehouse, indexInWarehouse = WarehouseModule.FindItem(itemFromServer.id)

		if itemInWarehouse == nil then
			itemInWarehouse = ItemData.New(itemFromServer)

			table.insert(addItems, itemInWarehouse)
		elseif itemFromServer.num == nil or itemFromServer.num == 0 then
			table.insert(deleteItems, itemInWarehouse)
		else
			itemInWarehouse:Update(itemFromServer)

			WarehouseModule.AllItems[indexInWarehouse] = itemInWarehouse
		end

		table.insert(updateItems, itemInWarehouse)
	end

	for i = 1, #deleteItems do
		for j = #WarehouseModule.AllItems, 1, -1 do
			if WarehouseModule.AllItems[j].id == deleteItems[i].id then
				table.remove(WarehouseModule.AllItems, j)
			end
		end
	end

	for i = 1, #addItems do
		table.insert(WarehouseModule.AllItems, addItems[i])
	end

	if #addItems > 0 then
		EventDispatcher.Dispatch(EventID.AddItem, addItems)
	end

	if #deleteItems > 0 then
		EventDispatcher.Dispatch(EventID.DeleteItem, deleteItems)
	end

	if #updateItems > 0 then
		EventDispatcher.Dispatch(EventID.UpdateItem, updateItems)
	end
end

function WarehouseModule.FindItem(itemInstanceID)
	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].id == itemInstanceID then
			return WarehouseModule.AllItems[i], i
		end
	end

	return nil, -1
end

function WarehouseModule.GetItemNumByCfgID(cid, includeDebts)
	local num = 0

	if cid == Constant.ItemID.ID_PAYPOINT_SHOW then
		num = PlayerModule.PlayerInfo.baseInfo.payPoint
	elseif PlayerModule.PlayerInfo.numAttrs[cid] ~= nil then
		num = PlayerModule.PlayerInfo.numAttrs[cid]
	else
		for i = 1, #WarehouseModule.AllItems do
			if WarehouseModule.AllItems[i].cid == cid then
				num = num + WarehouseModule.AllItems[i].num
			end
		end
	end

	if includeDebts then
		local debt = PlayerModule.PlayerInfo.itemDebts[cid]

		if debt ~= nil then
			num = num - debt
		end
	end

	return num
end

function WarehouseModule.GetItemCIDNumMap(includeDebts)
	local map = {}

	map[Constant.ItemID.ID_PAYPOINT_SHOW] = PlayerModule.PlayerInfo.baseInfo.payPoint

	for cid, num in pairs(PlayerModule.PlayerInfo.numAttrs) do
		map[cid] = num
	end

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]
		local oldNum = map[itemData.cid]

		oldNum = oldNum or 0
		map[itemData.cid] = oldNum + itemData.num
	end

	if includeDebts then
		for cid, debt in pairs(PlayerModule.PlayerInfo.itemDebts) do
			map[cid] = -debt
		end
	end

	return map
end

function WarehouseModule.GetItemsByTab(tab, isWarehouseShow)
	isWarehouseShow = isWarehouseShow or false

	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.IsWarehouseShow == isWarehouseShow and cfgItemData.Tabs == tab then
			table.insert(items, itemData)
		end
	end

	return items
end

function WarehouseModule.GetItemsByTabs(tabs, isWarehouseShow)
	isWarehouseShow = isWarehouseShow or false

	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.IsWarehouseShow == isWarehouseShow and table.indexOf(tabs, cfgItemData.Tabs) ~= -1 then
			table.insert(items, itemData)
		end
	end

	return items
end

function WarehouseModule.GetItemsByType(type, excludeBagHide)
	local items = {}
	local itemData, cfgItemData

	for i = 1, #WarehouseModule.AllItems do
		itemData = WarehouseModule.AllItems[i]
		cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.Type == type and (not excludeBagHide or cfgItemData.IsWarehouseShow) then
			table.insert(items, itemData)
		end
	end

	return items
end

function WarehouseModule.GetItemDataById(id)
	for i, v in pairs(WarehouseModule.AllItems) do
		if v.id == id then
			return v
		end
	end

	return nil
end

function WarehouseModule.GetItemsByTypeAndSubType(type, subType)
	local items = {}
	local itemData, cfgItemData

	for i = 1, #WarehouseModule.AllItems do
		itemData = WarehouseModule.AllItems[i]
		cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.Type == type and cfgItemData.SubType == subType then
			table.insert(items, itemData)
		end
	end

	return items
end

function WarehouseModule.CheckCanUse(itemData, useNum)
	local cfgItemData = itemData:GetCfg()
	local expirationTime = cfgDateTimeToTimeStamp(cfgItemData.ExpirationTime, PlayerModule.TimeZone)
	local startTime = cfgDateTimeToTimeStamp(cfgItemData.StartTime, PlayerModule.TimeZone)

	if itemData:GetCD() > 0 then
		return false, WarehouseUIApi:GetString("NoticeUseCDText")
	end

	if startTime > PlayerModule.GetServerTime() then
		return false, WarehouseUIApi:GetString("NoticeUseNotActiveText")
	end

	if expirationTime ~= 0 and expirationTime < PlayerModule.GetServerTime() then
		return false, WarehouseUIApi:GetString("NoticeExpiredText")
	end

	local checkConsumeSucceed, errorMessage = WarehouseModule.CheckConsume(cfgItemData, useNum)

	if not checkConsumeSucceed then
		return checkConsumeSucceed, errorMessage
	end

	local isOk, errorMsg = ConditionModule.Check(cfgItemData.UseConditionID)

	if not isOk then
		local cfgConditionData = CfgConditionTable[cfgItemData.UseConditionID]

		errorMsg = WarehouseUIApi:GetString("UseItemCheckConditionFailText", cfgConditionData.Name)
	end

	return isOk, errorMsg
end

function WarehouseModule.CheckConsume(cfgItemData, useNum)
	if #cfgItemData.UseCostIDNum > 0 then
		for i = 1, #cfgItemData.UseCostIDNum, 2 do
			if WarehouseModule.GetItemNumByCfgID(cfgItemData.UseCostIDNum[i]) < cfgItemData.UseCostIDNum[i + 1] * useNum then
				return false, getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ITEM, CfgItemTable[cfgItemData.UseCostIDNum[i]].Name)
			end
		end
	end

	return true, nil
end

function WarehouseModule.GetItemDataByCfgID(cfgID)
	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].cid == cfgID then
			return WarehouseModule.AllItems[i]
		end
	end

	return nil
end

function WarehouseModule.GetCurrencyTable()
	local t = {}

	t[tostring(Constant.ItemID.MONEY)] = tostring(WarehouseModule.GetItemNumByCfgID(Constant.ItemID.MONEY))
	t[tostring(Constant.ItemID.TREASURE)] = tostring(WarehouseModule.GetItemNumByCfgID(Constant.ItemID.TREASURE))
	t[tostring(Constant.ItemID.ID_PAYPOINT_SHOW)] = tostring(PlayerModule.PlayerInfo.baseInfo.payPoint)

	return t
end

function WarehouseModule.CheckCurrencyCanBuy(cid)
	if cid == Constant.ItemID.ENERGY then
		return true
	end

	if cid == Constant.ItemID.TREASURE or cid == Constant.ItemID.ID_PAYPOINT_SHOW then
		local unlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MALL)

		return unlock
	end

	return false
end

function WarehouseModule.NeedShowRedPoint()
	return WarehouseModule.TabNeedShowRedPoint(Constant.ItemTab.GIFT)
end

function WarehouseModule.TabNeedShowRedPoint(tab)
	local items = WarehouseModule.GetItemsByTab(tab, true)

	for i = 1, #items do
		local canUse, errorMsg, ignoreRedPoint = ItemModule.CheckCanUse(items[i], 1)

		if canUse and not ignoreRedPoint then
			return true
		end
	end

	return false
end
