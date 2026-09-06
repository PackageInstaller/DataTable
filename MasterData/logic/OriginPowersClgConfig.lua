-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/config/OriginPowersClgConfig.lua

module("logic.extensions.originpowersclg.config.OriginPowersClgConfig", package.seeall)

local OriginPowersClgConfig = class("OriginPowersClgConfig", BaseConfig)

function OriginPowersClgConfig:onInit()
	OriginPowersClgConfig.super.onInit(self)
end

function OriginPowersClgConfig:getNames()
	return {
		"origin_powers_clg_activity",
		"origin_powers_clg_extreme_buff",
		"origin_powers_clg_extreme_stage",
		"origin_powers_clg_team",
		"origin_powers_clg_common_stage",
		"origin_powers_clg_creeps",
		"origin_powers_clg_common_prize"
	}
end

function OriginPowersClgConfig:handleConfig(name, content)
	if name == "origin_powers_clg_activity" then
		self._origin_powers_clg_activity = content
	elseif name == "origin_powers_clg_extreme_buff" then
		self._origin_powers_clg_extreme_buff = content
	elseif name == "origin_powers_clg_extreme_stage" then
		self._origin_powers_clg_extreme_stage = content
	elseif name == "origin_powers_clg_team" then
		self._origin_powers_clg_team = content
	elseif name == "origin_powers_clg_common_stage" then
		self._origin_powers_clg_common_stage = content
	elseif name == "origin_powers_clg_creeps" then
		self._origin_powers_clg_creeps = content
	elseif name == "origin_powers_clg_common_prize" then
		self._origin_powers_clg_common_prize = content
	end
end

function OriginPowersClgConfig:getActivityCfg(activityId)
	return self._origin_powers_clg_activity[activityId]
end

function OriginPowersClgConfig:getExtremeStageCfgs(activityId)
	return self._origin_powers_clg_extreme_stage[activityId]
end

function OriginPowersClgConfig:getExtremeStageCfg(activityId, stageId)
	if self._origin_powers_clg_extreme_stage[activityId] then
		return self._origin_powers_clg_extreme_stage[activityId][stageId]
	end
end

function OriginPowersClgConfig:getExtremeBuffCfgs(activityId)
	return self._origin_powers_clg_extreme_buff[activityId]
end

function OriginPowersClgConfig:getNormalStageCfgs(activityId, day)
	if self._origin_powers_clg_common_stage[activityId] then
		return self._origin_powers_clg_common_stage[activityId][day]
	end
end

function OriginPowersClgConfig:getNormalPrizeCfgs(activityId)
	return self._origin_powers_clg_common_prize[activityId]
end

function OriginPowersClgConfig:getTeamCfg(creepsMasterId)
	return self._origin_powers_clg_team[creepsMasterId]
end

function OriginPowersClgConfig:getCreepsCfg(creepsMasterId)
	return self._origin_powers_clg_creeps[creepsMasterId]
end

function OriginPowersClgConfig:getNormalPrizeCfgs(activityId)
	return self._origin_powers_clg_common_prize[activityId]
end

OriginPowersClgConfig.instance = OriginPowersClgConfig.New()

return OriginPowersClgConfig
