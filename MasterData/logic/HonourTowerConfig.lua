-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/config/HonourTowerConfig.lua

module("logic.extensions.honourtower.config.HonourTowerConfig", package.seeall)

local HonourTowerConfig = class("HonourTowerConfig", BaseConfig)

function HonourTowerConfig:onInit()
	HonourTowerConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function HonourTowerConfig:getNames()
	return {
		"honor_tower_period",
		"honor_tower_challenge",
		"honor_tower_stage",
		"honor_tower_team",
		"honor_tower_creeps",
		"honor_tower_rank_prize",
		"honor_tower_clearance_buff"
	}
end

function HonourTowerConfig:handleConfig(name, content)
	if name == "honor_tower_period" then
		self._honor_tower_period = content
	elseif name == "honor_tower_challenge" then
		self._honor_tower_challenge = content
	elseif name == "honor_tower_stage" then
		self._honor_tower_stage = content
	elseif name == "honor_tower_team" then
		self._honor_tower_team = content
	elseif name == "honor_tower_creeps" then
		self._honor_tower_creeps = content
	elseif name == "honor_tower_rank_prize" then
		self._honor_tower_rank_prize = content
	elseif name == "honor_tower_clearance_buff" then
		self._honor_tower_clearance_buff = content
	end
end

function HonourTowerConfig:getPeriodCfg()
	return self._honor_tower_period
end

function HonourTowerConfig:getPeriodCfgById(periodId)
	return self._honor_tower_period[periodId]
end

function HonourTowerConfig:getChallengeCfgs(periodId)
	local cfgs = {}

	for i, v in ipairs(self._honor_tower_challenge) do
		if periodId == v.periodId then
			table.insert(cfgs, v)
		end
	end

	return cfgs
end

function HonourTowerConfig:getChallengeCfg(challengeId)
	return self._honor_tower_challenge[challengeId]
end

function HonourTowerConfig:getRegressChallengeIds(periodId)
	local ids = {}

	for i, v in ipairs(self._honor_tower_challenge) do
		if periodId > v.periodId and not v.isForever then
			table.insert(ids, v.challengeId)
		end
	end

	return ids
end

function HonourTowerConfig:getRankRewardCfg(challengeId, rank)
	for k, v in pairs(self._honor_tower_rank_prize.dataList) do
		if v.challengeId == challengeId and rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v.prize
		end
	end

	return ""
end

function HonourTowerConfig:getStageCfgs(challengeId)
	return self._honor_tower_stage[challengeId]
end

function HonourTowerConfig:getStageCfg(challengeId, stageId)
	return self._honor_tower_stage[challengeId][stageId]
end

function HonourTowerConfig:getStageName(challengeId, stageId)
	local cfg = self._honor_tower_stage[challengeId][stageId]
	local teamCfg = self:getTeamCfg(cfg.creepsMasterId)

	return teamCfg.name
end

function HonourTowerConfig:getTeamCfg(creepsMasterId)
	return self._honor_tower_team[creepsMasterId]
end

function HonourTowerConfig:getStageCfgLenghByChallengeId(challengeId)
	return #self._honor_tower_stage[challengeId]
end

function HonourTowerConfig:getCreepsCfgs(creepsMasterId)
	return self._honor_tower_creeps[creepsMasterId]
end

function HonourTowerConfig:getBuffCfgById(buffPlanId)
	return self._honor_tower_clearance_buff[buffPlanId]
end

function HonourTowerConfig:getRecallChallengeNum(periodId)
	return self._honor_tower_period[periodId].recallChallengeNum
end

HonourTowerConfig.instance = HonourTowerConfig.New()

return HonourTowerConfig
