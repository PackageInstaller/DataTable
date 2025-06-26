-- chunkname: @IQIGame\\Module\\Fishing\\FishingModule.lua

local m = {
	isFishing = false,
	isAutoFish = false,
	specimenData = {}
}

function m.Reload(fishingData)
	m.fishingData = fishingData

	if fishingData and fishingData.specimenData then
		m.specimenData = fishingData.specimenData
		m.isAutoFish = false

		if fishingData.countdown / 1000 > PlayerModule.GetServerTime() then
			m.isAutoFish = true
		end
	end

	m.autoFishTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Fishing, function()
		m.AutoFishTimerUpdate()
	end, 1, -1)

	m.ResetFishTimer()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.ResetFishTimer()
	m.autoFishTimer:Stop()

	if m.isAutoFish then
		m.autoFishTimer:Start()
	end
end

function m.AutoFishTimerUpdate()
	if m.fishingData.countdown / 1000 - PlayerModule.GetServerTime() < 0 then
		m.autoFishTimer:Stop()

		m.fishingData.state = true
		m.isAutoFish = false

		EventDispatcher.Dispatch(EventID.UpdateAutoFishStateEvent)
	end
end

function m.IsFishingUseItem(cfgItemData)
	return cfgItemData.Type == 2 and (cfgItemData.SubType == Constant.ItemSubType.Fish or cfgItemData.SubType == Constant.ItemSubType.Fish_Sundries or cfgItemData.SubType == Constant.ItemSubType.Fish_Bait)
end

function m.GetFishItems(ItemTabs, subTypes)
	local result = {}
	local items = WarehouseModule.GetItemsByTabs(ItemTabs, false)

	for i = 1, #items do
		local itemData = items[i]
		local cfgItemData = itemData:GetCfg()

		if table.indexOf(subTypes, cfgItemData.SubType) ~= -1 then
			table.insert(result, itemData)
		end
	end

	table.sort(result, function(itemData1, itemData2)
		return itemData1:GetCfg().Sort < itemData2:GetCfg().Sort
	end)

	return result
end

function m.GetFishGearAddEffectValue(cfgFishGear, effectType)
	local value = 0

	if cfgFishGear then
		for i = 1, #cfgFishGear.EffectType do
			local type = cfgFishGear.EffectType[i]

			if type == effectType then
				local parameters = cfgFishGear.EffectParameter[i]

				for j = 1, #parameters do
					value = value + parameters[j]
				end
			end
		end
	end

	return value
end

function m.CheckResumeFishing()
	if HomeLandLuaModule.isVisitHome then
		return
	end

	if m.fishingData and m.fishingData.fishId > 0 and m.fishingData.rodId > 0 and m.fishingData.baitId > 0 then
		m.isFishing = true

		UIModule.Open(Constant.UIControllerName.HomeLandFishUI, Constant.UILayer.UI, {
			openType = 2
		})
	end
end

function m.CheckAutoFishRed()
	if m.fishingData then
		return m.fishingData.state
	end

	return false
end

function m.Shutdown()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.Fishing)
	m.RemoveListeners()

	m.fishingData = nil
	m.isFishing = false
end

function m.Fishing(rodId, baitItemId)
	m.isFishing = true

	net_fishing.fishing(rodId, baitItemId)
end

function m.FishingConfirm(suc)
	if suc then
		NoticeModule.ShowNotice(21042039)
	else
		NoticeModule.ShowNotice(21042040)
	end

	net_fishing.fishingConfirm(suc)
end

function m.IllegalFishing(toolId, num)
	net_fishing.illegalFishing(toolId, num)
end

function m.ExchangeFish(itemData, num)
	if itemData:GetCfg().Type == 2 and (itemData:GetCfg().SubType == 40 or itemData:GetCfg().SubType == 41) then
		net_fishing.exchangeFish(itemData.cid, num)
	else
		ItemModule.UseItem(itemData, num)
	end
end

function m.ExchangeFishByType(type)
	net_fishing.exchangeFishByType(type)
end

function m.AutomaticFishing(rodId, baitItemId)
	net_fishing.automaticFishing(rodId, baitItemId)
end

function m.DrawRewards()
	net_fishing.drawRewards()
end

function m.FishingResult(fishId, baitId, rodId)
	local cfgRod, cfgBait

	for i, v in pairsCfg(CfgFishingGearListTable) do
		if v.ItemID == rodId then
			cfgRod = v
		elseif v.ItemID == baitId then
			cfgBait = v
		end
	end

	EventDispatcher.Dispatch(EventID.StartGoFishEvent, cfgRod, cfgBait, fishId)
end

function m.FishingConfirmResult(pod)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, {
		pod
	})

	if pod then
		for j, k in pairsCfg(CfgFishListTable) do
			if k.ItemID == pod.cid then
				if m.specimenData[k.Id] == nil then
					m.specimenData[k.Id] = pod.num
				else
					m.specimenData[k.Id] = m.specimenData[k.Id] + pod.num
				end
			end
		end
	end

	if m.fishingData then
		m.fishingData.fishId = 0
		m.fishingData.rodId = 0
		m.fishingData.baitId = 0
	end

	m.isFishing = false
end

function m.IllegalFishingResult(podList)
	if #podList > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, podList)
	end

	for i, v in ipairs(podList) do
		for j, k in pairsCfg(CfgFishListTable) do
			if k.ItemID == v.cid then
				if m.specimenData[k.Id] == nil then
					m.specimenData[k.Id] = v.num
				else
					m.specimenData[k.Id] = m.specimenData[k.Id] + v.num
				end
			end
		end
	end
end

function m.ExchangeFishResult(podList)
	if #podList > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, podList)
	end
end

function m.NotifyFishSpecimen(newSpecimenList)
	for i, v in pairs(newSpecimenList) do
		NoticeModule.NotifyClientEffectNotice(Constant.ClientEffectTypeID.TYPE_UNLOCK_FISH, {
			v
		})
	end
end

function m.ExchangeFishByTypeResult(podList)
	if #podList > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, podList)
	end
end

function m.AutomaticFishingResult(time)
	m.fishingData.countdown = time
	m.isAutoFish = m.fishingData.countdown / 1000 - PlayerModule.GetServerTime() > 0

	m.ResetFishTimer()
	EventDispatcher.Dispatch(EventID.UpdateAutoFishStateEvent)
end

function m.DrawRewardsResult(podList)
	if #podList > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, podList)
	end

	for i, v in ipairs(podList) do
		for j, k in pairsCfg(CfgFishListTable) do
			if k.ItemID == v.cid then
				if m.specimenData[k.Id] == nil then
					m.specimenData[k.Id] = v.num
				else
					m.specimenData[k.Id] = m.specimenData[k.Id] + v.num
				end
			end
		end
	end

	m.fishingData.state = false

	EventDispatcher.Dispatch(EventID.UpdateAutoFishStateEvent)
end

function m.NotifyFishOpen(fishingData)
	m.fishingData = fishingData

	if fishingData and fishingData.specimenData then
		m.specimenData = fishingData.specimenData
		m.isAutoFish = false

		if fishingData.countdown / 1000 > PlayerModule.GetServerTime() then
			m.isAutoFish = true
		end
	end
end

FishingModule = m
