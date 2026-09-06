-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/config/OriginChenClgConfig.lua

module("logic.extensions.originchenclg.config.OriginChenClgConfig", package.seeall)

local OriginChenClgConfig = class("OriginChenClgConfig", BaseConfig)

function OriginChenClgConfig:getNames()
	return {
		"origin_chen_clg_extreme_stage",
		"origin_chen_clg_creeps_master",
		"origin_chen_clg_creeps",
		"origin_chen_clg_activity",
		"origin_chen_clg_suit_plan",
		"origin_chen_clg_normal_stage"
	}
end

function OriginChenClgConfig:handleConfig(name, content)
	if name == "origin_chen_clg_extreme_stage" then
		self._origin_chen_clg_extreme_stage = content
	elseif name == "origin_chen_clg_creeps_master" then
		self._origin_chen_clg_creeps_master = content
	elseif name == "origin_chen_clg_creeps" then
		self._origin_chen_clg_creeps = content
	elseif name == "origin_chen_clg_activity" then
		self._origin_chen_clg_activity = content
	elseif name == "origin_chen_clg_suit_plan" then
		self._origin_chen_clg_suit_plan = content
	elseif name == "origin_chen_clg_normal_stage" then
		self._origin_chen_clg_normal_stage = content
	end
end

function OriginChenClgConfig:getActivityCfg(activityId)
	return self._origin_chen_clg_activity[activityId]
end

function OriginChenClgConfig:getNorStageCfgs(activityId)
	return self._origin_chen_clg_normal_stage[activityId]
end

function OriginChenClgConfig:getNorStageCfg(activityId, stageId)
	return self._origin_chen_clg_normal_stage[activityId][stageId]
end

function OriginChenClgConfig:getCreepsCfg(creepsMasterId)
	return self._origin_chen_clg_creeps[creepsMasterId]
end

function OriginChenClgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_chen_clg_creeps_master[creepsMasterId]
end

function OriginChenClgConfig:getExtremeStageCfgs(activityId)
	return self._origin_chen_clg_extreme_stage[activityId]
end

function OriginChenClgConfig:getExtremeStageCfg(activityId, stageId)
	return self._origin_chen_clg_extreme_stage[activityId][stageId]
end

function OriginChenClgConfig:getSuitPlanCfg(suitPlanId)
	return self._origin_chen_clg_suit_plan[suitPlanId]
end

OriginChenClgConfig.instance = OriginChenClgConfig.New()

return OriginChenClgConfig
