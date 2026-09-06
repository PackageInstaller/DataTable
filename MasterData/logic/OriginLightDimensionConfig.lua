-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/config/OriginLightDimensionConfig.lua

module("logic.extensions.originlightdimension.config.OriginLightDimensionConfig", package.seeall)

local OriginLightDimensionConfig = class("OriginLightDimensionConfig", BaseConfig)

function OriginLightDimensionConfig:onInit()
	OriginLightDimensionConfig.super.onInit(self)
end

function OriginLightDimensionConfig:getNames()
	return {
		"origin_light_dimension_creeps",
		"origin_light_dimension_extreme_stage",
		"origin_light_dimension_activity",
		"origin_light_dimension_extreme_buff",
		"origin_light_dimension_master",
		"origin_light_dimension_normal_stage"
	}
end

function OriginLightDimensionConfig:handleConfig(name, content)
	if name == "origin_light_dimension_creeps" then
		self._origin_light_dimension_creeps = content
	elseif name == "origin_light_dimension_extreme_stage" then
		self._origin_light_dimension_extreme_stage = content
	elseif name == "origin_light_dimension_activity" then
		self._origin_light_dimension_activity = content
	elseif name == "origin_light_dimension_extreme_buff" then
		self._origin_light_dimension_extreme_buff = content
	elseif name == "origin_light_dimension_master" then
		self._origin_light_dimension_master = content
	elseif name == "origin_light_dimension_normal_stage" then
		self._origin_light_dimension_normal_stage = content
	end
end

function OriginLightDimensionConfig:getActivityCfg(activityId)
	return self._origin_light_dimension_activity[activityId]
end

function OriginLightDimensionConfig:getNormalStageCfgs(activityId)
	return self._origin_light_dimension_normal_stage[activityId]
end

function OriginLightDimensionConfig:getNormalStageCfg(activityId, stageId)
	if self._origin_light_dimension_normal_stage[activityId] then
		return self._origin_light_dimension_normal_stage[activityId][stageId]
	end
end

function OriginLightDimensionConfig:getExtremeStageCfgs(activityId)
	return self._origin_light_dimension_extreme_stage[activityId]
end

function OriginLightDimensionConfig:getExtremeStageCfg(activityId, stageId)
	if self._origin_light_dimension_extreme_stage[activityId] then
		return self._origin_light_dimension_extreme_stage[activityId][stageId]
	end
end

function OriginLightDimensionConfig:getTeamCfg(creepsMasterId)
	return self._origin_light_dimension_master[creepsMasterId]
end

function OriginLightDimensionConfig:getCreepsCfg(creepsMasterId)
	return self._origin_light_dimension_creeps[creepsMasterId]
end

function OriginLightDimensionConfig:getExtremeBuffCfgs(activityId)
	return self._origin_light_dimension_extreme_buff[activityId]
end

function OriginLightDimensionConfig:getExtremeBuffCfg(activityId, buffId)
	if self._origin_light_dimension_extreme_buff[activityId] then
		return self._origin_light_dimension_extreme_buff[activityId][buffId]
	end
end

OriginLightDimensionConfig.instance = OriginLightDimensionConfig.New()

return OriginLightDimensionConfig
