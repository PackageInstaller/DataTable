-- chunkname: @modules/logic/room/config/ManufactureConfig.lua

module("modules.logic.room.config.ManufactureConfig", package.seeall)

local ManufactureConfig = class("ManufactureConfig", BaseConfig)

function ManufactureConfig:reqConfigNames()
	return {
		"manufacture_const",
		"trade_level",
		"manufacture_building",
		"rest_building",
		"manufacture_building_level",
		"manufacture_building_trade_level",
		"manufacture_item",
		"trade_level_unlock"
	}
end

function ManufactureConfig:onInit()
	self._levelGroupDict = {}
	self._tradeLevelGroupDict = {}
	self._belongBuildingDict = nil
	self._belongBuildingTypeDict = nil
	self._itemId2ManufactureItemDict = nil
	self._levelUnlockDict = {}
end

function ManufactureConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function ManufactureConfig:manufacture_itemConfigLoaded(configTable)
	self._itemId2ManufactureItemDict = {}

	for id, config in pairs(configTable.configList) do
		local itemId = config.itemId
		local manufactureItemList = self._itemId2ManufactureItemDict[itemId]

		if not manufactureItemList then
			manufactureItemList = {}
			self._itemId2ManufactureItemDict[itemId] = manufactureItemList
		end

		table.insert(manufactureItemList, id)
	end
end

function ManufactureConfig:trade_levelConfigLoaded(configTable)
	self._systemUnlockLevel = self._systemUnlockLevel or {}

	for _, co in pairs(configTable.configList) do
		if not string.nilorempty(co.unlockId) then
			local split = string.splitToNumber(co.unlockId, "#")

			for _, type in ipairs(split) do
				self._systemUnlockLevel[type] = co.level
			end
		end
	end
end

function ManufactureConfig:manufacture_buildingConfigLoaded(configTable)
	for _, co in pairs(configTable.configList) do
		local placeTradeLevel = co.placeTradeLevel
		local levelUnlock = self._levelUnlockDict[placeTradeLevel]

		if not levelUnlock then
			levelUnlock = {}
			self._levelUnlockDict[placeTradeLevel] = levelUnlock
		end

		local levelList = levelUnlock[RoomTradeEnum.LevelUnlock.NewBuilding]

		if not levelList then
			levelList = {}
			levelUnlock[RoomTradeEnum.LevelUnlock.NewBuilding] = levelList
		end

		table.insert(levelList, co.id)
	end
end

function ManufactureConfig:manufacture_building_levelConfigLoaded(configTable)
	self._levelGroupDict = {}

	for groupId, groupLevelCfgDict in pairs(configTable.configDict) do
		local groupLevelData = {
			maxLevel = 0,
			maxSlotCount = 0,
			manufactureItem2LevelDict = {}
		}

		for level, levelCfg in pairs(groupLevelCfgDict) do
			if level > groupLevelData.maxLevel then
				groupLevelData.maxLevel = level
			end

			local slotCount = levelCfg.slotCount

			if slotCount > groupLevelData.maxSlotCount then
				groupLevelData.maxSlotCount = slotCount
			end

			local manufactureItemList = string.splitToNumber(levelCfg.productions, "#")

			for _, manufactureItemId in ipairs(manufactureItemList) do
				groupLevelData.manufactureItem2LevelDict[manufactureItemId] = level
			end

			local tradeLevel = levelCfg.needTradeLevel
			local levelUnlock = self._levelUnlockDict[tradeLevel]

			if not levelUnlock then
				levelUnlock = {}
				self._levelUnlockDict[tradeLevel] = levelUnlock
			end

			local levelList = levelUnlock[RoomTradeEnum.LevelUnlock.BuildingMaxLevel]

			if not levelList then
				levelList = {}
				levelUnlock[RoomTradeEnum.LevelUnlock.BuildingMaxLevel] = levelList
			end

			if level > 1 then
				local info = {
					groupId = groupId,
					Level = level
				}

				table.insert(levelList, info)
			end
		end

		self._levelGroupDict[groupId] = groupLevelData
	end
