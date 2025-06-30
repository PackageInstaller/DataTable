-- chunkname: @IQIGame\\Module\\Equip\\EquipModule.lua

EquipModule = {}

function EquipModule.Initialize()
	EquipModule.InitData()
	EquipModule.InitEquipScreenData()
	EquipModule.AddEventListeners()
end

function EquipModule.InitData()
	EquipModule.equipDataDic = {}
	EquipModule.equipSuitNumList = {}
end

function EquipModule.InitEquipScreenData()
	EquipModule.RuntimeEquipScreenTable = {}

	for _cid, _data in ipairs(CfgEquipScreenTable) do
		if EquipModule.RuntimeEquipScreenTable[_data.Type] == nil then
			EquipModule.RuntimeEquipScreenTable[_data.Type] = {}
		end

		table.insert(EquipModule.RuntimeEquipScreenTable[_data.Type], _cid)
	end
end

function EquipModule.GetEquipScreenSubMenuList(screenType)
	return EquipModule.RuntimeEquipScreenTable[screenType]
end

function EquipModule.GetEquipScreenSubMenuData(cid)
	return CfgEquipScreenTable[cid]
end

function EquipModule.CreateEquipData(equipData, ItemData)
	if EquipModule.equipDataDic[ItemData.id] then
		EquipModule.equipDataDic[ItemData.id]:Update(equipData, ItemData)

		return EquipModule.equipDataDic[ItemData.id]
	end

	local EquipData = EquipData.New()

	EquipData:Update(equipData, ItemData)

	EquipModule.equipDataDic[ItemData.id] = EquipData

	return EquipData
end

function EquipModule.QualitySort(tb1, tb2)
	return tb1:GetCfg().Quality - tb2:GetCfg().Quality
end

function EquipModule.LvSort(tb1, tb2)
	local tb1Level = 0

	if tb1.equipData ~= nil then
		tb1Level = tb1.equipData.lv
	elseif tb1.lv ~= nil then
		tb1Level = tb1.lv
	end

	local tb2Level = 0

	if tb2.equipData ~= nil then
		tb2Level = tb2.equipData.lv
	elseif tb2.lv ~= nil then
		tb2Level = tb2.lv
	end

	return tb1Level - tb2Level
end

function EquipModule.CreateTimeSort(tb1, tb2)
	return tb1.createTime - tb2.createTime
end

function EquipModule.EquipIsLockSort(tb1, tb2)
	local tb1IsLock = tb1.isLock

	if tb1.equipData ~= nil then
		tb1IsLock = tb1.equipData.isLock
	end

	local tb2IsLock = tb2.isLock

	if tb2.equipData ~= nil then
		tb2IsLock = tb2.equipData.isLock
	end

	if not tb1IsLock and tb2IsLock then
		return 1
	elseif tb1IsLock and not tb2IsLock then
		return -1
	end

	return 0
end

EquipModule.DefaultSortingIndex = 1

function EquipModule.GetSortingFuncList(index)
	local SortingFuncList = {
		{
			SortingText = EquipApi:GetTextQuality(),
			SortingFunc = {
				EquipModule.EquipIsLockSort,
				EquipModule.QualitySort,
				EquipModule.LvSort,
				EquipModule.CreateTimeSort
			}
		},
		{
			SortingText = EquipApi:GetTextTitleLv(),
			SortingFunc = {
				EquipModule.EquipIsLockSort,
				EquipModule.LvSort,
				EquipModule.QualitySort,
				EquipModule.CreateTimeSort
			}
		},
		{
			SortingText = EquipApi:GetTextGetTime(),
			SortingFunc = {
				EquipModule.EquipIsLockSort,
				EquipModule.CreateTimeSort,
				EquipModule.QualitySort,
				EquipModule.LvSort
			}
		}
	}

	return SortingFuncList[index]
end

