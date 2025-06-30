-- chunkname: @IQIGame\\Module\\Jewelry\\JewelryModule.lua

local m = {
	JewelryMaxStarLv = 5
}

function m.Reload()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetNewJewelryBagItemDataTab()
	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.Type == Constant.ItemType.JewelryEquip and cfgItemData.IsWear then
			table.insert(items, itemData)
		end
	end

	return items
end

function m.GetJewelryBagItemDataTab()
	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and (cfgItemData.Type == Constant.ItemType.Jewelry or cfgItemData.Type == Constant.ItemType.JewelryEquip) and cfgItemData.IsWear then
			table.insert(items, itemData)
		end
	end

	return items
end

function m.Shutdown()
	m.RemoveListeners()
end

function m.Wear(soulCid, cid, speed)
	net_jewelry.wear(soulCid, cid, speed)
end

function m.UnWear(soulCid)
	net_jewelry.unwear(soulCid)
end

function m.UpStar(soulCid)
	net_jewelry.upStar(soulCid)
end

function m.UpStarInBag(cid)
	net_jewelry.upStarInBag(cid)
end

function m.SetSpeed(soulCid, speed)
	local soulData = SoulModule.GetSoulData(soulCid)

	if #soulData:GetJewelryIds() > 0 then
		local maxSpeed = CfgItemTable[soulData:GetJewelryIds()[1]].SpeedLimit

		speed = maxSpeed < speed and maxSpeed or speed

		net_jewelry.setSpeed(soulCid, speed)
	end
end

function m.Recycle(cid, count)
	net_jewelry.recycle(cid, count)
end

function m.NewWear(soulPrefabId, id, speed)
	net_jewelry.newWear(soulPrefabId, id, speed)
end

function m.NewUnWear(soulPrefabId)
	net_jewelry.newUnWear(soulPrefabId)
end

function m.SetJewelrySpeed(prefabId, id, speed)
	net_jewelry.setJewelrySpeed(prefabId, id, speed)
end

function m.NewUpStar(id, use)
	net_jewelry.newUpStar(id, use)
end

function m.NewRecycle(id)
	net_jewelry.newRecycle(id)
end

function m.WearResult(soulCid, cid, speed)
	NoticeModule.ShowNotice(21045076)

	local soulData = SoulModule.GetSoulData(soulCid)

	soulData.jewelry[cid] = speed

	EventDispatcher.Dispatch(EventID.UpdateJewelryEvent, soulCid)
end

function m.UnWearResult(soulCid)
	NoticeModule.ShowNotice(21045077)

	local soulData = SoulModule.GetSoulData(soulCid)

	soulData.jewelry = {}

	UIModule.Close(Constant.UIControllerName.JewelryStrengthenUI)
	EventDispatcher.Dispatch(EventID.UpdateJewelryEvent, soulCid)
end

function m.UpStarResult(soulCid, newId)
	local soulData = SoulModule.soulDataDic[soulCid]
	local oldCid = soulData:GetJewelryIds()[1]
	local oldValue = soulData.jewelry[oldCid]

	soulData.jewelry[newId] = oldValue

	EventDispatcher.Dispatch(EventID.UpdateJewelryEvent, soulCid)
	EventDispatcher.Dispatch(EventID.JewelryUpStarEvent, false)
end

function m.UpStarInBagResult(cid)
	EventDispatcher.Dispatch(EventID.UpdateJewelryBagEvent, cid)
	EventDispatcher.Dispatch(EventID.JewelryUpStarEvent, true)
end

function m.SetSpeedResult(soulCid, speed)
	local soulData = SoulModule.soulDataDic[soulCid]
	local oldCid = soulData:GetJewelryIds()[1]

	soulData.jewelry[oldCid] = speed

	EventDispatcher.Dispatch(EventID.UpdateJewelryEvent, soulCid)
end

function m.RecycleResult(cid, getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end
end

function m.NewWearResult()
	return
end

function m.NewUnWearResult()
	return
end

function m.SetJewelrySpeedResult()
	return
end

function m.NewUpStarResult()
	EventDispatcher.Dispatch(EventID.JewelryUpStarEvent, false)
end

function m.NewRecycleResult(getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end
end

JewelryModule = m
