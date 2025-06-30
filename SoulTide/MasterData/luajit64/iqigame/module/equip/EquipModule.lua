-- chunkname: @IQIGame\\Module\\Equip\\EquipModule.lua

EquipModule = {
	index2SignTypeDic = {
		1,
		3,
		4,
		5
	},
	equipListUISort = {
		selectedIndex = 1,
		sortState = {
			true,
			true,
			true,
			true,
			true
		}
	},
	equipListUIScreen = {
		SignQuality = {
			false,
			false,
			false,
			false
		},
		SignClass = {
			false,
			false,
			false,
			false
		},
		SignWearState = {
			false,
			false
		},
		SignSkin = {
			false,
			false,
			false
		},
		SignStrengthen = {
			false,
			false,
			false
		}
	},
	_itemStarCfgQuality = {}
}

function EquipModule.ResetEquipListUISort()
	EquipModule.equipListUISort.selectedIndex = 1
	EquipModule.equipListUISort.sortState = {
		true,
		true,
		true,
		true,
		true
	}
end

function EquipModule.ResetEquipListUIScreen()
	EquipModule.equipListUIScreen.SignQuality = {
		false,
		false,
		false,
		false
	}
	EquipModule.equipListUIScreen.SignClass = {
		false,
		false,
		false,
		false
	}
	EquipModule.equipListUIScreen.SignWearState = {
		false,
		false
	}
	EquipModule.equipListUIScreen.SignSkin = {
		false,
		false,
		false
	}
	EquipModule.equipListUIScreen.SignStrengthen = {
		false,
		false,
		false
	}
end

function EquipModule.GetCurMaxLv(quality)
	local max = 1

	for i, v in pairsCfg(CfgSoulPaintingLvTable) do
		if v.PlayerLvl <= PlayerModule.PlayerInfo.baseInfo.pLv and quality >= v.RareLimit and max <= v.Lvl and v.BaseNeedExp ~= 0 then
			max = v.Lvl + 1
		end
	end

	return max
end

function EquipModule.GetMaxLv(quality)
	local max = 1

	for i, v in pairsCfg(CfgSoulPaintingLvTable) do
		if quality >= v.RareLimit and max <= v.Lvl and v.BaseNeedExp ~= 0 then
			max = v.Lvl + 1
		end
	end

	return math.min(PlayerModule.PlayerInfo.baseInfo.pLv, max)
end

function EquipModule.CheckReachedMaxLv(lv, quality)
	return lv >= EquipModule.GetMaxLv(quality)
end

function EquipModule.GetCanUpLv(cfgItemData, curLv, maxLv, addExp)
	if maxLv <= curLv then
		return maxLv
	else
		local nextLv = curLv + 1
		local cfgData = CfgSoulPaintingLvTable[curLv]
		local needExp = cfgData.BaseNeedExp * cfgItemData.ExpGrowthRate
		local leftExp = addExp - needExp

		if leftExp >= 0 then
			return EquipModule.GetCanUpLv(cfgItemData, nextLv, maxLv, leftExp)
		else
			return curLv
		end
	end
end

function EquipModule.GetMainAbilityValue(cfgSoulPaintingQualityData, lv)
	local id2ValueDic = {}

	for i, v in pairs(cfgSoulPaintingQualityData.MainBility) do
		local value = cfgSoulPaintingQualityData.MainBilityNum[i] + cfgSoulPaintingQualityData.LevelBilityUPNum[i] * lv

		id2ValueDic[v] = value
	end

	return id2ValueDic
end

function EquipModule.GetSecAbilityValue(cfgSoulPaintingQualityData)
	local id2ValueDic = {}

	for i, v in pairs(cfgSoulPaintingQualityData.SecondBility) do
		local value = cfgSoulPaintingQualityData.SecondBilityNum[i]

		id2ValueDic[v] = value
	end

	return id2ValueDic
end

