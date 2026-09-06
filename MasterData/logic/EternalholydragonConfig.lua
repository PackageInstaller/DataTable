-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/config/EternalholydragonConfig.lua

module("logic.extensions.eternalholydragon.config.EternalholydragonConfig", package.seeall)

local EternalholydragonConfig = class("EternalholydragonConfig", BaseConfig)

function EternalholydragonConfig:onInit()
	return
end

function EternalholydragonConfig:getNames()
	return {
		"eternal_holy_dragon_clg_activity_define",
		"eternal_holy_dragon_clg_cheer_plan_define",
		"eternal_holy_dragon_clg_stage_define",
		"eternal_holy_dragon_clg_map_define",
		"eternal_holy_dragon_clg_map_grid_define",
		"eternal_holy_dragon_clg_item_define",
		"eternal_holy_dragon_clg_monster",
		"eternal_holy_dragon_clg_creeps"
	}
end

function EternalholydragonConfig:handleConfig(name, content)
	if name == "eternal_holy_dragon_clg_activity_define" then
		self._eternal_holy_dragon_clg_activity_define = content
	elseif name == "eternal_holy_dragon_clg_cheer_plan_define" then
		self._eternal_holy_dragon_clg_cheer_plan_define = content
	elseif name == "eternal_holy_dragon_clg_stage_define" then
		self._eternal_holy_dragon_clg_stage_define = content
	elseif name == "eternal_holy_dragon_clg_map_define" then
		self._eternal_holy_dragon_clg_map_define = content
	elseif name == "eternal_holy_dragon_clg_map_grid_define" then
		self._eternal_holy_dragon_clg_map_grid_define = content
	elseif name == "eternal_holy_dragon_clg_item_define" then
		self._eternal_holy_dragon_clg_item_define = content
	elseif name == "eternal_holy_dragon_clg_monster" then
		self._eternal_holy_dragon_clg_monster = content
	elseif name == "eternal_holy_dragon_clg_creeps" then
		self._eternal_holy_dragon_clg_creeps = content
	end
end

function EternalholydragonConfig:getActivityCfg(activityId)
	return self._eternal_holy_dragon_clg_activity_define[activityId]
end

function EternalholydragonConfig:getMapCfgs(mapId)
	return self._eternal_holy_dragon_clg_map_define[mapId]
end

function EternalholydragonConfig:getGridCfg(mapId, gridId)
	return self._eternal_holy_dragon_clg_map_grid_define[mapId][gridId]
end

function EternalholydragonConfig:getItemCfg(itemPlanId, itemId)
	return self._eternal_holy_dragon_clg_item_define[itemPlanId][itemId]
end

function EternalholydragonConfig:getStageCfg(activityId, stageId)
	return self._eternal_holy_dragon_clg_stage_define[activityId][stageId]
end

function EternalholydragonConfig:getStageCfgs(activityId)
	return self._eternal_holy_dragon_clg_stage_define[activityId]
end

function EternalholydragonConfig:getItemMaxOwnCount(activityId, stageId)
	return self._eternal_holy_dragon_clg_stage_define[activityId][stageId].itemMaxOwnCount
end

function EternalholydragonConfig:getCreepMonstersCfgs(creepsMasterId)
	return self._eternal_holy_dragon_clg_creeps[creepsMasterId]
end

function EternalholydragonConfig:getCreepCfg(creepsMasterId)
	return self._eternal_holy_dragon_clg_monster[creepsMasterId]
end

function EternalholydragonConfig:getClearLandItemIds(itemPlanId)
	self._clearLandItemIds = self._clearLandItemIds or {}

	if self._clearLandItemIds[itemPlanId] then
		return self._clearLandItemIds[itemPlanId]
	end

	self._clearLandItemIds[itemPlanId] = {}

	for pid, list in ipairs(self._eternal_holy_dragon_clg_item_define) do
		for i, v in ipairs(list) do
			if v.itemClazz == "CLEAR_LAND_MONSTER" then
				self._clearLandItemIds[itemPlanId][v.itemId] = true
			end
		end
	end

	return self._clearLandItemIds[itemPlanId]
end

EternalholydragonConfig.instance = EternalholydragonConfig.New()

return EternalholydragonConfig
