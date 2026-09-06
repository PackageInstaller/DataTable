-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/config/CorPrChallengeConfig.lua

module("logic.extensions.corpr.config.CorPrChallengeConfig", package.seeall)

local CorPrChallengeConfig = class("CorPrChallengeConfig", BaseConfig)

function CorPrChallengeConfig:onInit()
	CorPrChallengeConfig.super.onInit(self)
end

function CorPrChallengeConfig:getNames()
	return {
		"correct_principle_challenge",
		"correct_principle_challenge_identity",
		"correct_principle_challenge_monster",
		"correct_principle_challenge_creeps",
		"correct_principle_challenge_common",
		"correct_principle_challenge_helper"
	}
end

function CorPrChallengeConfig:handleConfig(name, content)
	if name == "correct_principle_challenge" then
		self._cpChallengeCfg = content
	elseif name == "correct_principle_challenge_identity" then
		self._cpIdentityCfgs = content
	elseif name == "correct_principle_challenge_monster" then
		self._cpMonsterCfgs = content
	elseif name == "correct_principle_challenge_creeps" then
		self._cpCreepsCfgs = content
	elseif name == "correct_principle_challenge_common" then
		self._cpCommonCfg = content
	elseif name == "correct_principle_challenge_helper" then
		self._cpHelperCfgs = content
	end
end

function CorPrChallengeConfig:getCpChallengeCfg()
	return self._cpChallengeCfg
end

function CorPrChallengeConfig:getCpChallengeData(challengeId)
	return self._cpChallengeCfg[challengeId]
end

function CorPrChallengeConfig:getCpIdentityCfg(challengeId)
	local challengeData = self:getCpChallengeData(challengeId)

	return self._cpIdentityCfgs[challengeData.identityPlanId]
end

function CorPrChallengeConfig:getCpIdentityData(challengeId, identityId)
	return self:getCpIdentityCfg(challengeId)[identityId]
end

function CorPrChallengeConfig:getcpMonsterCfg(identityId)
	return self._cpMonsterCfgs[identityId]
end

function CorPrChallengeConfig:getcpMonsterData(identityId, stageId)
	return self._cpMonsterCfgs[identityId][stageId]
end

function CorPrChallengeConfig:getCpCreepsCfg(identityId, stageId)
	local monsterData = self:getcpMonsterData(identityId, stageId)

	return self._cpCreepsCfgs[monsterData.creepsMasterId]
end

function CorPrChallengeConfig:getCpCommonValue(key)
	return self._cpCommonCfg[key] and self._cpCommonCfg[key].value
end

function CorPrChallengeConfig:getCpCurChallengeId()
	return checknumber(self:getCpCommonValue("CUR_CHALLENGE_ID"))
end

function CorPrChallengeConfig:getCpHelperCfg(helpPetPlanId)
	return self._cpHelperCfgs[helpPetPlanId]
end

CorPrChallengeConfig.instance = CorPrChallengeConfig.New()

return CorPrChallengeConfig
