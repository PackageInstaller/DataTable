-- chunkname: @IQIGame\\Module\\EvilErosion\\EvilErosionModule.lua

EvilErosionModule = {
	GlobalCid = 0,
	IsEvilErosionBattle = false
}

function EvilErosionModule.Reload(dailyDupPOD)
	EvilErosionModule.DailyDupPOD = dailyDupPOD

	if EvilErosionModule.DailyDupPOD ~= nil then
		EvilErosionModule.GlobalCid = EvilErosionModule.DailyDupPOD.common.openCount
	end
end

function EvilErosionModule.Update(dailyDupPOD)
	EvilErosionModule.DailyDupPOD = deepClonePOD(dailyDupPOD, EvilErosionModule.DailyDupPOD)
	EvilErosionModule.GlobalCid = EvilErosionModule.DailyDupPOD.common.openCount

	EventDispatcher.Dispatch(EventID.EvilErosionUpdateDailyDupPOD)
end

function EvilErosionModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[16]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and EvilErosionModule.DailyDupPOD ~= nil and EvilErosionModule.DailyDupPOD.common.status ~= 0
end

function EvilErosionModule.GetGlobalData()
	return CfgEvilErosionGlobalTable[EvilErosionModule.GlobalCid]
end

function EvilErosionModule.GetRatingPreview(levelCid, simulatedStartTime)
	local timeMap = EvilErosionModule.DailyDupPOD.common.centerEvilErosionPOD.levelRatingTime

	timeMap = timeMap or {}

	local startTime = simulatedStartTime or timeMap[levelCid]
	local elapsedTime

	if startTime ~= nil then
		elapsedTime = PlayerModule.GetServerTime() - startTime
	end

	local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[levelCid]
	local minLevel = Constant.Number.IntMaxValue
	local minLevelRewardCfgData

	for id, cfgData in pairsCfg(CfgEvilErosionRewardTable) do
		if cfgData.Group == cfgEvilErosionLevelData.RewardGroup and (elapsedTime == nil or cfgData.TimeLimit == 0 or elapsedTime < cfgData.TimeLimit) and minLevel > cfgData.RewardLevel then
			minLevel = cfgData.RewardLevel
			minLevelRewardCfgData = cfgData
		end
	end

	return minLevel, minLevelRewardCfgData, elapsedTime
end

function EvilErosionModule.GetGamePlayLevel()
	local curLevelCfgData = CfgEvilErosionLevelTable[EvilErosionModule.GetCurrentLevelCid()]
	local cfgEvilErosionGlobalData = EvilErosionModule.GetGlobalData()
	local maxLevel = 0

	for i = 1, #cfgEvilErosionGlobalData.EvilErosionLevel do
		local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[cfgEvilErosionGlobalData.EvilErosionLevel[i]]

		maxLevel = math.max(maxLevel, cfgEvilErosionLevelData.Level)
	end

	return curLevelCfgData.Level, maxLevel
end

function EvilErosionModule.GetAffixSkillSpeEffects()
	local buffs = {}
	local cfgEvilErosionGlobalData = EvilErosionModule.GetGlobalData()

	for i = 1, #cfgEvilErosionGlobalData.ShowAffix do
		table.insert(buffs, cfgEvilErosionGlobalData.ShowAffix[i])
	end

	return buffs
end

function EvilErosionModule.GetElapsedDays()
	local openDuration = PlayerModule.GetServerTime() - EvilErosionModule.DailyDupPOD.common.openDate

	return math.ceil(openDuration / 60 / 60 / 24)
end

function EvilErosionModule.GetSupplySpeEffect()
	local days = EvilErosionModule.GetElapsedDays()
	local allBuffs = EvilErosionModule.GetGlobalData().ShowReliefBuff

	if #allBuffs == 0 then
		return 0
	end

	if days > #allBuffs then
		days = #allBuffs
	end

	return allBuffs[days]
end

