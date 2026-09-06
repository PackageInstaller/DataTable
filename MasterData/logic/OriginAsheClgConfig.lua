-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/config/OriginAsheClgConfig.lua

module("logic.extensions.originasheclg.config.OriginAsheClgConfig", package.seeall)

local OriginAsheClgConfig = class("OriginAsheClgConfig", BaseConfig)

function OriginAsheClgConfig:onInit()
	OriginAsheClgConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function OriginAsheClgConfig:getNames()
	return {
		"origin_ashe_clg_stage",
		"origin_ashe_clg_monster",
		"origin_ashe_clg_creeps",
		"origin_ashe_clg_buff",
		"origin_ashe_clg_activity"
	}
end

function OriginAsheClgConfig:handleConfig(name, content)
	if name == "origin_ashe_clg_stage" then
		self._origin_ashe_clg_stage = content
	elseif name == "origin_ashe_clg_monster" then
		self._origin_ashe_clg_monster = content
	elseif name == "origin_ashe_clg_creeps" then
		self._origin_ashe_clg_creeps = content
	elseif name == "origin_ashe_clg_buff" then
		self._origin_ashe_clg_buff = content
	elseif name == "origin_ashe_clg_activity" then
		self._origin_ashe_clg_activity = content
	end
end

function OriginAsheClgConfig:getActivityCfg(activityId)
	return self._origin_ashe_clg_activity[activityId]
end

function OriginAsheClgConfig:getStageCfgs(activityId)
	return self._origin_ashe_clg_stage[activityId]
end

function OriginAsheClgConfig:getStageCfg(activityId, stageId)
	if self._origin_ashe_clg_stage[activityId] then
		return self._origin_ashe_clg_stage[activityId][stageId]
	end
end

function OriginAsheClgConfig:getTeamCfg(creepsMasterId)
	return self._origin_ashe_clg_monster[creepsMasterId]
end

function OriginAsheClgConfig:getCreepsCfg(creepsMasterId)
	return self._origin_ashe_clg_creeps[creepsMasterId]
end

function OriginAsheClgConfig:getBuffCfg(buffId)
	return self._origin_ashe_clg_buff[buffId]
end

OriginAsheClgConfig.instance = OriginAsheClgConfig.New()

return OriginAsheClgConfig