end

function ManufactureConfig:manufacture_building_trade_levelConfigLoaded(configTable)
	self._tradeLevelGroupDict = {}

	for tradeGroupId, tradeGroupLevelCfgDict in pairs(configTable.configDict) do
		local tradeGroupLevelData = {
			totalCritterCount = 0
		}

		for _, tradeLevelCfg in pairs(tradeGroupLevelCfgDict) do
			local critterCount = tradeLevelCfg.maxCritterCount

			if critterCount > tradeGroupLevelData.totalCritterCount then
				tradeGroupLevelData.totalCritterCount = critterCount
			end
		end

		self._tradeLevelGroupDict[tradeGroupId] = tradeGroupLevelData
	end
end

function ManufactureConfig:getManufactureConstCfg(constId, nilError)
	local cfg

	if constId then
		cfg = lua_manufacture_const.configDict[constId]
	end

	if not cfg and nilError then
		logError(string.format("ManufactureConfig:getManufactureConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function ManufactureConfig:getManufactureConst(constId)
	local result
	local cfg = self:getManufactureConstCfg(constId, true)

	return (cfg or nil) and cfg.value
end

function ManufactureConfig:getTradeLevelCfg(level, nilError)
	local cfg = lua_trade_level.configDict[level]

	if not cfg and nilError then
		logError(string.format("ManufactureConfig:getTradeLevelCfg error, cfg is nil, level:%s", level))
	end

	return cfg
end

function ManufactureConfig:getUnlockSystemTradeLevel(type, nilError)
	return self._systemUnlockLevel[type]
end

function ManufactureConfig:getManufactureBuildingCfg(buildingId, nilError)
	local cfg = lua_manufacture_building.configDict[buildingId]

	if not cfg and nilError then
		logError(string.format("ManufactureConfig:getManufactureBuildingCfg error, cfg is nil, buildingId:%s", buildingId))
	end

	return cfg
end

function ManufactureConfig:getRestBuildingCfg(buildingId, nilError)
	local cfg = lua_rest_building.configDict[buildingId]

	if not cfg and nilError then
		logError(string.format("ManufactureConfig:getRestBuildingCfg error, cfg is nil, buildingId:%s", buildingId))
	end

	return cfg
end

function ManufactureConfig:isManufactureBuilding(buildingId)
	local buildingType = RoomConfig.instance:getBuildingType(buildingId)

	return (buildingType == RoomBuildingEnum.BuildingType.Collect or buildingType == RoomBuildingEnum.BuildingType.Process or buildingType == RoomBuildingEnum.BuildingType.Manufacture or nil) and true
end

function ManufactureConfig:isManufactureItemBelongBuilding(buildingId, manufactureItemId)
	local groupId = self:getBuildingUpgradeGroup(buildingId)

	if self._levelGroupDict[groupId] then
		return (self._levelGroupDict[groupId][manufactureItemId] or nil) and true
	end
end

function ManufactureConfig:getManufactureItemBelongBuildingList(manufactureItemId)
	self:_initManufactureItemBelongBuildingDict()

	if not self._belongBuildingDict[manufactureItemId] then
		return self._belongBuildingDict[manufactureItemId]
	end
end

function ManufactureConfig:getManufactureItemBelongBuildingType(manufactureItemId)
	self:_initManufactureItemBelongBuildingDict()

	return self._belongBuildingTypeDict[manufactureItemId]
end

function ManufactureConfig:_initManufactureItemBelongBuildingDict()
	if self._belongBuildingDict or self._belongBuildingTypeDict then
		return
	end

	self._belongBuildingDict = {}
	self._belongBuildingTypeDict = {}

	for _, cfg in ipairs(lua_manufacture_building.configList) do
		local groupId = cfg.upgradeGroupId

		if groupId and groupId ~= 0 then
			local buildingId = cfg.id

			if self._levelGroupDict[groupId] then
				if self._levelGroupDict[groupId] then
					local buildingType = RoomConfig.instance:getBuildingType(buildingId)

					for manufactureItemId, _ in pairs(self._levelGroupDict[groupId]) do
						local belongBuildingList = self._belongBuildingDict[manufactureItemId]

						if not belongBuildingList then
							belongBuildingList = {}
							self._belongBuildingDict[manufactureItemId] = belongBuildingList
						end

						belongBuildingList[#belongBuildingList + 1] = buildingId

						local repeatedBuildingType = self._belongBuildingTypeDict[manufactureItemId]

						if not repeatedBuildingType then
							self._belongBuildingTypeDict[manufactureItemId] = buildingType
						elseif repeatedBuildingType ~= buildingType then
							logError(string.format("ManufactureConfig:_initManufactureItemBelongBuildingDict error, buildingType repeated manufactureItemId:%s hasBuildingType:%s newBuildingType:%s", manufactureItemId, repeatedBuildingType, buildingType))
						end
					end
				else
					logError(string.format("ManufactureConfig:_initManufactureItemBelongBuildingDict error, no manu2LevelDict, groupId:%s", groupId))
				end
			end
		end
	end
end

function ManufactureConfig:getManufactureItemNeedLevel(buildingId, manufactureItemId)
	local result
	local isBelong = self:isManufactureItemBelongBuilding(buildingId, manufactureItemId)

	if isBelong then
		local groupId = self:getBuildingUpgradeGroup(buildingId)

		if self._levelGroupDict[groupId] then
			result = self._levelGroupDict[groupId][manufactureItemId]
		end
	else
		logError(string.format("ManufactureConfig:getManufactureItemNeedLevel error, can't product, buildingId:%s manufactureItemId:%s", buildingId, manufactureItemId))
	end

	return result
end

function ManufactureConfig:getAllManufactureItems(buildingId)
	local result = {}
	local groupId = self:getBuildingUpgradeGroup(buildingId)

	if self._levelGroupDict and self._levelGroupDict[groupId] then
		for manufactureItemId, _ in pairs(self._levelGroupDict[groupId].manufactureItem2LevelDict) do
			result[#result + 1] = manufactureItemId
		end
	end

	return result
end

function ManufactureConfig:getAllLevelUnlockInfo(level)
	return self._levelUnlockDict[level]
end

function ManufactureConfig:getBuildingUpgradeGroup(buildingId)
	local cfg = self:getManufactureBuildingCfg(buildingId)

	return (cfg or nil) and cfg.upgradeGroupId
end

function ManufactureConfig:getBuildingIdsByGroup(groupId)
	local ids = {}

	for _, co in ipairs(lua_manufacture_building.configList) do
		if co.upgradeGroupId == groupId then
			table.insert(ids, co.id)
		end
	end

	return ids
end

function ManufactureConfig:getTrainsBuildingCos()
	local ids = {}

	for _, co in ipairs(lua_manufacture_building.configList) do
		if self:isManufactureBuilding(co.id) then
			table.insert(ids, co)
		end
	end

	return ids
end

function ManufactureConfig:getBuildingTradeLevelGroup(buildingId)
	local cfg = self:getManufactureBuildingCfg(buildingId)

	return (cfg or nil) and cfg.tradeGroupId
end

function ManufactureConfig:getBuildingCameraIds(buildingId)
	local result
	local cfg = self:getManufactureBuildingCfg(buildingId)

	return (cfg or nil) and cfg.cameraIds
end

function ManufactureConfig:getBuildingCameraIdByIndex(buildingId, index)
	index = index or 1

	local cameraIds = self:getBuildingCameraIds(buildingId)
	local cameraArray = string.splitToNumber(cameraIds, "#")

	return cameraArray and cameraArray[index]
end

function ManufactureConfig:getBuildingSlotCount(buildingId, buildingLevel)
	local result = 0

	if buildingLevel then
		local groupId = self:getBuildingUpgradeGroup(buildingId)

		result = self:getSlotCount(groupId, buildingLevel)
	else
		logError("ManufactureConfig:getBuildingSlotCount error, buildingLevel is nil")
	end

	return result
end

function ManufactureConfig:getBuildingTotalSlotCount(buildingId)
	local groupId = self:getBuildingUpgradeGroup(buildingId)

	return (self._levelGroupDict[groupId] or nil) and self._levelGroupDict[groupId].maxSlotCount
end

function ManufactureConfig:getBuildingMaxLevel(buildingId)
	local groupId = self:getBuildingUpgradeGroup(buildingId)

	return (self._levelGroupDict[groupId] or nil) and self._levelGroupDict[groupId].maxLevel
end

function ManufactureConfig:getBuildingCanPlaceCritterCount(buildingId, tradeLevel)
	local result = 0

	if tradeLevel then
		local tradeLevelGroupId = self:getBuildingTradeLevelGroup(buildingId)

		result = self:getCritterCount(tradeLevelGroupId, tradeLevel)
	else
		logError("ManufactureConfig:getBuildingCanPlaceCritterCount error, buildingLevel is nil")
	end

	return result
end

function ManufactureConfig:getTotalBuildingCritterCount(buildingId)
	local tradeLevelGroup = self:getBuildingTradeLevelGroup(buildingId)

	return (self._tradeLevelGroupDict[tradeLevelGroup] or nil) and self._tradeLevelGroupDict[tradeLevelGroup].totalCritterCount
end

function ManufactureConfig:getRestBuildingSeatSlotCost(buildingId)
	local result = {}
	local cfg = self:getRestBuildingCfg(buildingId, true)

	if cfg then
		local costArr = GameUtil.splitString2(cfg.buySlotCost, true)

		if costArr then
			for _, costItem in ipairs(costArr) do
				result[#result + 1] = {
					type = costItem[1],
					id = costItem[2],
					quantity = costItem[3]
				}
			end
		end
	end

	return result
end

function ManufactureConfig:getManufactureBuildingIcon(buildingId)
	local result
	local cfg = self:getManufactureBuildingCfg(buildingId)

	return (cfg or nil) and cfg.buildIcon
end

function ManufactureConfig:getManufactureBuildingLevelCfg(groupId, level, nilError)
	if lua_manufacture_building_level.configDict[groupId] then
		if not lua_manufacture_building_level.configDict[groupId] and nilError then
			logError(string.format("ManufactureConfig:getManufactureBuildingLevelCfg error, cfg is nil, groupId:%s, level:%s", groupId, level))
		end

		return lua_manufacture_building_level.configDict[groupId]
	end
end

function ManufactureConfig:getUpgradeCostItemList(groupId, level)
	local result = {}
	local cfg = self:getManufactureBuildingLevelCfg(groupId, level, true)

	if cfg then
		local placeCostArr = GameUtil.splitString2(cfg.cost, true)

		if placeCostArr then
			for _, costItem in ipairs(placeCostArr) do
				result[#result + 1] = {
					type = costItem[1],
					id = costItem[2],
					quantity = costItem[3]
				}
			end
		end
	end

	return result
end

function ManufactureConfig:getNewManufactureItemList(groupId, level)
	local cfg = self:getManufactureBuildingLevelCfg(groupId, level, true)

	return (cfg or nil) and string.splitToNumber(cfg.productions, "#")
end

function ManufactureConfig:getNeedTradeLevel(groupId, level)
	local result
	local cfg = self:getManufactureBuildingLevelCfg(groupId, level, true)

	return (cfg or nil) and cfg.needTradeLevel
end

function ManufactureConfig:getSlotCount(groupId, level)
	local cfg = self:getManufactureBuildingLevelCfg(groupId, level, true)

	return (cfg or nil) and cfg.slotCount
end

function ManufactureConfig:getSlotUnlockNeedLevel(groupId, slotIndex)
	local result = 0
	local levelCfgDict = lua_manufacture_building_level.configDict[groupId]

	if levelCfgDict then
		local tmpLevel

		for level, cfg in pairs(levelCfgDict) do
			local slotCount = cfg.slotCount

			if slotIndex <= slotCount and (not tmpLevel or level < tmpLevel) then
				tmpLevel = level
			end
		end

		result = tmpLevel or result
	end

	return result
end

function ManufactureConfig:getManufactureBuildingTradeLevelCfg(tradeGroupId, tradeLevel, nilError)
	if lua_manufacture_building_trade_level.configDict[tradeGroupId] then
		if not lua_manufacture_building_trade_level.configDict[tradeGroupId] and nilError then
			logError(string.format("ManufactureConfig:getManufactureBuildingTradeLevelCfg error, cfg is nil, tradeGroupId:%s, tradeLevel:%s", tradeGroupId, tradeLevel))
		end

		return lua_manufacture_building_trade_level.configDict[tradeGroupId]
	end
end

function ManufactureConfig:getCritterCount(tradeGroupId, tradeLevel)
	local result = 0

	for i = tradeLevel, 0, -1 do
		local cfg = self:getManufactureBuildingTradeLevelCfg(tradeGroupId, i)

		if cfg then
			result = cfg.maxCritterCount

			break
		end
	end

	return result
end

function ManufactureConfig:getManufactureItemCfg(manufactureItemId, nilError)
	local cfg = lua_manufacture_item.configDict[manufactureItemId]

	if not cfg and nilError then
		logError(string.format("ManufactureConfig:getManufactureItemCfg error, cfg is nil, itemId:%s", manufactureItemId))
	end

	return cfg
end

function ManufactureConfig:getNeedMatItemList(manufactureItemId)
	local result = {}
	local cfg = self:getManufactureItemCfg(manufactureItemId, true)

	if cfg then
		local arrDataList = GameUtil.splitString2(cfg.needMat, true)

		if arrDataList then
			for _, data in ipairs(arrDataList) do
				result[#result + 1] = {
					id = data[1],
					quantity = data[2]
				}
			end
		end
	end

	return result
end

function ManufactureConfig:getItemId(manufactureItemId)
	local result
	local cfg = self:getManufactureItemCfg(manufactureItemId, true)

	return (cfg or nil) and cfg.itemId
end

function ManufactureConfig:getUnitCount(manufactureItemId)
	local cfg = self:getManufactureItemCfg(manufactureItemId, true)

	return (cfg or nil) and cfg.unitCount
end

function ManufactureConfig:getNeedTime(manufactureItemId)
	local cfg = self:getManufactureItemCfg(manufactureItemId, true)

	return (cfg or nil) and cfg.needTime
end

function ManufactureConfig:getBatchIconPath(manufactureItemId)
	local result
	local cfg = self:getManufactureItemCfg(manufactureItemId, true)

	return (cfg and not string.nilorempty(cfg.batchIcon) or nil) and ResUrl.getPropItemIcon(cfg.batchIcon)
end

function ManufactureConfig:getBatchName(manufactureItemId)
	local result
	local cfg = self:getManufactureItemCfg(manufactureItemId, true)

	return (cfg or nil) and cfg.batchName
end

function ManufactureConfig:getManufactureItemName(manufactureItemId)
	local itemName = self:getBatchName(manufactureItemId)

	if string.nilorempty(itemName) then
		local itemId = self:getItemId(manufactureItemId)

		itemName = ItemConfig.instance:getItemNameById(itemId)
	end

	return itemName
end

function ManufactureConfig:getManufactureItemListByItemId(itemId)
	if self._itemId2ManufactureItemDict then
		if not self._itemId2ManufactureItemDict[itemId] then
			return {}
		end
	end
end

function ManufactureConfig:getManufactureItemUnitCountRange(manufactureItemId)
	local max = self:getUnitCount(manufactureItemId)
	local min = self:getUnitCount(manufactureItemId)
	local itemId = self:getItemId(manufactureItemId)
	local manufactureItemIdList = self:getManufactureItemListByItemId(itemId)

	for _, manufactureItem in ipairs(manufactureItemIdList) do
		local unitCount = self:getUnitCount(manufactureItem)

		max = math.max(max, unitCount)
		min = math.min(min, unitCount)
	end

	return max, min
end

ManufactureConfig.instance = ManufactureConfig.New()

return ManufactureConfig
