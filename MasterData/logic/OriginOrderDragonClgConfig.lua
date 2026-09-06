-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/config/OriginOrderDragonClgConfig.lua

module("logic.extensions.originorderdragonclg.config.OriginOrderDragonClgConfig", package.seeall)

local OriginOrderDragonClgConfig = class("OriginOrderDragonClgConfig", BaseConfig)

function OriginOrderDragonClgConfig:getNames()
	return {
		"origin_order_dragon_clg_stage",
		"origin_order_dragon_clg",
		"origin_order_dragon_clg_creeps",
		"origin_order_dragon_clg_creeps_master"
	}
end

function OriginOrderDragonClgConfig:handleConfig(name, content)
	if name == "origin_order_dragon_clg_stage" then
		self._origin_order_dragon_clg_stage = content
	elseif name == "origin_order_dragon_clg" then
		self._origin_order_dragon_clg = content
	elseif name == "origin_order_dragon_clg_creeps" then
		self._origin_order_dragon_clg_creeps = content
	elseif name == "origin_order_dragon_clg_creeps_master" then
		self._origin_order_dragon_clg_creeps_master = content
	end
end

function OriginOrderDragonClgConfig:getStageCfgs(activityId)
	return self._origin_order_dragon_clg_stage[activityId]
end

function OriginOrderDragonClgConfig:getStageCfgById(activityId, stageId)
	if self._origin_order_dragon_clg_stage[activityId] then
		return self._origin_order_dragon_clg_stage[activityId][stageId]
	end
end

function OriginOrderDragonClgConfig:getActivityCfg(activityId)
	return self._origin_order_dragon_clg[activityId]
end

function OriginOrderDragonClgConfig:getCreepCfgs(creepsMasterId)
	return self._origin_order_dragon_clg_creeps[creepsMasterId]
end

function OriginOrderDragonClgConfig:getTeamCfg(creepsMasterId)
	return self._origin_order_dragon_clg_creeps_master[creepsMasterId]
end

OriginOrderDragonClgConfig.instance = OriginOrderDragonClgConfig.New()

return OriginOrderDragonClgConfig