function EquipModule.GetSuitNeedCount(suitId, type)
	local configs = {}

	for i, v in pairs(CfgEquipSuitTable) do
		if v.SuitID == suitId and type == v.SuitType then
			table.insert(configs, v)
		end
	end

	table.sort(configs, function(a, b)
		return a.Id < b.Id
	end)

	return configs
end

function EquipModule.GetSuitConfigList(EquipDataList)
	local equipSuitScreenDataList = {}
	local dic = {}

	for i, v in pairs(CfgEquipSuitTable) do
		if dic[v.SuitID] == nil and #EquipModule.GetSuitScreenConfigList(EquipDataList, v.SuitID) > 0 and v.SuitType == Constant.Equip.SuitType.Normal then
			table.insert(equipSuitScreenDataList, v)

			dic[v.SuitID] = v.SuitID
		end
	end

	return equipSuitScreenDataList
end

function EquipModule.GetSuitScreenConfigList(list, suitId)
	local screenList = {}

	for _, item in pairs(list) do
		if item:GetEquipCfg().SuitId[1] == suitId then
			table.insert(screenList, item)
		end
	end

	return screenList
end

function EquipModule.GetEquipIntensifyMaterial(currentIntensifyEquipID)
	local materialList = {}
	local equipList = {}
	local materialConfigList = RoleDevelopmentModule.GetItemByActionType(Constant.ActionType.AddEquipExpAction)

	for i, item in pairs(materialConfigList) do
		local material = WarehouseModule.FindItemForCid(item.Id)

		if material == nil then
			material = ItemData.CreateByCIDAndNumber(item.Id, 0)
		end

		table.insert(materialList, material)
	end

	for i, item in pairs(WarehouseModule.AllItems) do
		if item.equipData ~= nil and item.equipData.heroCid == 0 and item.equipData.id ~= currentIntensifyEquipID then
			table.insert(equipList, item)
		end
	end

	return materialList, equipList
end

function EquipModule.GetEquipCurrentLevelUpExp(quality, part, level)
	local equipLevelConfig = EquipModule.GetEquipIntensifyQualityPartConfig(quality, part)

	return equipLevelConfig[level].NeedExp
end

function EquipModule.GetEquipLevelConfig()
	local config = {}

	for k, v in pairsCfg(CfgEquipLevelTable) do
		if config[v.Quality] == nil then
			config[v.Quality] = {}
		end

		if config[v.Quality][v.Place] == nil then
			config[v.Quality][v.Place] = {}
		end

		config[v.Quality][v.Place][v.Level] = v
	end

	return config
end

function EquipModule.GetEquipIntensifyQualityPartConfig(quality, part)
	local config = EquipModule.GetEquipLevelConfig()

	return config[quality][part]
end

function EquipModule.GetEquipOfferExp(quality, part, level)
	local partConfig = EquipModule.GetEquipIntensifyQualityPartConfig(quality, part)

	return partConfig[level].OfferExp
end

