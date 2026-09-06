-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/config/LingShenChallengeConfig.lua

module("logic.extensions.lingshenchallenge.config.LingShenChallengeConfig", package.seeall)

local LingShenChallengeConfig = class("LingShenChallengeConfig", BaseConfig)

function LingShenChallengeConfig:onInit()
	LingShenChallengeConfig.super.onInit(self)
end

function LingShenChallengeConfig:getNames()
	return {
		"ling_shen_challenge",
		"ling_shen_challenge_boss",
		"ling_shen_challenge_damage_prize",
		"ling_shen_challenge_creeps_master",
		"ling_shen_challenge_clg_creeps"
	}
end

function LingShenChallengeConfig:handleConfig(name, content)
	if name == "ling_shen_challenge" then
		self._linkage_skin_intro_tab = content
	elseif name == "ling_shen_challenge_boss" then
		self._ling_shen_challenge_boss = content
	elseif name == "ling_shen_challenge_damage_prize" then
		self._ling_shen_challenge_damage_prize = content
	elseif name == "ling_shen_challenge_creeps_master" then
		self._ling_shen_challenge_creeps_master = content
	elseif name == "ling_shen_challenge_clg_creeps" then
		self._ling_shen_challenge_clg_creeps = content
	end
end

function LingShenChallengeConfig:getActivityCfg(activityId)
	return self._linkage_skin_intro_tab[activityId]
end

function LingShenChallengeConfig:getBossCfgs(activityId)
	return self._ling_shen_challenge_boss[activityId]
end

function LingShenChallengeConfig:getBossCfg(activityId, bossId)
	return self._ling_shen_challenge_boss[activityId][bossId]
end

function LingShenChallengeConfig:getBossOpenTime(activityId, bossId)
	local startTime, endTime
	local bossCfg = self:getBossCfg(activityId, bossId)
	local nextBossCfg = self:getBossCfg(activityId, bossId + 1)
	local groupCfg = FormTeamConfig.instance:getTeamCfgByGroupId(bossCfg.groupId)
	local tabCfg = FormTeamConfig.instance:getTabCfgByTabId(groupCfg.typeId)

	startTime = bossCfg.startTime

	if nextBossCfg then
		endTime = nextBossCfg.startTime
	else
		local timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.LingShenChallenge, activityId)

		endTime = timeCfg.endTime
	end

	return startTime, endTime
end

function LingShenChallengeConfig:getPrizeCfgs(prizePlanId)
	return self._ling_shen_challenge_damage_prize[prizePlanId]
end

function LingShenChallengeConfig:getPrizeCfg(prizePlanId, prizeId)
	return self._ling_shen_challenge_damage_prize[prizePlanId][prizeId]
end

function LingShenChallengeConfig:getTeamCfg(creepsMasterId)
	return self._ling_shen_challenge_creeps_master[creepsMasterId]
end

function LingShenChallengeConfig:getCreepsCfg(creepsMasterId)
	return self._ling_shen_challenge_clg_creeps[creepsMasterId]
end

LingShenChallengeConfig.instance = LingShenChallengeConfig.New()

return LingShenChallengeConfig
