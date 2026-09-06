-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/LounaConfig.lua

module("logic.extensions.timelimitedchallenge.config.LounaConfig", package.seeall)

local LounaConfig = class("LounaConfig", BaseConfig)

function LounaConfig:onInit()
	LounaConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function LounaConfig:getNames()
	return {
		"louna_challenge",
		"louna_challenge_tier",
		"louna_challenge_master",
		"louna_challenge_creeps",
		"louna_challenge_rule",
		"louna_challenge_prize"
	}
end

function LounaConfig:handleConfig(name, content)
	if name == "louna_challenge" then
		self.louna_challengeCfg = content
	elseif name == "louna_challenge_tier" then
		self.louna_challenge_tierCfg = content
	elseif name == "louna_challenge_master" then
		self.louna_challenge_masterCfg = content
	elseif name == "louna_challenge_creeps" then
		self.louna_challenge_creepsCfg = content
	elseif name == "louna_challenge_rule" then
		self.louna_challenge_ruleCfg = content
	elseif name == "louna_challenge_prize" then
		self.louna_challenge_prizeCfg = content
	end
end

function LounaConfig:getChallengeCfgById(id)
	return self.louna_challengeCfg[id]
end

function LounaConfig:getTierCfgById(planId, tier)
	if self.louna_challenge_tierCfg[planId] then
		return self.louna_challenge_tierCfg[planId][tier]
	end
end

function LounaConfig:getProgressPrizeCfg(planId)
	return self.louna_challenge_prizeCfg[planId]
end

function LounaConfig:getTierCfg(planId)
	return self.louna_challenge_tierCfg[planId]
end

function LounaConfig:getMasterCfg(planId)
	return self.louna_challenge_masterCfg[planId]
end

function LounaConfig:getRuleCfg(planId)
	return self.louna_challenge_ruleCfg[planId]
end

function LounaConfig:getMasterCfgById(planId, id)
	if self.louna_challenge_masterCfg[planId] then
		return self.louna_challenge_masterCfg[planId][id]
	end
end

function LounaConfig:getCreepsCfg(masterId)
	return self.louna_challenge_creepsCfg[masterId]
end

LounaConfig.instance = LounaConfig.New()

return LounaConfig