function EquipModule.OneKeyAddIntensityItem(currentIntensifyEquip, equipList, materialList, filterNum)
	local upperByMoney = WarehouseModule.GetPlayerGoldNum() / (CfgDiscreteDataTable[24].Data[1] / 100)
	local equipCfg = currentIntensifyEquip:GetEquipCfg()
	local cumExpList = EquipModule.GetLevelCumulativeExpList(equipCfg.Quality, equipCfg.Place)
	local upperByEquipLevel = cumExpList[#cumExpList] - (currentIntensifyEquip.exp + cumExpList[currentIntensifyEquip.lv])
	local materialCountUpper = 8
	local filledExp = 0
	local filledMaterialCount = 0

	filledExp, filledMaterialCount = EquipModule.IntensifyPreviewAddExpByMaterial(materialList, upperByMoney, upperByEquipLevel, materialCountUpper, filterNum)
	upperByMoney = upperByMoney - filledExp
	upperByEquipLevel = upperByEquipLevel - filledExp
	materialCountUpper = materialCountUpper - filledMaterialCount
	filledExp, filledMaterialCount = EquipModule.IntensifyPreviewAddExpByEquip(equipList, upperByMoney, upperByEquipLevel, materialCountUpper, filterNum)
end

function EquipModule.IntensifyPreviewAddExpByEquip(itemDataList, upperByMoney, upperByEquipLevel, materialCountUpper, filterNum)
	table.sort(itemDataList, function(a, b)
		return a:GetCfg().Quality < b:GetCfg().Quality
	end)

	if upperByMoney <= 0 or upperByEquipLevel <= 0 then
		return 0, 0
	end

	local expSum = 0
	local materialCount = 0

	for i, itemData in pairs(itemDataList) do
		if materialCountUpper <= materialCount then
			return expSum, materialCount
		end

		if filterNum >= itemData.equipData:GetEquipCfg().Quality and itemData.equipData:GetEquipCfg().Quality < EquipModule.GetEquipLimitQuality() and not itemData.equipData.isLock then
			local equipCfg = itemData.equipData:GetCfg()
			local exp = EquipModule.GetEquipOfferExp(equipCfg.Quality, equipCfg.Part, itemData.equipData.lv)

			if itemData.ItemCustomCount == nil then
				itemData.ItemCustomCount = 0
			end

			if itemData.ItemCustomCount == 0 then
				if upperByMoney < expSum + exp then
					return expSum, materialCount
				end

				if upperByEquipLevel <= expSum then
					return expSum, materialCount
				end

				itemData.ItemCustomCount = 1
			end

			expSum = expSum + exp * itemData.ItemCustomCount
			materialCount = materialCount + (itemData.ItemCustomCount > 0 and 1 or 0)
		end
	end

	return expSum, materialCount
end

function EquipModule.IntensifyPreviewAddExpByMaterial(itemDataList, upperByMoney, upperByEquipLevel, materialCountUpper, filterNum)
	table.sort(itemDataList, function(a, b)
		return a:GetCfg().Quality > b:GetCfg().Quality
	end)

	if upperByMoney <= 0 or upperByEquipLevel <= 0 then
		return 0, 0
	end

	local expSum = 0
	local materialCount = 0

	for i, itemData in pairs(itemDataList) do
		if materialCountUpper <= materialCount then
			return expSum, materialCount
		end

		local cfgItem = itemData:GetCfg()

		if filterNum >= cfgItem.Quality then
			local exp = itemData:GetCfg().ActionParams[1]

			for selectedCount = 1, itemData.num do
				if upperByMoney < expSum + exp * selectedCount then
					return expSum + exp * selectedCount, materialCount
				end

				if upperByEquipLevel <= expSum + exp * itemData.ItemCustomCount then
					return expSum + exp * selectedCount, materialCount
				end

				itemData.ItemCustomCount = selectedCount
			end

			expSum = expSum + exp * itemData.ItemCustomCount
			materialCount = materialCount + (itemData.ItemCustomCount > 0 and 1 or 0)
		end
	end

	return expSum, materialCount
end

function EquipModule.GetLevelCumulativeExpList(quality, part)
	local qualityPartConfig = EquipModule.GetEquipIntensifyQualityPartConfig(quality, part)
	local levelCumulativeExpList = {
		[0] = 0
	}

	for level = 1, #qualityPartConfig do
		levelCumulativeExpList[level] = levelCumulativeExpList[level - 1] + qualityPartConfig[level - 1].NeedExp
	end

	return levelCumulativeExpList
end

function EquipModule.GetEquipLimitQuality()
	return CfgDiscreteDataTable[64].Data[1]
end

function EquipModule.GetQualityByAttribute(id, value)
	local highestQuality = 1

	return highestQuality
end

function EquipModule.SumIntensifyOfferExp(consumeItemList)
	local expSum = 0

	for i, itemData in pairs(consumeItemList) do
		if itemData.equipData then
			local equipCfg = itemData.equipData:GetCfg()

			expSum = expSum + EquipModule.GetEquipOfferExp(equipCfg.Quality, equipCfg.Part, itemData.equipData.lv)
		else
			expSum = expSum + itemData:GetCfg().ActionParams[1] * itemData.ItemCustomCount
		end
	end

	return expSum
end

function EquipModule.IsCurrencyEnough(exp)
	return WarehouseModule.GetPlayerGoldNum() >= CfgDiscreteDataTable[24].Data[1] / 100 * exp
end

function EquipModule.HasHighValueEquip(itemList)
	for i, item in pairs(itemList) do
		if item.equipData and (item.equipData:GetEquipCfg().Quality >= 5 or item.equipData.lv >= 1) then
			return true
		end
	end

	return false
end

function EquipModule.Shutdown()
	EquipModule.RemoveEventListeners()
end

function EquipModule.AddEventListeners()
	return
end

function EquipModule.RemoveEventListeners()
	return
end

function EquipModule.ReplaceEquip(heroCid, id)
	net_equip.wearEquip(heroCid, id)
end

function EquipModule.IntensifyEquipFunc(id, useItems)
	net_equip.upgradeEquip(id, useItems)
end

function EquipModule.UnloadEquip(heroCid, id)
	net_equip.unloadEquip(heroCid, id)
end

function EquipModule.LockEquip(ids)
	net_equip.lockEquip(ids)
end

function EquipModule.UnloadEquipSucceed(code)
	EventDispatcher.Dispatch(EventID.UnloadEquipSucceedNew)
	NoticeModule.ShowNotice(20021)
end

function EquipModule.LockEquipSucceed(code)
	EventDispatcher.Dispatch(EventID.LockEquipSucceedNew)
end

function EquipModule.ReplaceEquipSucceed(code)
	EventDispatcher.Dispatch(EventID.WearEquipSucceedNew)
	NoticeModule.ShowNotice(20023)
end

function EquipModule.IntensifyEquipSucceed(oldEquipPOD, equipPOD)
	EventDispatcher.Dispatch(EventID.UpgradeEquipSucceedNew)
	UIModule.Open(Constant.UIControllerName.EquipUpLevelTipUI, Constant.UILayer.UI, {
		oldEquipPOD = oldEquipPOD,
		equipPOD = equipPOD
	})
end

function EquipModule.OnDecomposeEquipSuccess()
	EventDispatcher.Dispatch(EventID.EquipDecomposeItemResult)
end

function EquipModule.GetHasWearEquip()
	return true
end

function EquipModule:SetTextType(attrId, value)
	if CfgAttributeTable[attrId].IsPer then
		value = string.format("%.3f", value)
		value = value * 100 .. "%"
	else
		value = math.floor(value)
	end

	return value
end

function EquipModule.GetAllEquipSuitItemBySuitIdAndQuality(suitId, quality)
	local configs = {}

	for _, v in pairs(CfgEquipTable) do
		if v.SuitId == suitId and v.Quality == quality then
			table.insert(configs, v)
		end
	end

	table.sort(configs, function(a, b)
		return a.Id < b.Id
	end)

	return configs
end

function EquipModule.ToEquipDataList(intensityEquipList)
	local equipDataList = {}

	for i, itemData in pairs(intensityEquipList) do
		table.insert(equipDataList, itemData.equipData)
	end

	return equipDataList
end

function EquipModule.SetCurrentHeroCid(heroCid)
	EquipModule.currentHeroCid = heroCid
end

function EquipModule.GetCurrentHeroData()
	return WarlockModule.WarlockDataDic[EquipModule.currentHeroCid]
end

function EquipModule.GetCurrentHeroEquipData()
	return EquipModule.GetEquipData(EquipModule.currentHeroCid)
end

function EquipModule.GetEquipData(heroCid)
	return WarlockModule.WarlockDataDic[heroCid].EquipDataArr
end

function EquipModule.GetIsEquippedAwaken_Cid(equipDataArr)
	local equipData = equipDataArr[Constant.Equip.Part.Hun]

	if equipData == nil then
		return false, nil
	else
		return true, equipData.equipCid
	end
end

function EquipModule.GetEquipNotAwakenList(equipID, normalSuitTable)
	local isRemoveTable = {}
	local suitIDs = CfgEquipTable[equipID].SuitId
	local isRemove = true

	for k, v in pairs(normalSuitTable) do
		for i = 1, #suitIDs do
			if suitIDs[i] == k then
				isRemove = false
			end
		end

		if isRemove then
			table.insert(isRemoveTable, k)
		end

		isRemove = true
	end

	return isRemoveTable
end

function EquipModule.GetAwakenSuitConfigs(suitIDs, type)
	local awakenCfgs = {}

	for k, v in pairsCfg(CfgEquipSuitTable) do
		for j, m in pairs(suitIDs) do
			if v.SuitID == m and v.SuitType == type then
				awakenCfgs[v.SuitID] = v
			end
		end
	end

	return awakenCfgs
end

function EquipModule.GetEffectiveEquipSuitTable(warlockData, type)
	local effectiveSuitTable = {}
	local suitTable = EquipModule.GetEquipSuitTable(warlockData, type)

	for suitID, suit in pairs(suitTable) do
		if EquipModule.IsAnySuitEffective(suit.SuitList) then
			effectiveSuitTable[suitID] = suit
		end
	end

	return effectiveSuitTable
end

function EquipModule.IsAnySuitEffective(SuitList)
	for i, config in pairs(SuitList) do
		if config.IsEffective then
			return true
		end
	end

	return false
end

function EquipModule.GetEquipSuitTable(warlockData, type)
	local suitTable = {}
	local suitCountTable = {}

	for _, equipData in pairs(warlockData.EquipDataArr) do
		for i = 1, #equipData:GetEquipCfg().SuitId do
			local suitID = equipData:GetEquipCfg().SuitId[i]

			if suitCountTable[suitID] == nil then
				suitCountTable[suitID] = 0
			end

			suitCountTable[suitID] = suitCountTable[suitID] + 1
		end
	end

	local suitIDNameMap = EquipModule.GetSuitIDNameMap(type)
	local suitConfigTable = EquipModule.GetSuitConfigTable(type)

	for suitID, configList in pairs(suitConfigTable) do
		for _, config in pairs(configList) do
			config.Count = suitCountTable[suitID] or 0
			config.IsEffective = (suitCountTable[suitID] or 0) >= config.NeedCount
		end

		suitTable[suitID] = {
			Name = suitIDNameMap[suitID],
			SuitList = configList
		}
	end

	return suitTable
end

function EquipModule.GetAllEquipSuitTable(type)
	local suitTable = {}
	local suitIDNameMap = EquipModule.GetSuitIDNameMap(type)
	local suitConfigTable = EquipModule.GetSuitConfigTable(type)

	for suitID, configList in pairs(suitConfigTable) do
		suitTable[suitID] = {
			Name = suitIDNameMap[suitID],
			SuitList = configList
		}
	end

	return suitTable
end

function EquipModule.GetSuitConfigTable(type)
	local suitConfigTable = {}
	local suitIDs = EquipModule.GetSuitIDNameMap(type)

	for suitID, v in pairs(suitIDs) do
		suitConfigTable[suitID] = EquipModule.GetSuitConfigListBySuitID(suitID, type)
	end

	return suitConfigTable
end

function EquipModule.GetSuitIDNameMap(type)
	local suitIDNameMap = {}

	for i, suitConfig in pairs(CfgEquipSuitTable) do
		if suitConfig.SuitType == type then
			suitIDNameMap[suitConfig.SuitID] = suitConfig.Name
		end
	end

	return suitIDNameMap
end

function EquipModule.GetSuitConfigListBySuitID(suitId, type)
	local configs = {}

	for i, v in pairs(CfgEquipSuitTable) do
		if v.SuitID == suitId and type == v.SuitType then
			table.insert(configs, v)
		end
	end

	table.sort(configs, function(a, b)
		return a.Id < b.Id
	end)

	return configs
end

function EquipModule.GetBaseAttributeConfig()
	return EquipModule.GetAttributeConfigDict(1)
end

function EquipModule.GetAdvancedAttributeConfig()
	return EquipModule.GetAttributeConfigDict(2)
end

function EquipModule.GetAttributeConfigDict(type)
	local attributeDict = {}

	for i, v in pairs(CfgAttributeTable) do
		if v.Type == type then
			attributeDict[v.Id] = v
		end
	end

	return attributeDict
end

function EquipModule.EquipAttr2HeroAttrText(WarlockData)
	local baseAttributeConfigList = EquipModule.GetBaseAttributeConfig()
	local baseAttributeDict = EquipModule.BuildAttributeValueDictByEquipData(WarlockData, baseAttributeConfigList)
	local advancedAttributeConfigList = EquipModule.GetAdvancedAttributeConfig()
	local advancedAttributeDict = EquipModule.BuildAttributeValueDictByEquipData(WarlockData, advancedAttributeConfigList)

	return {
		BaseAttributeDict = baseAttributeDict,
		AdvancedAttributeDict = advancedAttributeDict
	}
end

function EquipModule.BuildAttributeValueDictByEquipData(WarlockData, attributeConfigList)
	local equipDataList = WarlockData.EquipDataArr
	local attributeDict = {}

	for _, attributeConfig in pairs(attributeConfigList) do
		local value = 0

		for _, equipData in pairs(equipDataList) do
			if equipData ~= nil then
				value = value + equipData:GetAttributeNumForType(attributeConfig.Id, WarlockData:GetBaseAttr(attributeConfig.Id))
			end
		end

		attributeDict[attributeConfig.Id] = EquipApi:FormatAttrValue(attributeConfig.IsPer, value)
	end

	return attributeDict
end

function EquipModule.GetHeroEffectiveSetsWithEquipDataAttr(equipDataAttr)
	local effectiveSet = {}

	for _, equipData in pairs(equipDataAttr) do
		local cfgEquip = CfgUtil.GetCfgEquipDataWithID(equipData.equipCid)
		local setIdList = cfgEquip.SuitId
		local len = #setIdList

		for j = 1, len do
			if not effectiveSet[setIdList[j]] then
				effectiveSet[setIdList[j]] = 1
			else
				effectiveSet[setIdList[j]] = effectiveSet[setIdList[j]] + 1
			end
		end
	end

	return effectiveSet
end

function EquipModule.GetHeroIsAwakeWithEquipCId(equipData, id)
	local isAwaken = false
	local awakeEquipCid

	isAwaken, awakeEquipCid = EquipModule.GetIsEquippedAwaken_Cid(equipData)

	if isAwaken then
		local cfgEquip = CfgUtil.GetCfgEquipDataWithID(awakeEquipCid)
		local len = #cfgEquip.SuitId

		for i = 1, len do
			if cfgEquip.SuitId[i] == id then
				return isAwaken
			end
		end

		isAwaken = false
	end

	return isAwaken
end

function EquipModule.GetHeroSuitCountWithSuitID(suitID)
	local count = 0
	local warlockData = EquipModule.GetCurrentHeroData()

	if not warlockData then
		return count
	end

	local equipDataAttr = warlockData.EquipDataArr

	for _, equipData in pairs(equipDataAttr) do
		local cfgEquip = CfgUtil.GetCfgEquipDataWithID(equipData.equipCid)
		local setIdList = cfgEquip.SuitId
		local len = #setIdList

		for j = 1, len do
			if setIdList[j] == suitID then
				count = count + 1
			end
		end
	end

	return count
end

function EquipModule.CalculateCurrentSuitNumList(partIndex)
	EquipModule.equipSuitNumList = {}

	local allItem = WarehouseModule.AllItems

	for _, v in pairs(allItem) do
		if v.equipData and v.equipData:GetEquipCfg().Place == partIndex then
			local cfgEquip = v.equipData:GetEquipCfg()
			local len = #cfgEquip.SuitId

			for i = 1, len do
				if EquipModule.equipSuitNumList[cfgEquip.SuitId[i]] then
					EquipModule.equipSuitNumList[cfgEquip.SuitId[i]] = EquipModule.equipSuitNumList[cfgEquip.SuitId[i]] + 1
				else
					EquipModule.equipSuitNumList[cfgEquip.SuitId[i]] = 1
				end
			end
		end
	end
end

function EquipModule.CalculateCurrentSuitNumListWithPartIndex(partIndex)
	EquipModule.equipSuitNumList = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if _itemData.equipData == nil then
			return
		end

		local equipCfg = _itemData.equipData:GetEquipCfg()

		if partIndex ~= 0 and equipCfg.Place ~= partIndex then
			return
		end

		ForArray(equipCfg.SuitId, function(_, _suitId)
			local cnt = EquipModule.equipSuitNumList[_suitId]

			cnt = cnt == nil and 1 or cnt + 1
			EquipModule.equipSuitNumList[_suitId] = cnt
		end)
	end)
