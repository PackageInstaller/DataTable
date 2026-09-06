-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/config/LiYangKingConfig.lua

module("logic.extensions.liyangking.config.LiYangKingConfig", package.seeall)

local LiYangKingConfig = class("LiYangKingConfig", BaseConfig)

function LiYangKingConfig:onInit()
	LiYangKingConfig.super.onInit(self)
end

function LiYangKingConfig:getNames()
	return {
		"prince_liyang_actiivty",
		"prince_liyang_level",
		"prince_liyang_attribute",
		"prince_liyang_attribute_level",
		"prince_liyang_building",
		"prince_liyang_building_level",
		"prince_liyang_event",
		"prince_liyang_event_option",
		"prince_liyang_position",
		"prince_liyang_reset",
		"prince_liyang_star",
		"prince_liyang_star_show",
		"prince_liyang_rank_prize",
		"prince_liyang_team",
		"prince_liyang_creeps"
	}
end

function LiYangKingConfig:handleConfig(name, content)
	if name == "prince_liyang_actiivty" then
		self._prince_liyang_actiivty = content
	elseif name == "prince_liyang_level" then
		self._prince_liyang_level = content
	elseif name == "prince_liyang_attribute" then
		self._prince_liyang_attribute = content

		self:_initAttrMapByItemId()
	elseif name == "prince_liyang_attribute_level" then
		self._prince_liyang_attribute_level = content
	elseif name == "prince_liyang_building" then
		self._prince_liyang_building = content
	elseif name == "prince_liyang_building_level" then
		self._prince_liyang_building_level = content
	elseif name == "prince_liyang_event" then
		self._prince_liyang_event = content

		self:_initEventMap()
	elseif name == "prince_liyang_event_option" then
		self._prince_liyang_event_option = content
	elseif name == "prince_liyang_position" then
		self._prince_liyang_position = content
	elseif name == "prince_liyang_reset" then
		self._prince_liyang_reset = content

		self:_initResetMap()
	elseif name == "prince_liyang_star" then
		self._prince_liyang_star = content
	elseif name == "prince_liyang_star_show" then
		self._prince_liyang_star_show = content
	elseif name == "prince_liyang_rank_prize" then
		self._prince_liyang_rank_prize = content
	elseif name == "prince_liyang_team" then
		self._prince_liyang_team = content
	elseif name == "prince_liyang_creeps" then
		self._prince_liyang_creeps = content
	end
end

function LiYangKingConfig:_initEventMap()
	self._eventMaps = {}

	for activityId, cfgs in pairs(self._prince_liyang_event) do
		self._eventMaps[activityId] = {}

		local curEventMap = self._eventMaps[activityId]

		for i, cfg in ipairs(cfgs) do
			curEventMap[cfg.buildingId] = curEventMap[cfg.buildingId] or {}

			local eventList = curEventMap[cfg.buildingId]

			table.insert(eventList, cfg.eventId)
		end
	end
end

function LiYangKingConfig:getEventIdMap(activityId)
	return self._eventMaps[activityId]
end

function LiYangKingConfig:_initAttrMapByItemId()
	self._attrMaps = {}

	for activityId, cfgs in pairs(self._prince_liyang_attribute) do
		self._attrMaps[activityId] = {}

		local curAttrMap = self._attrMaps[activityId]

		for _, cfg in ipairs(cfgs) do
			curAttrMap[cfg.itemId] = cfg
		end
	end
end

function LiYangKingConfig:getAttrMap(activityId)
	return self._attrMaps[activityId]
end

function LiYangKingConfig:_initResetMap()
	self._resetMaps = {}

	for activityId, cfgs in pairs(self._prince_liyang_reset) do
		self._resetMaps[activityId] = {}

		local curResetMap = self._resetMaps[activityId]

		for _, cfg in ipairs(cfgs) do
			local costStr = cfg.cost
			local matType, matId, matNum = MaterialMgr.getMatParams(costStr)

			curResetMap[cfg.times] = matNum
		end
	end
end

function LiYangKingConfig:getResetMap(activityId)
	return self._resetMaps[activityId]
end

function LiYangKingConfig:getActCfg(activityId)
	return self._prince_liyang_actiivty[activityId]
end

function LiYangKingConfig:getLevelCfgs(activityId)
	return self._prince_liyang_level[activityId]
end

function LiYangKingConfig:getLevelCfgByLevel(activityId, level)
	return self._prince_liyang_level[activityId] and self._prince_liyang_level[activityId][level]
end

function LiYangKingConfig:getAttributeCfgs(activityId)
	return self._prince_liyang_attribute[activityId]
end

function LiYangKingConfig:getAttributeCfgById(activityId, id)
	return self._prince_liyang_attribute[activityId] and self._prince_liyang_attribute[activityId][id]
end

function LiYangKingConfig:getAttributeLevelCfgs(activityId)
	return self._prince_liyang_attribute_level[activityId]
end

function LiYangKingConfig:getAttributeLevelCfgsById(activityId, id)
	return self._prince_liyang_attribute_level[activityId] and self._prince_liyang_attribute_level[activityId][id]
end

