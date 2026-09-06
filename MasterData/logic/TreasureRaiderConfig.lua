-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/config/TreasureRaiderConfig.lua

module("logic.extensions.treasureraider.config.TreasureRaiderConfig", package.seeall)

local TreasureRaiderConfig = class("TreasureRaiderConfig", BaseConfig)

function TreasureRaiderConfig:onInit()
	TreasureRaiderConfig.super.onInit(self)
end

function TreasureRaiderConfig:getNames()
	return {
		"richman_common",
		"richman_activity",
		"richman_map",
		"richman_camplevel",
		"richman_building",
		"richman_resource_plan",
		"richman_buff_plan",
		"richman_buff",
		"richman_rank",
		"richman_building_tab"
	}
end

function TreasureRaiderConfig:handleConfig(name, content)
	if name == "richman_common" then
		self._richman_common = content
	elseif name == "richman_activity" then
		self._richman_activity = content
	elseif name == "richman_map" then
		self._richman_map = content
		self._movePathGridIdsMap = {}

		for _, config in pairs(self._richman_map.dataList) do
			self._movePathGridIdsMap[config.mapPlan] = self._movePathGridIdsMap[config.mapPlan] or {}

			for _, gridId in ipairs(config.movePathGridIds) do
				self._movePathGridIdsMap[config.mapPlan][gridId] = true
			end
		end
	elseif name == "richman_camplevel" then
		self._richman_camplevel = content
	elseif name == "richman_building" then
		self._richman_building = content
		self._buildingType2ConfigsMap = {}
		self._fixBuildingGridIdMap = {}

		for _, config in pairs(self._richman_building.dataList) do
			if not self._buildingType2ConfigsMap[config.bPlanId] then
				self._buildingType2ConfigsMap[config.bPlanId] = self._buildingType2ConfigsMap[config.bPlanId]
				self._buildingType2ConfigsMap[config.bPlanId][config.type] = self._buildingType2ConfigsMap[config.bPlanId][config.type] or {}

				table.insert(self._buildingType2ConfigsMap[config.bPlanId][config.type], config)

				if not self._fixBuildingGridIdMap[config.bPlanId] then
					self._fixBuildingGridIdMap[config.bPlanId] = self._fixBuildingGridIdMap[config.bPlanId]

					if TreasureRaiderConst.BuildingTypeEditDisableMap[config.type] then
						self._fixBuildingGridIdMap[config.bPlanId][config.initPos] = true
					end
				end
			end
		end
	elseif name == "richman_resource_plan" then
		self._richman_resource_plan = content
	elseif name == "richman_buff_plan" then
		self._richman_buff_plan = content
	elseif name == "richman_buff" then
		self._richman_buff = content
	elseif name == "richman_rank" then
		self._richman_rank = content
	elseif name == "richman_building_tab" then
		self._richman_building_tab = content
	end
end

function TreasureRaiderConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._richman_common and self._richman_common[key] then
		str = self._richman_common[key].value
	end

	if isToNumber then
		str = checknumber(str)
	end

	return str
end

function TreasureRaiderConfig:getActivityId()
	return 230002
end

function TreasureRaiderConfig:getActivityConfig(activityId)
	activityId = activityId or self:getActivityId()

	return self._richman_activity[activityId]
end

function TreasureRaiderConfig:getMapPlanId(activityId)
	return self:getActivityConfig(activityId).mapPlan
end

function TreasureRaiderConfig:getCampPlanId(activityId)
	return self:getActivityConfig(activityId).campPlanId
end

function TreasureRaiderConfig:getBuildingPlanId(activityId)
	return self:getActivityConfig(activityId).bPlanId
end

function TreasureRaiderConfig:getRevengeBuffId(activityId)
	return self:getActivityConfig(activityId).revengeBuffId
end

function TreasureRaiderConfig:getRankPlanId(activityId)
	return self:getActivityConfig(activityId).rankPlanId
end

function TreasureRaiderConfig:getPathConfig(mapPlanId, activityId)
	mapPlanId = mapPlanId or self:getMapPlanId(activityId)

	return self._richman_map[mapPlanId]
end

function TreasureRaiderConfig:getBirthPos(mapPlanId, activityId)
	local config = self:getPathConfig(mapPlanId, activityId) or {}

	return config.teamInitPoint
end

function TreasureRaiderConfig:getBuildingConfigs(buildingPlanId, activityId)
	buildingPlanId = buildingPlanId or self:getBuildingPlanId(activityId)

	return self._richman_building[buildingPlanId]
end

function TreasureRaiderConfig:getBuildingConfigByTypes(types, activityId)
	local buildingPlanId = self:getBuildingPlanId(activityId)
	local map = self._buildingType2ConfigsMap[buildingPlanId]
	local configs = {}

	for _, t in ipairs(types) do
		local array = map[t]

		for _, config in ipairs(array) do
			table.insert(configs, config)
		end
	end

	return configs
end

function TreasureRaiderConfig:getBuildingConfigMapByAllTypes(activityId)
	local buildingPlanId = self:getBuildingPlanId(activityId)

	return self._buildingType2ConfigsMap[buildingPlanId]
end

function TreasureRaiderConfig:isMovePathGrid(gridId, mapPlanId, activityId)
	mapPlanId = mapPlanId or self:getMapPlanId(activityId)

	return self._movePathGridIdsMap[mapPlanId][gridId]
end

function TreasureRaiderConfig:isGridDisableToEdit(gridId, buildingPlanId, activityId)
	buildingPlanId = buildingPlanId or self:getBuildingPlanId(activityId)

	return self._fixBuildingGridIdMap[buildingPlanId][gridId]
end

function TreasureRaiderConfig:getBuildingConfig(buildingId, buildingPlanId, activityId)
	buildingPlanId = buildingPlanId or self:getBuildingPlanId(activityId)

	return self._richman_building[buildingPlanId][buildingId]
end

function TreasureRaiderConfig:getBuildingTab()
	return self._richman_building_tab
end

function TreasureRaiderConfig:getBuildingBuffByPlanId(buffPlanId)
	return self._richman_buff_plan[buffPlanId]
end

function TreasureRaiderConfig:getRankPrizeConfigs(rankPlanId, activityId)
	rankPlanId = rankPlanId or self:getRankPlanId(activityId)

	return self._richman_rank[rankPlanId]
end

function TreasureRaiderConfig:getResourcePlanConfigs(srcPlanId)
	return self._richman_resource_plan[srcPlanId]
end

function TreasureRaiderConfig:getResourcePlanConfig(srcPlanId, level)
	local configs = self:getResourcePlanConfigs(srcPlanId) or {}

	return configs[level]
end

function TreasureRaiderConfig:getMainCampConfig(level, campPlanId, activityId)
	campPlanId = campPlanId or self:getCampPlanId(activityId)

	if not self._richman_camplevel[campPlanId] then
		local configs = {}

		level = math.min(level, #configs)

		return configs[level]
	end
end

TreasureRaiderConfig.instance = TreasureRaiderConfig.New()

return TreasureRaiderConfig
