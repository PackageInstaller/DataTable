-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/MississiConfig.lua

module("logic.extensions.timelimitedchallenge.config.MississiConfig", package.seeall)

local MississiConfig = class("MississiConfig", BaseConfig)

function MississiConfig:onInit()
	MississiConfig.super.onInit(self)
end

function MississiConfig:getNames()
	return {
		"mixixi_challenge_common",
		"mixixi_challenge_activity",
		"mixixi_challenge_buff",
		"mixixi_challenge_creeps",
		"mixixi_challenge_monster",
		"mixixi_challenge_stage",
		"mixixi_challenge_team"
	}
end

function MississiConfig:handleConfig(name, content)
	if name == "mixixi_challenge_common" then
		self._commonCfgs = content
	elseif name == "mixixi_challenge_activity" then
		self._actCfgs = content
	elseif name == "mixixi_challenge_buff" then
		self._buffCfgs = content
	elseif name == "mixixi_challenge_creeps" then
		self._creepsCfgs = content
	elseif name == "mixixi_challenge_monster" then
		self._creepsMasterCfgs = content
	elseif name == "mixixi_challenge_stage" then
		self._stageCfgs = content
	elseif name == "mixixi_challenge_team" then
		self._teamCfgs = content
	end
end

function MississiConfig:getCommonValue(key)
	if self._commonCfgs[key] then
		return self._commonCfgs[key].value
	end
end

function MississiConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function MississiConfig:getBuffCfgs(actId)
	local actCfg = self._actCfgs[actId]

	if actCfg then
		return self._buffCfgs[actCfg.buffPlanId]
	end
end

function MississiConfig:getBuffCfgByLevel(actId, lv)
	local actCfg = self._actCfgs[actId]

	if actCfg then
		return self._buffCfgs[actCfg.buffPlanId][lv]
	end
end

function MississiConfig:getCreepsCfg(creepId)
	return self._creepsCfgs[creepId]
end

function MississiConfig:getCreepsMasterCfg(creepId)
	return self._creepsMasterCfgs[creepId]
end

function MississiConfig:getStageCfgs(actId)
	local actCfg = self._actCfgs[actId]

	if actCfg then
		return self._stageCfgs[actCfg.challengePlanId]
	end
end

function MississiConfig:getTeamCfg(actId, stateId, teamId)
	local actCfg = self._actCfgs[actId]

	if actCfg then
		return self._teamCfgs[actCfg.challengePlanId][stateId][teamId]
	end
end

MississiConfig.instance = MississiConfig.New()

return MississiConfig