function EvilErosionModule.GetEquipOwner(equipId)
	local wearingSoulPrefabPOD

	for i = 1, #EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs do
		local soulPrefabPOD = EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs[i]

		for index, wearingEquipId in pairs(soulPrefabPOD.equipments) do
			if equipId == wearingEquipId then
				wearingSoulPrefabPOD = soulPrefabPOD

				break
			end
		end

		if wearingSoulPrefabPOD ~= nil then
			break
		end
	end

	return wearingSoulPrefabPOD
end

function EvilErosionModule.CheckEquipIsOnOtherSoulPrefab(itemData, excludedPrefabId)
	local hostId

	for i = 1, #EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs do
		local soulPrefabPOD = EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs[i]

		if soulPrefabPOD.id ~= excludedPrefabId then
			for index, equipId in pairs(soulPrefabPOD.equipments) do
				if equipId == itemData.id then
					hostId = soulPrefabPOD.id

					break
				end
			end

			if hostId ~= nil then
				break
			end
		end
	end

	return hostId
end

function EvilErosionModule.GetDecomposeRecycling(itemData)
	local recycling = {}
	local cfgItemData = itemData:GetCfg()

	for i = 1, #cfgItemData.Recycling, 2 do
		local cid = cfgItemData.Recycling[i]
		local num = cfgItemData.Recycling[i + 1]
		local nowNum = recycling[cid]

		nowNum = nowNum or 0
		nowNum = nowNum + num
		recycling[cid] = nowNum
	end

	local rate = cfgItemData.RecyclingExpRate[1]

	for id, cfgSoulPaintingQualityData in pairs(CfgSoulPaintingQualityTable) do
		for star = 1, itemData.equipData.star - 1 do
			if itemData.cid == cfgSoulPaintingQualityData.PaintingId and star == cfgSoulPaintingQualityData.QualityLevel then
				for i = 1, #cfgSoulPaintingQualityData.Cost, 2 do
					local cid = cfgSoulPaintingQualityData.Cost[i]
					local num = math.ceil(cfgSoulPaintingQualityData.Cost[i + 1] * rate)
					local nowNum = recycling[cid]

					nowNum = nowNum or 0
					nowNum = nowNum + num
					recycling[cid] = nowNum
				end
			end
		end
	end

	return recycling
end

function EvilErosionModule.GetEnhanceCost(itemData)
	local costIdNumMap = {}

	for id, cfgSoulPaintingQualityData in pairs(CfgSoulPaintingQualityTable) do
		if itemData.cid == cfgSoulPaintingQualityData.PaintingId and itemData.equipData.star == cfgSoulPaintingQualityData.QualityLevel then
			for i = 1, #cfgSoulPaintingQualityData.Cost, 2 do
				local cid = cfgSoulPaintingQualityData.Cost[i]
				local num = cfgSoulPaintingQualityData.Cost[i + 1]
				local nowNum = costIdNumMap[cid]

				nowNum = nowNum or 0
				nowNum = nowNum + num
				costIdNumMap[cid] = nowNum
			end
		end
	end

	return costIdNumMap
end

function EvilErosionModule.GetQualityCfg(itemData, previewAddStar)
	previewAddStar = previewAddStar or 0

	for id, cfgSoulPaintingQualityData in pairsCfg(CfgSoulPaintingQualityTable) do
		if cfgSoulPaintingQualityData.PaintingId == itemData.cid and cfgSoulPaintingQualityData.QualityLevel == itemData.equipData.star + previewAddStar then
			return cfgSoulPaintingQualityData
		end
	end

	return nil
end

function EvilErosionModule.GetDailySupplyPreview()
	local days = EvilErosionModule.GetElapsedDays()
	local cfgEvilErosionGlobalData = EvilErosionModule.GetGlobalData()
	local dailySupplyCfgDataList = {}

	for id, cfgData in pairsCfg(CfgEvilErosionDailySupplyTable) do
		if cfgData.Group == cfgEvilErosionGlobalData.DailyRewardGroup and cfgData.Day > days - 3 and days >= cfgData.Day and table.indexOf(EvilErosionModule.DailyDupPOD.evilErosionPOD.getDailySupplys, id) == -1 then
			table.insert(dailySupplyCfgDataList, cfgData)
		end
	end

	table.sort(dailySupplyCfgDataList, function(cfgData1, cfgData2)
		return cfgData1.Day < cfgData2.Day
	end)

	local items = {}

	for i = 1, #dailySupplyCfgDataList do
		local cfgData = dailySupplyCfgDataList[i]

		for j = 1, #cfgData.Items, 2 do
			local itemCid = cfgData.Items[j]
			local itemNum = cfgData.Items[j + 1]

			table.insert(items, {
				cid = itemCid,
				num = itemNum
			})
		end
	end

	return items
