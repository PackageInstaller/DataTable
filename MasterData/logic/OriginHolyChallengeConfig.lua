-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/config/OriginHolyChallengeConfig.lua

module("logic.extensions.originholychallenge.config.OriginHolyChallengeConfig", package.seeall)

local OriginHolyChallengeConfig = class("OriginHolyChallengeConfig", BaseConfig)
local ACTIVITY_TABLE = "origin_holy_challenge_activity"
local STAGE_TABLE = "origin_holy_challenge_stage"
local MASTER_TABLE = "origin_holy_challenge_creeps_master"
local CREEPS_TABLE = "origin_holy_challenge_creeps"
local BUFF_TABLE = "origin_holy_challenge_buff"
local PET_TABLE = "origin_holy_challenge_support_pet"

function OriginHolyChallengeConfig:getNames()
	return {
		ACTIVITY_TABLE,
		STAGE_TABLE,
		MASTER_TABLE,
		CREEPS_TABLE,
		BUFF_TABLE,
		PET_TABLE
	}
end

function OriginHolyChallengeConfig:handleConfig(name, content)
	if name == ACTIVITY_TABLE then
		self._activityCfg = content
	elseif name == STAGE_TABLE then
		self._stageCfg = content
	elseif name == MASTER_TABLE then
		self._masterCfg = content
	elseif name == CREEPS_TABLE then
		self._creepCfg = content
	elseif name == BUFF_TABLE then
		self._buffCfg = content
	elseif name == PET_TABLE then
		self._petCfg = content
	end
end

function OriginHolyChallengeConfig:getActivity(activityId)
	return self._activityCfg[activityId]
end

function OriginHolyChallengeConfig:getStages(activityId)
	return self._stageCfg[activityId]
end

function OriginHolyChallengeConfig:getStage(activityId, stageId)
	if self._stageCfg[activityId] then
		return self._stageCfg[activityId][stageId]
	end
end

function OriginHolyChallengeConfig:getMaster(creepsMasterId)
	return self._masterCfg[creepsMasterId]
end

function OriginHolyChallengeConfig:getCreeps(creepsMasterId)
	return self._creepCfg[creepsMasterId]
end

function OriginHolyChallengeConfig:getBuff(planId)
	return self._buffCfg[planId]
end

function OriginHolyChallengeConfig:getPet(petId)
	return self._petCfg[petId]
end

OriginHolyChallengeConfig.instance = OriginHolyChallengeConfig.New()

return OriginHolyChallengeConfig
