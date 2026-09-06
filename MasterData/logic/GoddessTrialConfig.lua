-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/config/GoddessTrialConfig.lua

module("logic.extensions.goddesstrial.config.GoddessTrialConfig", package.seeall)

local GoddessTrialConfig = class("GoddessTrialConfig", BaseConfig)

function GoddessTrialConfig:onInit()
	GoddessTrialConfig.super.onInit(self)
end

function GoddessTrialConfig:getNames()
	return {
		"goddess_trial_activity",
		"goddess_trial_rank_prize",
		"goddess_trial_step",
		"goddess_trial_progress_prize",
		"goddess_trial_boss_score",
		"goddess_trial_boss",
		"goddess_trial_system_pet",
		"goddess_trial_normal_trial_stage",
		"goddess_trial_super_trial_score_plan",
		"goddess_trial_creeps_master",
		"goddess_trial_super_trial_stage",
		"goddess_trial_creeps"
	}
end

function GoddessTrialConfig:handleConfig(name, content)
	if name == "goddess_trial_activity" then
		self._goddess_trial_activity = content
	elseif name == "goddess_trial_rank_prize" then
		self._goddess_trial_rank_prize = content
	elseif name == "goddess_trial_step" then
		self._goddess_trial_step = content
	elseif name == "goddess_trial_progress_prize" then
		self._goddess_trial_progress_prize = content
	elseif name == "goddess_trial_boss_score" then
		self._goddess_trial_boss_score = content
	elseif name == "goddess_trial_boss" then
		self._goddess_trial_boss = content
	elseif name == "goddess_trial_system_pet" then
		self._goddess_trial_system_pet = content
	elseif name == "goddess_trial_normal_trial_stage" then
		self._goddess_trial_normal_trial_stage = content
	elseif name == "goddess_trial_super_trial_score_plan" then
		self._goddess_trial_super_trial_score_plan = content
	elseif name == "goddess_trial_creeps_master" then
		self._goddess_trial_creeps_master = content
	elseif name == "goddess_trial_super_trial_stage" then
		self._goddess_trial_super_trial_stage = content
	elseif name == "goddess_trial_creeps" then
		self._goddess_trial_creeps = content
	end
end

function GoddessTrialConfig:getActivityCfg(activityId)
	return self._goddess_trial_activity[activityId]
end

function GoddessTrialConfig:getStepCfgs(activityId)
	return self._goddess_trial_step[activityId]
end

function GoddessTrialConfig:getStepCfg(activityId, stepId)
	if self._goddess_trial_step[activityId] then
		return self._goddess_trial_step[activityId][stepId]
	end
end

function GoddessTrialConfig:getNormalStageCfgs(normalTrialPlanId)
	return self._goddess_trial_normal_trial_stage[normalTrialPlanId]
end

function GoddessTrialConfig:getNormalStageCfg(normalTrialPlanId, stageId)
	if self._goddess_trial_normal_trial_stage[normalTrialPlanId] then
		return self._goddess_trial_normal_trial_stage[normalTrialPlanId][stageId]
	end
end

function GoddessTrialConfig:getSuperStageCfgs(superTrialPlanId)
	return self._goddess_trial_super_trial_stage[superTrialPlanId]
end

function GoddessTrialConfig:getSuperStageCfg(superTrialPlanId, stageId)
	if self._goddess_trial_super_trial_stage[superTrialPlanId] then
		return self._goddess_trial_super_trial_stage[superTrialPlanId][stageId]
	end
end

function GoddessTrialConfig:getSuperScorePlanCfgs(superTrialScorePlanId)
	return self._goddess_trial_super_trial_score_plan[superTrialScorePlanId]
end

function GoddessTrialConfig:getBossCfg(bossId)
	return self._goddess_trial_boss[bossId]
end

function GoddessTrialConfig:getBossDamagePlanCfg(damageScorePlanId)
	return self._goddess_trial_boss_score[damageScorePlanId]
end

function GoddessTrialConfig:getTeamCfg(creepsMasterId)
	return self._goddess_trial_creeps_master[creepsMasterId]
end

function GoddessTrialConfig:getCreepsCfg(creepsMasterId)
	return self._goddess_trial_creeps[creepsMasterId]
end

function GoddessTrialConfig:getSupportPetCfgs(systemPetPlanId)
	return self._goddess_trial_system_pet[systemPetPlanId]
end

function GoddessTrialConfig:getPrizeCfgs(activityId)
	return self._goddess_trial_progress_prize[activityId]
end

function GoddessTrialConfig:getRankPrizeCfgs(activityId)
	return self._goddess_trial_rank_prize[activityId]
end

GoddessTrialConfig.instance = GoddessTrialConfig.New()

return GoddessTrialConfig
