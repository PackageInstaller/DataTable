-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/CynthiaConfig.lua

module("logic.extensions.timelimitedchallenge.config.CynthiaConfig", package.seeall)

local CynthiaConfig = class("CynthiaConfig", BaseConfig)

function CynthiaConfig:getNames()
	return {
		"cynthia_challenge_common",
		"cynthia_challenge_monster",
		"cynthia_challenge_creeps",
		"cynthia_challenge_buff_define"
	}
end

function CynthiaConfig:handleConfig(name, content)
	if name == "cynthia_challenge_common" then
		self._commonCfg = content
	elseif name == "cynthia_challenge_monster" then
		self._stageCfg = content
	elseif name == "cynthia_challenge_creeps" then
		self._creepsCfg = content
	elseif name == "cynthia_challenge_buff_define" then
		self._buffsCfg = content
	end
end

function CynthiaConfig:getActCfg(challengeId)
	return self._commonCfg[challengeId]
end

function CynthiaConfig:getCommonValue(challengeId, key)
	return (self._commonCfg[challengeId] or nil) and (self._commonCfg[challengeId][key] or "")
end

function CynthiaConfig:getTierCfgs(challengeId)
	return self._stageCfg[challengeId]
end

function CynthiaConfig:getStagesCfgs(challengeId, tierId)
	return self._stageCfg[challengeId] and self._stageCfg[challengeId][tierId]
end

function CynthiaConfig:getStagesCfg(challengeId, tierId, stageId)
	return self._stageCfg[challengeId] and self._stageCfg[challengeId][tierId] and self._stageCfg[challengeId][tierId][stageId]
end

function CynthiaConfig:getCreepsCfg(creepsMasterId)
	if self._creepsCfg[creepsMasterId] then
		return self._creepsCfg[creepsMasterId]
	end
end

function CynthiaConfig:getBuffCfgs(challengeId)
	return self._buffsCfg[challengeId] or {}
end

function CynthiaConfig:getBuffCfg(challengeId, lv)
	return (self._buffsCfg[challengeId] or nil) and (self._buffsCfg[challengeId][lv] or {})
end

CynthiaConfig.instance = CynthiaConfig.New()

return CynthiaConfig