function EquipModule.GetAttrs(itemData)
	if itemData.equipData == nil then
		logError("非法蕴灵数据。id：" .. itemData.cid)

		return
	end

	local cfgSoulPaintingQualityData

	for i, lCfgSoulPaintingQualityData in pairsCfg(CfgSoulPaintingQualityTable) do
		if lCfgSoulPaintingQualityData.PaintingId == itemData.cid and lCfgSoulPaintingQualityData.QualityLevel == itemData.equipData.star then
			cfgSoulPaintingQualityData = lCfgSoulPaintingQualityData

			break
		end
	end

	if cfgSoulPaintingQualityData == nil then
		logError("找不到蕴灵对应的Quality配置。id：" .. itemData.cid .. ", star：" .. itemData.equipData.star)

		return
	end

	return EquipModule.GetMainAbilityValue(cfgSoulPaintingQualityData, itemData.equipData.lv)
end

function EquipModule.GetWoreSuitEquipCount(itemID, cfgSuitData, PrefabId)
	local ret = 0

	if PlayerModule.InMaze then
		local soulCid = MazeDataModule.GetWoreEquipSoulCid(itemID)

		for i, v in pairs(MazeDataModule.GetWearingEquipMap(soulCid)) do
			ret = ret + 1
		end
	else
		local soulPrefabData = SoulPrefabModule.GetPrefab(PrefabId)

		for i, itemData in pairs(soulPrefabData.equipItemDatum) do
			for m, n in pairs(cfgSuitData.NeedSoulPainting) do
				if n == itemData.cid then
					ret = ret + 1

					break
				end
			end
		end
	end

	return ret
end

function EquipModule.CheckEquipCanBreak(itemData)
	local curStar = itemData.equipData.star
	local cfgSoulPaintingQualityData

	if curStar >= itemData:GetCfg().StarLimit then
		return false
	end

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == itemData.cid and v.QualityLevel == curStar then
			cfgSoulPaintingQualityData = v

			break
		end
	end

	local cost = cfgSoulPaintingQualityData.Cost[2]

	if cost > WarehouseModule.GetItemNumByCfgID(cfgSoulPaintingQualityData.Cost[1]) then
		return false
	end

	local needCount = cfgSoulPaintingQualityData.CostPainting
	local ownCount = 0

	for i, v in pairs(WarehouseModule.AllItems) do
		if v.cid == itemData.cid and v.id ~= itemData.id and v.equipData.lock == false and v.equipData.isWore == false and v.equipData.star == 1 and v.equipData.lv == 1 then
			ownCount = ownCount + 1
		end
	end

	if ownCount < needCount then
		return false
	end

	return true
end

function EquipModule.CheckEquipCanBreakRedPoint(itemData)
	return EquipModule.CheckEquipCanBreak(itemData)
end

function EquipModule.CheckEquipCanComposeRedPoint()
	local isUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_PAINTING)

	if isUnlock then
		local clipItemDatum = WarehouseModule.GetItemsByTypeAndSubType(Constant.ItemType.Item, 20)

		for i, v in pairs(clipItemDatum) do
			local cfgData

			for j, k in pairsCfg(CfgExchangeTable) do
				if k.CostItems[1][1] == v.cid then
					cfgData = k

					break
				end
			end

			if cfgData ~= nil then
				local needCount = cfgData.CostItems[1][2]
				local ownCount = WarehouseModule.GetItemNumByCfgID(cfgData.CostItems[1][1])

				if needCount <= ownCount then
					return true
				end
			end
		end
	end

	return false
end

function EquipModule.GetEquipSkins(itemCid, ignoreSort)
	local skinCidList = {}

	for id, cfgData in pairsCfg(CfgSoulPaintingSkinTable) do
		if cfgData.SoulPaintingId == itemCid and (PlayerModule.PlayerInfo.equipSkins[id] ~= nil or cfgData.IsLockShow) then
			table.insert(skinCidList, id)
		end
	end

	if ignoreSort == nil or not ignoreSort then
		table.sort(skinCidList, function(cid1, cid2)
			local unlockPriority1 = EquipModule.GetSkinState(cid1) ~= nil and 1 or 2
			local unlockPriority2 = EquipModule.GetSkinState(cid2) ~= nil and 1 or 2
			local cfgData1 = CfgSoulPaintingSkinTable[cid1]
			local cfgData2 = CfgSoulPaintingSkinTable[cid2]

			if unlockPriority1 == unlockPriority2 then
				return cfgData1.Sort < cfgData2.Sort
			else
				return unlockPriority1 < unlockPriority2
			end
		end)
	end

	return skinCidList
