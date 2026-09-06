-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/config/KingNuoyaChallengeConfig.lua

module("logic.extensions.kingnuoya.config.KingNuoyaChallengeConfig", package.seeall)

local KingNuoyaChallengeConfig = class("KingNuoyaChallengeConfig", BaseConfig)

function KingNuoyaChallengeConfig:onInit()
	KingNuoyaChallengeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function KingNuoyaChallengeConfig:getNames()
	return {
		"king_nuo_ya_activity",
		"king_nuo_ya_step",
		"king_nuo_ya_stage",
		"king_nuo_ya_buff",
		"king_nuo_ya_team",
		"king_nuo_ya_creeps"
	}
end

function KingNuoyaChallengeConfig:handleConfig(name, content)
	if name == "king_nuo_ya_activity" then
		self._king_nuo_ya_activity = content
	elseif name == "king_nuo_ya_step" then
		self._king_nuo_ya_step = content
	elseif name == "king_nuo_ya_stage" then
		self._king_nuo_ya_stage = content
	elseif name == "king_nuo_ya_buff" then
		self._king_nuo_ya_buff = content
	elseif name == "king_nuo_ya_team" then
		self._king_nuo_ya_team = content
	elseif name == "king_nuo_ya_creeps" then
		self._king_nuo_ya_creeps = content
	end
end

function KingNuoyaChallengeConfig:getActivityCfgById(id)
	return self._king_nuo_ya_activity[id]
end

function KingNuoyaChallengeConfig:getStepCfgById(activityId, type, stepId)
	if self._king_nuo_ya_step[activityId] and self._king_nuo_ya_step[activityId][type] then
		return self._king_nuo_ya_step[activityId][type][stepId]
	end

	return {}
end

function KingNuoyaChallengeConfig:getStageCfgById(activityId, stageId)
	if self._king_nuo_ya_stage[activityId] then
		return self._king_nuo_ya_stage[activityId][stageId]
	end

	return {}
end

function KingNuoyaChallengeConfig:getBuffCfgById(activityId, buffId)
	if self._king_nuo_ya_buff[activityId] then
		return self._king_nuo_ya_buff[activityId][buffId]
	end

	return {}
end

function KingNuoyaChallengeConfig:getTeamCfgById(id)
	return self._king_nuo_ya_team[id]
end

function KingNuoyaChallengeConfig:getCreepCfgById(id)
	return self._king_nuo_ya_creeps[id]
end

KingNuoyaChallengeConfig.instance = KingNuoyaChallengeConfig.New()

return KingNuoyaChallengeConfig
