-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/config/OriginLongYanClgConfig.lua

module("logic.extensions.originlongyanclg.config.OriginLongYanClgConfig", package.seeall)

local OriginLongYanClgConfig = class("OriginLongYanClgConfig", BaseConfig)

OriginLongYanClgConfig.instance = OriginLongYanClgConfig.New()

function OriginLongYanClgConfig:getNames()
	return {
		"origin_longyan_clg_stage",
		"origin_longyan_clg_activity",
		"origin_longyan_clg_monster",
		"origin_longyan_clg_sign",
		"origin_longyan_clg_creeps"
	}
end

function OriginLongYanClgConfig:handleConfig(name, content)
	if name == "origin_longyan_clg_stage" then
		self._origin_longyan_clg_stage = content
	elseif name == "origin_longyan_clg_activity" then
		self._origin_longyan_clg_activity = content
	elseif name == "origin_longyan_clg_monster" then
		self._origin_longyan_clg_monster = content
	elseif name == "origin_longyan_clg_sign" then
		self._origin_longyan_clg_sign = content
	elseif name == "origin_longyan_clg_creeps" then
		self._origin_longyan_clg_creeps = content
	end
end

function OriginLongYanClgConfig:getSignCfgs(activityId)
	return self._origin_longyan_clg_sign[activityId]
end

function OriginLongYanClgConfig:getSignCfgById(activityId, signId)
	if self._origin_longyan_clg_sign[activityId] then
		return self._origin_longyan_clg_sign[activityId][signId]
	end
end

function OriginLongYanClgConfig:getCreepCfgs(creepsMasterId)
	return self._origin_longyan_clg_creeps[creepsMasterId]
end

function OriginLongYanClgConfig:getTeamCfg(creepsMasterId)
	return self._origin_longyan_clg_monster[creepsMasterId]
end

function OriginLongYanClgConfig:getActivityCfg(activityId)
	return self._origin_longyan_clg_activity[activityId]
end

function OriginLongYanClgConfig:getStageCfgs(activityId)
	return self._origin_longyan_clg_stage[activityId]
end

function OriginLongYanClgConfig:getStageCfgById(activityId, stageId)
	if self._origin_longyan_clg_stage[activityId] then
		return self._origin_longyan_clg_stage[activityId][stageId]
	end
end

OriginLongYanClgConfig.instance = OriginLongYanClgConfig.New()

return OriginLongYanClgConfig