end

function EquipModule.GetSkinState(skinCid)
	return PlayerModule.PlayerInfo.equipSkins[skinCid]
end

function EquipModule.__GetUsingSkinCid(itemCid)
	for skinCid, useState in pairs(PlayerModule.PlayerInfo.equipSkins) do
		local cfgData = CfgSoulPaintingSkinTable[skinCid]

		if cfgData.SoulPaintingId == itemCid and useState == 1 then
			return skinCid
		end
	end

	return nil
end

function EquipModule.GetEquipShowInfo(itemCid)
	local usingSkinCid = EquipModule.__GetUsingSkinCid(itemCid)
	local equipShowInfo = {}
	local isUsingSkin = false

	if usingSkinCid ~= nil then
		local cfgSoulPaintingSkinData = CfgSoulPaintingSkinTable[usingSkinCid]

		equipShowInfo.Name = cfgSoulPaintingSkinData.Name
		equipShowInfo.Desc = cfgSoulPaintingSkinData.Desc
		equipShowInfo.HiddenStory = cfgSoulPaintingSkinData.HiddenStory
		equipShowInfo.Icon = cfgSoulPaintingSkinData.Icon
		equipShowInfo.Drawing = cfgSoulPaintingSkinData.Drawing
		equipShowInfo.DrawingSmallSize = cfgSoulPaintingSkinData.DrawingSmallSize
		isUsingSkin = true
	else
		local cfgItemData = CfgItemTable[itemCid]

		equipShowInfo.Name = cfgItemData.Name
		equipShowInfo.Desc = cfgItemData.Describe
		equipShowInfo.HiddenStory = cfgItemData.HiddenStory
		equipShowInfo.Icon = cfgItemData.Icon
		equipShowInfo.Drawing = cfgItemData.Drawing
		equipShowInfo.DrawingSmallSize = cfgItemData.DrawingSmallSize
	end

	return equipShowInfo, isUsingSkin
end

function EquipModule.OldDataToFilterPattern()
	local filterPattern = {}

	for i = 1, #EquipModule.equipListUIScreen.SignQuality do
		if EquipModule.equipListUIScreen.SignQuality[i] then
			filterPattern.Quality = filterPattern.Quality or {}

			table.insert(filterPattern.Quality, i)
		end
	end

	for i = 1, #EquipModule.equipListUIScreen.SignClass do
		if EquipModule.equipListUIScreen.SignClass[i] then
			filterPattern.SubType = filterPattern.SubType or {}

			table.insert(filterPattern.SubType, i)
		end
	end

	for i = 1, #EquipModule.equipListUIScreen.SignWearState do
		if EquipModule.equipListUIScreen.SignWearState[i] then
			filterPattern.WearState = filterPattern.WearState or {}

			table.insert(filterPattern.WearState, i)
		end
	end

	for i = 1, #EquipModule.equipListUIScreen.SignSkin do
		if EquipModule.equipListUIScreen.SignSkin[i] then
			filterPattern.Skin = filterPattern.Skin or {}

			table.insert(filterPattern.Skin, i)
		end
	end

	for i = 1, #EquipModule.equipListUIScreen.SignStrengthen do
		if EquipModule.equipListUIScreen.SignStrengthen[i] then
			filterPattern.Strengthen = filterPattern.Strengthen or {}

			table.insert(filterPattern.Strengthen, i)
		end
	end

	return filterPattern
end

