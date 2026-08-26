-- chunkname: @modules/logic/roomfishing/config/FishingConfig.lua

module("modules.logic.roomfishing.config.FishingConfig", package.seeall)

local FishingConfig = class("FishingConfig", BaseConfig)

function FishingConfig:reqConfigNames()
	return {
		"fishing_const",
		"fishing_map_block",
		"fishing_map_building",
		"fishing_pool",
		"fishing_exchange"
	}
end

function FishingConfig:onInit()
	return
end

function FishingConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

local function checkDictTable(refDict, key)
	local table = refDict[key]

	if not table then
		table = {}
		refDict[key] = table
	end

	return table
end

function FishingConfig:fishing_map_blockConfigLoaded(configTable)
	self._mapBlockDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local blockList = checkDictTable(self._mapBlockDict, cfg.mapId)

		blockList[#blockList + 1] = cfg
	end
end

function FishingConfig:fishing_map_buildingConfigLoaded(configTable)
	self._mapBuildingDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local buildingList = checkDictTable(self._mapBuildingDict, cfg.mapId)

		buildingList[#buildingList + 1] = cfg
	end
end

function FishingConfig:getFishingConstCfg(constId, nilError)
	local cfg = lua_fishing_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("FishingConfig:getFishingConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function FishingConfig:getFishingConst(constId, isToNumber, delimiter)
	local result
	local cfg = self:getFishingConstCfg(constId, true)

	if cfg then
		result = cfg.value

		if not string.nilorempty(delimiter) then
			result = isToNumber and string.splitToNumber(result, delimiter) or string.split(result, delimiter)
		elseif isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function FishingConfig:getFishingMapInfo()
	local mapId = FishingEnum.Const.DefaultMapId

	return {
		mapId = mapId,
		infos = tabletool.copy(self._mapBlockDict[mapId]),
		buildingInfos = tabletool.copy(self._mapBuildingDict[mapId])
	}
end

function FishingConfig:getMaxBuildingUid(mapId)
	local result = 0

	if self._mapBuildingDict and self._mapBuildingDict[mapId] then
		for _, cfg in ipairs(self._mapBuildingDict[mapId]) do
			result = math.max(result, cfg.uid)
		end
	end

	return result
end

function FishingConfig:getFishingPoolCfg(poolId, nilError)
	local cfg = lua_fishing_pool.configDict[poolId]

	if not cfg and nilError then
		logError(string.format("FishingConfig:getFishingPoolCfg error, cfg is nil, poolId:%s", poolId))
	end

	return cfg
end

function FishingConfig:getFishingPoolItem(poolId)
	local cfg = self:getFishingPoolCfg(poolId, true)

	if cfg then
		return string.splitToNumber(cfg.item, "#")
	end
end

function FishingConfig:getFishingShareItem(poolId)
	local cfg = self:getFishingPoolCfg(poolId, true)

	if cfg then
		return string.splitToNumber(cfg.share_item, "#")
	end
end

function FishingConfig:getFishingTime(poolId)
	local cfg = self:getFishingPoolCfg(poolId, true)

	return cfg and cfg.time
end

function FishingConfig:getFishingExchangeCfg(times, nilError)
	local cfg = lua_fishing_exchange.configDict[times]

	if not cfg and nilError then
		logError(string.format("FishingConfig:getFishingExchangeCfg error, cfg is nil, times:%s", times))
	end

	return cfg
end

function FishingConfig:getMaxCostExchangeTimes()
	if not self.maxCostExchangeTimes then
		self.maxCostExchangeTimes = 0

		for _, cfg in ipairs(lua_fishing_exchange.configList) do
			self.maxCostExchangeTimes = math.max(self.maxCostExchangeTimes, cfg.times)
		end
	end

	return self.maxCostExchangeTimes
end

function FishingConfig:getExchangeCost(exchangeTimes)
	local cfg = self:getFishingExchangeCfg(exchangeTimes)

	if not cfg then
		local maxCostTimes = self:getMaxCostExchangeTimes()

		cfg = self:getFishingExchangeCfg(maxCostTimes)
	end

	return cfg.num
end

FishingConfig.instance = FishingConfig.New()

return FishingConfig
