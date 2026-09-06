-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/config/UniqueWorldConfig.lua

module("logic.extensions.uniqueworld.config.UniqueWorldConfig", package.seeall)

local UniqueWorldConfig = class("UniqueWorldConfig", BaseConfig)

function UniqueWorldConfig:getNames()
	return {
		"unique_world_activity",
		"unique_world_rule",
		"unique_world_level_plan",
		"unique_world_map",
		"unique_world_item",
		"unique_world_system_pet",
		"unique_world_shop_item",
		"unique_world_buff",
		"unique_world_box_event",
		"unique_world_mining_event",
		"unique_world_npc",
		"unique_world_npc_event",
		"unique_world_fight_event",
		"unique_world_creeps_master",
		"unique_world_creeps"
	}
end

function UniqueWorldConfig:handleConfig(name, content)
	if name == "unique_world_activity" then
		self._unique_world_activity = content
	elseif name == "unique_world_rule" then
		self._unique_world_rule = content
	elseif name == "unique_world_level_plan" then
		self._unique_world_level_plan = content
	elseif name == "unique_world_map" then
		self._unique_world_map = content
	elseif name == "unique_world_item" then
		self._unique_world_item = content
	elseif name == "unique_world_system_pet" then
		self._unique_world_system_pet = content
	elseif name == "unique_world_shop_item" then
		self._unique_world_shop_item = content
	elseif name == "unique_world_buff" then
		self._unique_world_buff = content
	elseif name == "unique_world_box_event" then
		self._unique_world_box_event = content
	elseif name == "unique_world_mining_event" then
		self._unique_world_mining_event = content
	elseif name == "unique_world_npc" then
		self._unique_world_npc = content
	elseif name == "unique_world_npc_event" then
		self._unique_world_npc_event = content
	elseif name == "unique_world_fight_event" then
		self._unique_world_fight_event = content
	elseif name == "unique_world_creeps_master" then
		self._unique_world_creeps_master = content
	elseif name == "unique_world_creeps" then
		self._unique_world_creeps = content
	end
end

function UniqueWorldConfig:getActCfg(activityId)
	return self._unique_world_activity[activityId]
end

function UniqueWorldConfig:getRuleCfgs(ruleId)
	return self._unique_world_rule[ruleId]
end

function UniqueWorldConfig:getLevelPlanCfgsById(activityId, gameId, level)
	local cfgs = self._unique_world_level_plan[activityId]

	if cfgs then
		return cfgs[gameId] and cfgs[gameId][level]
	end
end

function UniqueWorldConfig:getMapCfgs(mapId)
	return self._unique_world_map[mapId]
end

function UniqueWorldConfig:getMapCfg(mapId, gridId)
	return self._unique_world_map[mapId] and self._unique_world_map[mapId][gridId]
end

function UniqueWorldConfig:getItemCfg(itemId)
	return self._unique_world_item[itemId]
end

function UniqueWorldConfig:getSystemPetCfg(creepsId)
	return self._unique_world_system_pet[creepsId]
end

function UniqueWorldConfig:getShopCfgs(eventId)
	return self._unique_world_shop_item[eventId]
end

function UniqueWorldConfig:getShopCfgById(eventId, id)
	return self._unique_world_shop_item[eventId] and self._unique_world_shop_item[eventId][id]
end

function UniqueWorldConfig:getBuffCfgById(id)
	return self._unique_world_buff[id]
end

function UniqueWorldConfig:getBoxEventCfg(eventId)
	return self._unique_world_box_event[eventId]
end

function UniqueWorldConfig:getMiningEventCfg(eventId)
	return self._unique_world_mining_event[eventId]
end

function UniqueWorldConfig:getNpcCfg(eventId)
	return self._unique_world_npc[eventId]
end

function UniqueWorldConfig:getNpcEventCfg(eventId)
	return self._unique_world_npc_event[eventId]
end

function UniqueWorldConfig:getFightEventCfg(eventId)
	return self._unique_world_fight_event[eventId]
end

function UniqueWorldConfig:getLevelPlanId(activityId)
	local cfg = self._unique_world_activity[activityId]

	return cfg and cfg.levelPlanId
end

function UniqueWorldConfig:getMasterCfg(creepMasterId)
	return self._unique_world_creeps_master[creepMasterId]
end

function UniqueWorldConfig:getCreepsCfg(creepMasterId)
	return self._unique_world_creeps[creepMasterId]
end

function UniqueWorldConfig:getMapId(activityId, gameId, level)
	local levelPlanCfg = self:getLevelPlanCfgsById(activityId, gameId, level)

	if levelPlanCfg then
		return levelPlanCfg.mapId
	end

	return 1
end

UniqueWorldConfig.instance = UniqueWorldConfig.New()

return UniqueWorldConfig