function LiYangKingConfig:getAttributeLevelCfgByIdLevel(activityId, id, level)
	local attributeLevelCfgs = self:getAttributeLevelCfgsById(activityId, id)

	return attributeLevelCfgs and attributeLevelCfgs[level]
end

function LiYangKingConfig:getBuildingCfgs(activityId)
	return self._prince_liyang_building[activityId]
end

function LiYangKingConfig:getBuildingCfgByBuildingId(activityId, buildingId)
	return self._prince_liyang_building[activityId] and self._prince_liyang_building[activityId][buildingId]
end

function LiYangKingConfig:getBuildingLevelCfgs(activityId)
	return self._prince_liyang_building_level[activityId]
end

function LiYangKingConfig:getBuildingLevelCfgsByBuildingId(activityId, buildingId)
	return self._prince_liyang_building_level[activityId] and self._prince_liyang_building_level[activityId][buildingId]
end

function LiYangKingConfig:getBuildingLevelCfgBybuildIdlevel(activityId, buildingId, level)
	local buildingLevelCfgs = self:getBuildingLevelCfgsByBuildingId(activityId, buildingId)

	return buildingLevelCfgs and buildingLevelCfgs[level]
end

function LiYangKingConfig:getBuildingEventCfgs(activityId)
	return self._prince_liyang_event[activityId]
end

function LiYangKingConfig:getBuildingEventCfgByEventId(activityId, eventId)
	return self._prince_liyang_event[activityId] and self._prince_liyang_event[activityId][eventId]
end

function LiYangKingConfig:getBuildingEventOptionCfgs(activityId)
	return self._prince_liyang_event_option[activityId]
end

function LiYangKingConfig:getBuildingEventOptionCfgByEventId(activityId, eventId)
	return self._prince_liyang_event_option[activityId] and self._prince_liyang_event_option[activityId][eventId]
end

function LiYangKingConfig:getPositionCfgs(activityId)
	return self._prince_liyang_position[activityId]
end

function LiYangKingConfig:getPositionCfgByPosId(activityId, posId)
	return self._prince_liyang_position[activityId] and self._prince_liyang_position[activityId][posId]
end

function LiYangKingConfig:getResetCfgs(activityId)
	return self._prince_liyang_reset[activityId]
end

function LiYangKingConfig:getResetCfgByTimes(activityId, times)
	return self._prince_liyang_reset[activityId] and self._prince_liyang_reset[activityId][times]
end

function LiYangKingConfig:getStarCfgs(activityId)
	return self._prince_liyang_star[activityId]
end

function LiYangKingConfig:getStarCfgById(activityId, id)
	return self._prince_liyang_star[activityId] and self._prince_liyang_star[activityId][id]
end

function LiYangKingConfig:getStarShowCfgsByTypeId(activityId, typeId)
	return self._prince_liyang_star[activityId] and self._prince_liyang_star[activityId][typeId]
end

function LiYangKingConfig:getStarShowCfgByTypeIdStar(activityId, typeId, star)
	if self._prince_liyang_star[activityId] then
		if self._prince_liyang_star[activityId] then
			return self._prince_liyang_star[activityId][star]
		end
	end
end

function LiYangKingConfig:getRankPrizeCfgs(activityId)
	return self._prince_liyang_rank_prize[activityId]
end

function LiYangKingConfig:getCreepCfgs(creepMasterId)
	return self._prince_liyang_creeps[creepMasterId]
end

function LiYangKingConfig:getChapter3ExploreStarShowCfgs(activityId, typeId)
	if self._prince_liyang_star_show[activityId] then
		return self._prince_liyang_star_show[activityId][typeId]
	end
end

function LiYangKingConfig:getChapter3ExploreStarShowCfgByStar(activityId, typeId, star)
	if self._prince_liyang_star_show[activityId] and self._prince_liyang_star_show[activityId][typeId] then
		return self._prince_liyang_star_show[activityId][typeId][star]
	end
end

function LiYangKingConfig:getChapter3ExploreCfgs(activityId)
	return self._prince_liyang_position[activityId]
end

function LiYangKingConfig:getChapter3ExploreCfgByPosId(activityId, posId)
	if self._prince_liyang_position[activityId] then
		return self._prince_liyang_position[activityId][posId]
	end
end

function LiYangKingConfig:getChapter3ExploreResetCfgs(activityId)
	return self._prince_liyang_reset[activityId]
end

function LiYangKingConfig:getChapter3ExploreStarCfg(activityId, id)
	if self._prince_liyang_star[activityId] then
		return self._prince_liyang_star[activityId][id]
	end
end

function LiYangKingConfig:getTeamCfg(creepsMasterId)
	return self._prince_liyang_team[creepsMasterId]
end

function LiYangKingConfig:getCreepCfgs(creepsMasterId)
	return self._prince_liyang_creeps[creepsMasterId]
end

function LiYangKingConfig:getResetCostStr(activityId)
	local resetCfgs = self:getChapter3ExploreResetCfgs(activityId)
	local resetCfg = resetCfgs[1]

	return resetCfg.cost
end

LiYangKingConfig.instance = LiYangKingConfig.New()

return LiYangKingConfig
