-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/config/FemalePsychicChallengeConfig.lua

module("logic.extensions.femalepsychic.config.FemalePsychicChallengeConfig", package.seeall)

local FemalePsychicChallengeConfig = class("FemalePsychicChallengeConfig", BaseConfig)

function FemalePsychicChallengeConfig:onInit()
	FemalePsychicChallengeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function FemalePsychicChallengeConfig:getNames()
	return {
		"female_psychic_activity",
		"female_psychic_challenge",
		"female_psychic_stage",
		"female_psychic_challenge_master",
		"female_psychic_challenge_creeps",
		"female_psychic_challenge_support",
		"female_psychic_challenge_upgrade_buff"
	}
end

function FemalePsychicChallengeConfig:handleConfig(name, content)
	if name == "female_psychic_activity" then
		self._fb_activityCfg = content
	elseif name == "female_psychic_challenge" then
		self._fp_challengeCfg = content
	elseif name == "female_psychic_stage" then
		self._fp_stageCfg = content
	elseif name == "female_psychic_challenge_master" then
		self._fp_challenge_masterCfg = content
	elseif name == "female_psychic_challenge_creeps" then
		self._fp_challenge_creepsCfg = content
	elseif name == "female_psychic_challenge_support" then
		self._fp_challenge_supportCfg = content
	elseif name == "female_psychic_challenge_upgrade_buff" then
		self._female_psychic_challenge_upgrade_buff = content
	end
end

function FemalePsychicChallengeConfig:getActivityCfgById(activityId)
	return self._fb_activityCfg[activityId]
end

function FemalePsychicChallengeConfig:getChallengeCfgById(activityId)
	return self._fp_challengeCfg[activityId]
end

function FemalePsychicChallengeConfig:getStageChallengeCfg(activityId, challengeId)
	return self._fp_stageCfg[activityId][challengeId]
end

function FemalePsychicChallengeConfig:getStageChallengeDetailCfg(activityId, challengeId, stageId)
	return self._fp_stageCfg[activityId][challengeId][stageId]
end

function FemalePsychicChallengeConfig:getChallengeMasterCfg(creepsMasterId)
	return self._fp_challenge_masterCfg[creepsMasterId]
end

function FemalePsychicChallengeConfig:getStageCreepsCfg(creepsMasterId)
	return self._fp_challenge_creepsCfg[creepsMasterId]
end

function FemalePsychicChallengeConfig:getSupportCfg(creepsId)
	return self._fp_challenge_supportCfg[creepsId]
end

function FemalePsychicChallengeConfig:getSupportPetId(creepsId)
	return self._fp_challenge_supportCfg[cfg.supportPetId]
end

function FemalePsychicChallengeConfig:getBuffCfgs(activityId)
	local cfg = self:getActivityCfgById(activityId)

	return self._female_psychic_challenge_upgrade_buff[cfg.upgradeBuffPlanId]
end

FemalePsychicChallengeConfig.instance = FemalePsychicChallengeConfig.New()

return FemalePsychicChallengeConfig
