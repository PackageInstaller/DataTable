-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/config/DivineKingShiKongLongZunConfig.lua

module("logic.extensions.divinekingshikongllongzun.config.DivineKingShiKongLongZunConfig", package.seeall)

local DivineKingShiKongLongZunConfig = class("DivineKingShiKongLongZunConfig", BaseConfig)

function DivineKingShiKongLongZunConfig:getNames()
	return {
		"divine_king_space_dragon_activity",
		"divine_king_space_dragon_floor",
		"divine_king_space_dragon_stage",
		"divine_king_space_dragon_master",
		"divine_king_space_dragon_creeps"
	}
end

function DivineKingShiKongLongZunConfig:handleConfig(name, content)
	if name == "divine_king_space_dragon_activity" then
		self._divine_king_space_dragon_activity = content
	elseif name == "divine_king_space_dragon_floor" then
		self._divine_king_space_dragon_floor = content
	elseif name == "divine_king_space_dragon_stage" then
		self._divine_king_space_dragon_stage = content
	elseif name == "divine_king_space_dragon_master" then
		self._divine_king_space_dragon_master = content
	elseif name == "divine_king_space_dragon_creeps" then
		self._divine_king_space_dragon_creeps = content
	end
end

function DivineKingShiKongLongZunConfig:getActCfg(activityId)
	return self._divine_king_space_dragon_activity[activityId]
end

function DivineKingShiKongLongZunConfig:getFloorCfgs(activityId)
	return self._divine_king_space_dragon_floor[activityId]
end

function DivineKingShiKongLongZunConfig:getFloorCfgByFloorId(activityId, floorId)
	return self._divine_king_space_dragon_floor[activityId] and self._divine_king_space_dragon_floor[activityId][floorId]
end

function DivineKingShiKongLongZunConfig:getStageCfgs(stagePlanId)
	return self._divine_king_space_dragon_stage[stagePlanId]
end

function DivineKingShiKongLongZunConfig:getStageCfgByStageId(stagePlanId, stageId)
	return self._divine_king_space_dragon_stage[stagePlanId] and self._divine_king_space_dragon_stage[stagePlanId][stageId]
end

function DivineKingShiKongLongZunConfig:getMasterCfg(creepMasterId)
	return self._divine_king_space_dragon_master[creepMasterId]
end

function DivineKingShiKongLongZunConfig:getCreepCfg(creepMasterId)
	return self._divine_king_space_dragon_creeps[creepMasterId]
end

function DivineKingShiKongLongZunConfig:getStagePlanId(activityId, floorId)
	local floorCfg = self:getFloorCfgByFloorId(activityId, floorId)

	return floorCfg and floorCfg.stagePlanId
end

function DivineKingShiKongLongZunConfig:getCreepMasterId(stagePlanId, stageId)
	local stageCfg = self:getStageCfgByStageId(stagePlanId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

DivineKingShiKongLongZunConfig.instance = DivineKingShiKongLongZunConfig.New()

return DivineKingShiKongLongZunConfig