function EquipModule.GetCfgQualityByStar(itemCid, star)
	local starCfgMap = EquipModule._itemStarCfgQuality[itemCid]

	if starCfgMap ~= nil then
		local cfg = starCfgMap[star]

		if cfg ~= nil then
			return cfg
		end
	end

	for i, cfgSoulPaintingQuality in pairsCfg(CfgSoulPaintingQualityTable) do
		if cfgSoulPaintingQuality.PaintingId == itemCid and cfgSoulPaintingQuality.QualityLevel == star then
			if starCfgMap == nil then
				starCfgMap = {}
				EquipModule._itemStarCfgQuality[itemCid] = starCfgMap
			end

			starCfgMap[star] = cfgSoulPaintingQuality

			return cfgSoulPaintingQuality
		end
	end

	return nil
end

function EquipModule.ReqPutOn(prefabId, uid, pos)
	EquipModule.latestHandleEquipItemId = uid

	net_soulPrefab.wearEquipment(prefabId, uid, pos)
end

function EquipModule.OnReqPutOnResult()
	EventDispatcher.Dispatch(EventID.EquipPuOnSuccess, EquipModule.latestHandleEquipItemId)
end

function EquipModule.ReqTakeOff(prefabIds, uid)
	EquipModule.latestHandleEquipItemId = uid

	net_soulPrefab.dumpEquipment(prefabIds, uid)
end

function EquipModule.OnReqTakeOffResult()
	EventDispatcher.Dispatch(EventID.EquipTakeOffSuccess, EquipModule.latestHandleEquipItemId)
end

function EquipModule.ReqUpEquip(id, ids, counts)
	EquipModule.latestHandleEquipItemId = id

	local id2Count = {}

	for i, v in ipairs(ids) do
		id2Count[v] = counts[i]
	end

	net_soulPrefab.upgradeEquipment(id, id2Count)
end

function EquipModule.OnReqUpEquipResult()
	NoticeModule.ShowNotice(21040110)
	EventDispatcher.Dispatch(EventID.EquipUpSuccess, EquipModule.latestHandleEquipItemId)
end

function EquipModule.ReqBreakEquip(equipId, materialIds, lv)
	EquipModule.latestHandleEquipItemId = equipId
	EquipModule.latestBreakEquipLv = lv

	net_soulPrefab.upStarEquipment(equipId, materialIds)
end

function EquipModule.OnReqBreakEquipResult()
	EventDispatcher.Dispatch(EventID.EquipBreakSuccess, EquipModule.latestHandleEquipItemId)
end

function EquipModule.ReqLock(uid)
	net_item.lockEquipment(uid)
end

function EquipModule.OnReqLockResult(code, uid, lock)
	if code == 0 then
		if lock then
			NoticeModule.ShowNotice(21040109)
		else
			NoticeModule.ShowNotice(21040111)
		end
	end

	EventDispatcher.Dispatch(EventID.EquipLockOver, uid, lock)
end

function EquipModule.ReqCompose(cid, count)
	ChurchModule.SendExchangeMsg(cid, count)
end

function EquipModule.ReqCoverEquipments(soulPrefabId, equipmentMap)
	net_soulPrefab.coverEquipments(soulPrefabId, equipmentMap)
end

function EquipModule.OnReqCoverEquipmentsResult()
	EventDispatcher.Dispatch(EventID.EquipPuOnSuccess)
end

function EquipModule.ReqExchangeEquipment(prefabId, index1, index2)
	net_soulPrefab.exchangeEquipment(prefabId, index1, index2)
end

function EquipModule.OnReqExchangeEquipmentResult()
	EventDispatcher.Dispatch(EventID.EquipPuOnSuccess)
end

function EquipModule.ReqSaveEquipmentPrefab(equipmentPrefabMap, equipmentPrefabId)
	net_soulPrefab.saveEquipmentPrefab(equipmentPrefabMap, equipmentPrefabId)
end

function EquipModule.SendChangeSkin(skinCid, state)
	net_player.useEquipSkin(skinCid, state)
end