end

function EquipModule.GetSuitNum(suitId)
	if not EquipModule.equipSuitNumList[suitId] then
		return nil
	end

	return EquipModule.equipSuitNumList[suitId]
end

function EquipModule.GetEquipListByScreenData(screenData)
	local equipList = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if not EquipModule.__CheckEquipByScreenData(_itemData.equipData, screenData) then
			return
		end

		table.insert(equipList, _itemData.equipData)
	end)

	return equipList
end

function EquipModule.GetEquipItemListByScreenData(screenData)
	local equipList = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if not EquipModule.__CheckEquipByScreenData(_itemData.equipData, screenData) then
			return
		end

		table.insert(equipList, _itemData)
	end)

	return equipList
end

function EquipModule.__CheckEquipByScreenData(equipData, screenData)
	if equipData == nil then
		return false
	end

	if screenData == nil then
		return true
	end

	return CommonScreenModule.ScreenCheck(equipData, screenData)
end

function EquipModule.SortEquipListBySortType(equipList, sortType, isUp)
	if isUp == nil then
		isUp = true
	end

	if sortType == 1 then
		return EquipModule.CommonSortByLevel(equipList, isUp)
	elseif sortType == 2 then
		return EquipModule.CommonSortByQuality(equipList, isUp)
	elseif sortType == 3 then
		return EquipModule.CommonSortBySuit(equipList, isUp)
	else
		return EquipModule.CommonSortByTime(equipList, isUp)
	end
end

function EquipModule.CommonSortByLevel(equipList, isUp)
	table.sort(equipList, function(a, b)
		local success, result = a:CompareWithLevel(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithQuality(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithSuitID(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithID(b, isUp)

		if success then
			return result
		end

		return false
	end)

	return equipList
end

function EquipModule.CommonSortByQuality(equipList, isUp)
	table.sort(equipList, function(a, b)
		local success, result = a:CompareWithQuality(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithLevel(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithSuitID(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithID(b, isUp)

		if success then
			return result
		end

		return false
	end)

	return equipList
end

function EquipModule.CommonSortBySuit(equipList, isUp)
	table.sort(equipList, function(a, b)
		local success, result = a:CompareWithSuitID(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithLevel(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithQuality(b, isUp)

		if success then
			return result
		end

		success, result = a:CompareWithID(b, isUp)

		if success then
			return result
		end

		return false
	end)

	return equipList
end

function EquipModule.CommonSortByTime(equipList, isUp)
	table.sort(equipList, function(a, b)
		local success, result = a:CompareWithID(b, isUp)

		if success then
			return result
		end

		return false
	end)

	return equipList
end

function EquipModule.GetEquipSuitID(equipData)
	return equipData:GetEquipCfg().SuitId
end
