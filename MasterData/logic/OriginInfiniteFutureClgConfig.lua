-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/config/OriginInfiniteFutureClgConfig.lua

module("logic.extensions.origininfinitefutureclg.config.OriginInfiniteFutureClgConfig", package.seeall)

local OriginInfiniteFutureClgConfig = class("OriginInfiniteFutureClgConfig", BaseConfig)

function OriginInfiniteFutureClgConfig:getNames()
	return {
		"origin_infinite_future_clg_activity",
		"origin_infinite_future_clg_stage",
		"origin_infinite_future_clg_value",
		"origin_infinite_future_clg_creeps_master",
		"origin_infinite_future_clg_creeps"
	}
end

function OriginInfiniteFutureClgConfig:handleConfig(name, content)
	if name == "origin_infinite_future_clg_activity" then
		self._origin_infinite_future_clg_activity = content
	elseif name == "origin_infinite_future_clg_stage" then
		self._origin_infinite_future_clg_stage = content
	elseif name == "origin_infinite_future_clg_value" then
		self._origin_infinite_future_clg_value = content
	elseif name == "origin_infinite_future_clg_creeps_master" then
		self._origin_infinite_future_clg_creeps_master = content
	elseif name == "origin_infinite_future_clg_creeps" then
		self._origin_infinite_future_clg_creeps = content
	end
end

function OriginInfiniteFutureClgConfig:getActivityCfg(activityId)
	return self._origin_infinite_future_clg_activity[activityId]
end

function OriginInfiniteFutureClgConfig:getStageCfgs(activityId)
	return self._origin_infinite_future_clg_stage[activityId]
end

function OriginInfiniteFutureClgConfig:getStageCfgById(activityId, stageId)
	return self._origin_infinite_future_clg_stage[activityId] and self._origin_infinite_future_clg_stage[activityId][stageId]
end

function OriginInfiniteFutureClgConfig:getValueCfgs(activityId)
	return self._origin_infinite_future_clg_value[activityId]
end

function OriginInfiniteFutureClgConfig:getValueCfgByType(activityId, valueType)
	return self._origin_infinite_future_clg_value[activityId] and self._origin_infinite_future_clg_value[activityId][valueType]
end

function OriginInfiniteFutureClgConfig:getCreepMasterCfg(creepsMasterId)
	return self._origin_infinite_future_clg_creeps_master[creepsMasterId]
end

function OriginInfiniteFutureClgConfig:getCreepsCfg(creepsMasterId)
	return self._origin_infinite_future_clg_creeps[creepsMasterId]
end

function OriginInfiniteFutureClgConfig:getCreepMasterId(activityId, stageId)
	local stageCfg = self:getStageCfgById(activityId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

OriginInfiniteFutureClgConfig.instance = OriginInfiniteFutureClgConfig.New()

return OriginInfiniteFutureClgConfig
