-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/config/QiChallengeConfig.lua

module("logic.extensions.qichallenge.config.QiChallengeConfig", package.seeall)

local QiChallengeConfig = class("QiChallengeConfig", BaseConfig)

function QiChallengeConfig:onInit()
	QiChallengeConfig.super.onInit(self)
end

function QiChallengeConfig:getNames()
	return {
		"qi_challenge",
		"qi_challenge_all",
		"qi_challenge_extreme",
		"qi_challenge_extreme_debuff",
		"qi_challenge_buff",
		"qi_challenge_master",
		"qi_challenge_creeps"
	}
end

function QiChallengeConfig:handleConfig(name, content)
	if name == "qi_challenge" then
		self._qi_challenge = content
	elseif name == "qi_challenge_all" then
		self._qi_challenge_all = content
	elseif name == "qi_challenge_extreme" then
		self._qi_challenge_extreme = content
	elseif name == "qi_challenge_extreme_debuff" then
		self._qi_challenge_extreme_debuff = content
	elseif name == "qi_challenge_buff" then
		self._qi_challenge_buff = content
	elseif name == "qi_challenge_master" then
		self._qi_challenge_master = content
	elseif name == "qi_challenge_creeps" then
		self._qi_challenge_creeps = content
	end
end

function QiChallengeConfig:getFirstActicityId()
	return self._qi_challenge.dataList[1].activityId
end

function QiChallengeConfig:getActivityCfg(activityId)
	return self._qi_challenge[activityId]
end

function QiChallengeConfig:getAllChallengeCfg(allPlanId, challengeId)
	if self._qi_challenge_all[allPlanId] then
		return self._qi_challenge_all[allPlanId][challengeId]
	end

	return nil
end

function QiChallengeConfig:getCreepTeamCfg(creepsMasterId)
	return self._qi_challenge_master[creepsMasterId]
end

function QiChallengeConfig:getCreepsCfg(creepsMasterId)
	return self._qi_challenge_creeps[creepsMasterId]
end

function QiChallengeConfig:getBuff(buffId)
	return self._qi_challenge_buff[buffId]
end

function QiChallengeConfig:getHardChallengeCfgs(hardPlanId)
	return self._qi_challenge_extreme[hardPlanId]
end

function QiChallengeConfig:getHardChallengeCfg(hardPlanId, challengeId)
	if self._qi_challenge_extreme[hardPlanId] then
		return self._qi_challenge_extreme[hardPlanId][challengeId]
	end

	return nil
end

function QiChallengeConfig:getDebuffCfgs(deBuffPlanId)
	return self._qi_challenge_extreme_debuff[deBuffPlanId]
end

QiChallengeConfig.instance = QiChallengeConfig.New()

return QiChallengeConfig