end

function EvilErosionModule.GetCurrentLevelCid()
	local cid = EvilErosionModule.DailyDupPOD.evilErosionPOD.currLevel

	if cid ~= nil and cid ~= 0 then
		return cid
	end

	local levelList = EvilErosionModule.GetGlobalData().EvilErosionLevel

	return levelList[#levelList]
end

function EvilErosionModule.IsAllPassed()
	return EvilErosionModule.DailyDupPOD.evilErosionPOD.currLevel == 0
end

function EvilErosionModule.IsLevelUnlockByTime(levelCid)
	local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[levelCid]
	local days = EvilErosionModule.GetElapsedDays()

	return days >= cfgEvilErosionLevelData.UnlockDay, EvilErosionModule.DailyDupPOD.common.openDate + (cfgEvilErosionLevelData.UnlockDay - 1) * 24 * 60 * 60
end

function EvilErosionModule.SendChangeCustomSkill(soulPrefabId, customSkills)
	net_evilErosion.changeCustomSkills(soulPrefabId, customSkills)
end

function EvilErosionModule.SendChangePosition(soulPrefabId, position)
	net_evilErosion.changePosition(soulPrefabId, position)
end

function EvilErosionModule.SendChangeFormationPos(soulPrefabId, formationPos)
	net_evilErosion.changeFormationPos(soulPrefabId, formationPos)
end

function EvilErosionModule.OnCustomSkillChanged()
	EventDispatcher.Dispatch(EventID.EvilErosionChangeCustomSkill)
end

function EvilErosionModule.OnPositionChanged()
	EventDispatcher.Dispatch(EventID.EvilErosionChangePosition)
end

function EvilErosionModule.OnFormationPosChanged()
	EventDispatcher.Dispatch(EventID.EvilErosionChangeFormationPos)
end

function EvilErosionModule.OnSoulPrefabChanged(soulPrefabPODs)
	local newAddSoulPrefabPODs = {}

	for i = 1, #soulPrefabPODs do
		local newSoulPrefabPOD = soulPrefabPODs[i]
		local found = false

		for j = 1, #EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs do
			local oldSoulPrefabPOD = EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs[j]

			if oldSoulPrefabPOD.id == newSoulPrefabPOD.id then
				for k, v in pairs(newSoulPrefabPOD) do
					oldSoulPrefabPOD[k] = newSoulPrefabPOD[k]
				end

				found = true

				break
			end
		end

		if not found then
			table.insert(newAddSoulPrefabPODs, newSoulPrefabPOD)
		end
	end

	for i = 1, #newAddSoulPrefabPODs do
		table.insert(EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs, newAddSoulPrefabPODs[i])
	end
end

function EvilErosionModule.Fight(levelCid)
	net_evilErosion.fight(levelCid)
end

function EvilErosionModule.OnFight()
	EvilErosionModule.IsEvilErosionBattle = true
end

function EvilErosionModule.OnFightComplete(win, levelCid, dmgRecords, getItems, rating, ratingTime)
	EvilErosionModule.IsEvilErosionBattle = false

	MainCityBattleModule.Instance:QuitBattle(function()
		UIModule.Open(Constant.UIControllerName.EvilErosionLevelSettlementUI, Constant.UILayer.UI, {
			levelCid = levelCid,
			isWin = win,
			getItems = getItems,
			rating = rating,
			ratingTime = ratingTime
		})
	end)
	UIModule.Close(Constant.UIControllerName.EvilErosionLevelDetailUI)
end

function EvilErosionModule.ChangeEquip(soulPrefabData, toReplaceEquipIndex, equipData, onConfirmed)
	local needConfirm = false
	local toReplaceEquipId = soulPrefabData.equipments[toReplaceEquipIndex]
	local isSelected = toReplaceEquipId ~= nil and equipData.id == toReplaceEquipId

	if isSelected then
		EvilErosionModule.SendTakeOffEquip(soulPrefabData.id, equipData.id)
	else
		local equipIndexOnOtherSlot = -1
		local existedSameIdEquipId

		for index, equipId in pairs(soulPrefabData.equipments) do
			if equipId == equipData.id then
				equipIndexOnOtherSlot = index
			end

			local itemData = WarehouseModule.GetItemDataById(equipId)

			if itemData.cid == equipData.cid then
				existedSameIdEquipId = equipId
			end
		end

		if equipIndexOnOtherSlot ~= -1 then
			EvilErosionModule.SendChangeEquipment(soulPrefabData.id, toReplaceEquipIndex, equipIndexOnOtherSlot)
		else
			local equipHostPrefabId = EvilErosionModule.CheckEquipIsOnOtherSoulPrefab(equipData, soulPrefabData.id)
			local isOnOtherPrefab = equipHostPrefabId ~= nil

			needConfirm = isOnOtherPrefab or existedSameIdEquipId ~= nil

			local noticeCid

			if isOnOtherPrefab and existedSameIdEquipId == nil then
				noticeCid = 21053008
			elseif not isOnOtherPrefab and existedSameIdEquipId ~= nil then
				noticeCid = 21053009
			elseif isOnOtherPrefab and existedSameIdEquipId ~= nil then
				noticeCid = 21053010
			else
				EvilErosionModule.SendPutOnEquip(soulPrefabData.id, equipData.id, toReplaceEquipIndex)
			end

			if needConfirm then
				NoticeModule.ShowNotice(noticeCid, function()
					if existedSameIdEquipId ~= nil then
						EvilErosionModule.SendTakeOffEquip(soulPrefabData.id, existedSameIdEquipId)
					end

					EvilErosionModule.SendPutOnEquip(soulPrefabData.id, equipData.id, toReplaceEquipIndex)

					if onConfirmed ~= nil then
						onConfirmed()
					end
				end, nil)
			end
		end
	end

	return needConfirm
end

function EvilErosionModule.SendPutOnEquip(soulPrefabId, equipId, pos)
	net_evilErosion.wearEquipment(soulPrefabId, equipId, pos)
end

function EvilErosionModule.SendTakeOffEquip(soulPrefabId, equipId)
	net_evilErosion.dumpEquipment(soulPrefabId, equipId)
end

function EvilErosionModule.SendChangeEquipment(soulPrefabId, index1, index2)
	net_evilErosion.exchangeEquipment(soulPrefabId, index1, index2)
end

function EvilErosionModule.OnWearingEquipChanged()
	EventDispatcher.Dispatch(EventID.EvilErosionWearingEquipChanged)
end

function EvilErosionModule.SendDecomposeEquip(itemIdList)
	net_evilErosion.decpEquipment(itemIdList)
end

function EvilErosionModule.OnDecomposeEquipComplete(getItems)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	EventDispatcher.Dispatch(EventID.EvilErosionDecomposeComplete)
end

function EvilErosionModule.SendUpgradeEquipmentStar(itemId)
	net_evilErosion.upStarEquipment(itemId)
end

function EvilErosionModule.OnUpgradeEquipComplete()
	EventDispatcher.Dispatch(EventID.EvilErosionUpgradeStarComplete)
end

function EvilErosionModule.SendGetDailySupply()
	net_evilErosion.getDailySupply()
end

function EvilErosionModule.OnGetDailySupply(getItems)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	EventDispatcher.Dispatch(EventID.EvilErosionGotDailySupply)
end

function EvilErosionModule.Shutdown()
	EvilErosionModule.DailyDupPOD = nil
	EvilErosionModule.GlobalCid = 0
	EvilErosionModule.IsEvilErosionBattle = false
end
