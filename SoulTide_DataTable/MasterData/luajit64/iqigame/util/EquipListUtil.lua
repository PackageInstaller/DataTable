-- chunkname: @IQIGame\\Util\\EquipListUtil.lua

EquipListUtil = {
	_subTypFilterIndexMap = {
		1,
		nil,
		2,
		3,
		4
	}
}

function EquipListUtil.IsFilterEmpty(filterPattern)
	if table.isNilOrEmpty(filterPattern) then
		return true
	end

	if table.isNilOrEmpty(filterPattern.Quality, true) and table.isNilOrEmpty(filterPattern.SubType, true) and table.isNilOrEmpty(filterPattern.WearState, true) and table.isNilOrEmpty(filterPattern.Skin, true) and table.isNilOrEmpty(filterPattern.Strengthen, true) then
		return true
	end

	return false
end

function EquipListUtil.Filter(list, filterPattern)
	if EquipListUtil.IsFilterEmpty(filterPattern) then
		return list
	end

	local newList = {}

	for i = 1, #list do
		local itemData = list[i]
		local cfgItemData = itemData:GetCfg()

		if (table.isNilOrEmpty(filterPattern.Quality) or table.indexOf(filterPattern.Quality, EquipListUtil._GetQualityFilterIndex(cfgItemData.Quality)) ~= -1) and (table.isNilOrEmpty(filterPattern.SubType) or table.indexOf(filterPattern.SubType, EquipListUtil._GetSubTypeFilterIndex(cfgItemData.SubType)) ~= -1) and (table.isNilOrEmpty(filterPattern.WearState) or table.indexOf(filterPattern.WearState, EquipListUtil._GetWearFilterIndex(itemData.equipData.isWore)) ~= -1) and EquipListUtil._IsSkinStateFit(filterPattern.Skin, itemData.cid) and (table.isNilOrEmpty(filterPattern.Strengthen) or table.indexOf(filterPattern.Strengthen, EquipListUtil._GetStrengthenFilterIndex(itemData)) ~= -1) then
			table.insert(newList, itemData)
		end
	end

	return newList
end

function EquipListUtil.Sort(list, sortType, isDesc, wearingEquipMap)
	if sortType ~= nil and (sortType < 0 or sortType > 5) then
		logError("sortType不能小于0或大于5")

		return list
	end

	local equipsOnPrefabMap = {}

	if wearingEquipMap ~= nil then
		for i, itemData in pairs(wearingEquipMap) do
			equipsOnPrefabMap[itemData.id] = i
		end
	end

	local sortPriority = {
		Constant.EquipSortType.TypeQuality,
		Constant.EquipSortType.TypeStar,
		Constant.EquipSortType.TypeStrengthenLv,
		Constant.EquipSortType.TypeCID,
		Constant.EquipSortType.TypeHasNum
	}

	if sortType ~= nil and sortType ~= 0 then
		local index = table.indexOf(sortPriority, sortType)

		table.remove(sortPriority, index)
		table.insert(sortPriority, 1, sortType)
	end

	local equipKeyDataMap = {}
	local itemCidNumMap = WarehouseModule.GetItemCIDNumMap()

	for i = 1, #list do
		local itemData = list[i]
		local cfgItemData = itemData:GetCfg()

		equipKeyDataMap[itemData.id] = {
			[Constant.EquipSortType.TypeQuality] = cfgItemData.Quality,
			[Constant.EquipSortType.TypeStar] = itemData.equipData.star,
			[Constant.EquipSortType.TypeStrengthenLv] = itemData.equipData.lv,
			[Constant.EquipSortType.TypeCID] = itemData.cid,
			[Constant.EquipSortType.TypeHasNum] = itemCidNumMap[itemData.cid]
		}
	end

	table.sort(list, function(itemData1, itemData2)
		local prefabIndex1 = equipsOnPrefabMap[itemData1.id] or 4
		local prefabIndex2 = equipsOnPrefabMap[itemData2.id] or 4

		if prefabIndex1 ~= prefabIndex2 then
			return prefabIndex1 < prefabIndex2
		else
			for i = 1, #sortPriority do
				local priority = sortPriority[i]
				local priorityValue1 = equipKeyDataMap[itemData1.id][priority]
				local priorityValue2 = equipKeyDataMap[itemData2.id][priority]

				if priorityValue1 ~= priorityValue2 then
					return EquipListUtil.__CompareTwoValue(priorityValue1, priorityValue2, isDesc)
				end
			end

			return false
		end
	end)

	return list
end

function EquipListUtil.__CompareTwoValue(value1, value2, isDesc)
	if isDesc then
		return value2 < value1
	else
		return value1 < value2
	end
end

function EquipListUtil._GetQualityFilterIndex(quality)
	return quality - 1
end

function EquipListUtil._GetSubTypeFilterIndex(subType)
	local filterIndex = EquipListUtil._subTypFilterIndexMap[subType]

	return filterIndex or 0
end

function EquipListUtil._GetWearFilterIndex(isWearing)
	return isWearing and 2 or 1
end

function EquipListUtil._IsSkinStateFit(chosenBtnIndexes, itemCid)
	if table.isNilOrEmpty(chosenBtnIndexes) then
		return true
	end

	local skins = EquipModule.GetEquipSkins(itemCid, true)

	if skins == nil or #skins == 0 then
		return false
	end

	local hasUnlock = false
	local isUsing = false

	for i = 1, #skins do
		local state = EquipModule.GetSkinState(skins[i])

		if state ~= nil then
			hasUnlock = true

			if state == 1 then
				isUsing = true

				break
			end
		end
	end

	for i = 1, #chosenBtnIndexes do
		local chosenIndex = chosenBtnIndexes[i]

		if chosenIndex == 1 then
			return true
		elseif chosenIndex == 2 and hasUnlock then
			return true
		elseif chosenIndex == 3 and isUsing then
			return true
		end
	end

	return false
end

function EquipListUtil._GetStrengthenFilterIndex(itemData)
	local cfgItemData = itemData:GetCfg()
	local cfgDiscrete = CfgDiscreteDataTable[6520037]
	local qualityMaxLvMap = cfgDiscrete.Data
	local maxLv = qualityMaxLvMap[cfgItemData.Quality] or 0
	local maxStar = cfgItemData.StarLimit or 0

	if itemData.equipData == nil then
		return 0
	end

	if maxLv <= itemData.equipData.lv and maxStar <= itemData.equipData.star then
		return 1
	end

	if itemData.equipData.lv == 1 and itemData.equipData.star == 1 then
		return 3
	end

	return 2
end
