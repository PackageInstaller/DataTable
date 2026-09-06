-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/config/KdChallengeConfig.lua

module("logic.extensions.kingdragonchallenge.config.KdChallengeConfig", package.seeall)

local KdChallengeConfig = class("KdChallengeConfig", BaseConfig)

function KdChallengeConfig:onInit()
	KdChallengeConfig.super.onInit(self)
end

function KdChallengeConfig:getNames()
	return {
		"king_dragon_common",
		"king_dragon_challenge",
		"king_dragon_boss",
		"king_dragon_boss_buy_time",
		"king_dragon_boss_damage",
		"king_dragon_stage",
		"king_dragon_help_pet_plan",
		"king_dragon_unit",
		"king_dragon_buff",
		"king_dragon_challenge_system_pet",
		"king_dragon_challenge_enemy",
		"king_dragon_challenge_creeps",
		"king_dragon_login_task_plan",
		"king_nuoya_common",
		"king_dragon_boss_buff_plan"
	}
end

function KdChallengeConfig:handleConfig(name, content)
	if name == "king_dragon_common" then
		self._kdCommonCfg = content
	elseif name == "king_dragon_challenge" then
		self._kdChallengeCfg = content
	elseif name == "king_dragon_boss" then
		self._kdBossCfg = content
	elseif name == "king_dragon_boss_buy_time" then
		self._kdBossBuyCfgs = content
	elseif name == "king_dragon_boss_damage" then
		self._kdBossDamageCfgs = content
	elseif name == "king_dragon_stage" then
		self._kdStageCfgs = content
	elseif name == "king_dragon_help_pet_plan" then
		self._kdHelpPetCfgs = content
	elseif name == "king_dragon_unit" then
		self._kdUnitCfgs = content
	elseif name == "king_dragon_buff" then
		self._kdBuffCfg = content
	elseif name == "king_dragon_challenge_system_pet" then
		self._kdChallengeSystemPetCfg = content
	elseif name == "king_dragon_challenge_enemy" then
		self._kdChallengeEnemyCfgs = content
	elseif name == "king_dragon_challenge_creeps" then
		self._kdChallengeCreepsCfgs = content
	elseif name == "king_dragon_login_task_plan" then
		self._loginTaskPlan = content
	elseif name == "king_nuoya_common" then
		self._nuoyaCommonCfg = content
	elseif name == "king_dragon_boss_buff_plan" then
		self._daliyBuffCfg = content
	end
end

function KdChallengeConfig:getKdCommonValue(key)
	return self._kdCommonCfg[key] and self._kdCommonCfg[key].value
end

function KdChallengeConfig:getKdCurChallengeId()
	return checknumber(self:getKdCommonValue("CUR_CHALLENGE_ID"))
end

function KdChallengeConfig:getKdShowResource()
	return self:getKdCommonValue("SHOW_RESOURCE")
end

function KdChallengeConfig:getKdLandingOnceRedList()
	local value = self:getKdCommonValue("LANDING_ONCE_RED_LIST") or {}

	return string.split(value, "#")
end

function KdChallengeConfig:getKdCurRaceId()
	return checknumber(self:getKdCommonValue("CUR_PET_RACEID"))
end

function KdChallengeConfig:getKdCurSkinId()
	return checknumber(self:getKdCommonValue("CUR_PET_SKINID"))
end

function KdChallengeConfig:getNuoyaCommonValue(key)
	return self._nuoyaCommonCfg[key] and self._nuoyaCommonCfg[key].value
end

function KdChallengeConfig:getNuoyaCurChallengeId()
	return checknumber(self:getNuoyaCommonValue("CUR_CHALLENGE_ID"))
end

function KdChallengeConfig:getNuoyaCurRaceId()
	return checknumber(self:getNuoyaCommonValue("CUR_PET_RACEID"))
end

function KdChallengeConfig:getNuoyaLandingOnceRedList()
	local value = self:getNuoyaCommonValue("LANDING_ONCE_RED_LIST") or {}

	return string.split(value, "#")
end

function KdChallengeConfig:getNuoyaCurSkinId()
	return checknumber(self:getNuoyaCommonValue("CUR_PET_SKINID"))
end

function KdChallengeConfig:getNuoyaShowResource()
	return self:getNuoyaCommonValue("SHOW_RESOURCE")
end

function KdChallengeConfig:getKdChallengeCfg()
	return self._kdChallengeCfg
end

function KdChallengeConfig:getKdChallengeData(challengeId)
	return self._kdChallengeCfg[challengeId]
end

function KdChallengeConfig:getKdBossData(planId)
	return self._kdBossCfg[planId]
end

function KdChallengeConfig:getKdBossDataByCId(challengeId)
	local planId = self:getKdChallengeData(challengeId).planId

	return self:getKdBossData(planId)
end

function KdChallengeConfig:getKdBossBuyCfg(buyTimesPlanId)
	return self._kdBossBuyCfgs[buyTimesPlanId]
end

function KdChallengeConfig:getKdBossBuyData(buyTimesPlanId, times)
	return self._kdBossBuyCfgs[buyTimesPlanId][times]
end

function KdChallengeConfig:getKdBossBuyCfgByCId(challengeId)
	local planId = self:getKdChallengeData(challengeId).planId
	local buyTimesPlanId = self:getKdBossDataByCId(challengeId).buyTimesPlanId

	return self:getKdBossBuyCfg(buyTimesPlanId)
end

function KdChallengeConfig:getKdBossBuyDataByCId(challengeId, times)
	return self:getKdBossBuyCfgByCId(challengeId)[times]
end

function KdChallengeConfig:getKdBossDamageCfg(damageScorePlan)
	return self._kdBossDamageCfgs[damageScorePlan]
end

function KdChallengeConfig:getKdBossDamageData(damageScorePlan, id)
	return self._kdBossDamageCfgs[damageScorePlan][id]
end

function KdChallengeConfig:getKdBossDamageCfgByCId(challengeId)
	local planId = self:getKdChallengeData(challengeId).planId
	local damageScorePlan = self:getKdBossDataByCId(challengeId).damageScorePlan

	return self:getKdBossDamageCfg(damageScorePlan)
end

function KdChallengeConfig:getKdBossDamageDataByCId(challengeId, id)
	return self:getKdBossDamageCfgByCId(challengeId)[id]
end

function KdChallengeConfig:getKdStageCfg(planId)
	return self._kdStageCfgs[planId]
end

function KdChallengeConfig:getKdStageData(planId, stageId)
	return self._kdStageCfgs[planId][stageId]
end

function KdChallengeConfig:getKdStageCfgByCId(challengeId)
	local planId = self:getKdChallengeData(challengeId).planId

	return self:getKdStageCfg(planId)
end

function KdChallengeConfig:getKdStageDataByCId(challengeId, stageId)
	return self:getKdStageCfgByCId(challengeId)[stageId]
end

function KdChallengeConfig:getKdHelpPetCfg(helpPlanId)
	return self._kdHelpPetCfgs[helpPlanId]
end

function KdChallengeConfig:getKdHelpPetData(helpPlanId, creepsSysId)
	return self._kdHelpPetCfgs[helpPlanId][creepsSysId]
end

function KdChallengeConfig:getKdUnitCfg(planId)
	return self._kdUnitCfgs[planId]
end

function KdChallengeConfig:getKdUnitData(planId, unitId)
	return self._kdUnitCfgs[planId][unitId]
end

function KdChallengeConfig:getKdUnitCfgByCId(challengeId)
	local planId = self:getKdChallengeData(challengeId).planId

	return self:getKdUnitCfg(planId)
end

function KdChallengeConfig:getKdUnitDataByCId(challengeId, unitId)
	return self:getKdUnitCfgByCId(challengeId)[unitId]
end

function KdChallengeConfig:getKdBuffData(buffId)
	return self._kdBuffCfg[buffId]
end

function KdChallengeConfig:getKdChallengeSystemPetCfg()
	return self._kdChallengeSystemPetCfg
end

function KdChallengeConfig:getKdChallengeSystemPetData(creepsId)
	return self._kdChallengeSystemPetCfg[creepsId]
end

function KdChallengeConfig:getKdChallengeEnemyCfg(creepsMasterId)
	return self._kdChallengeEnemyCfgs[creepsMasterId]
end

function KdChallengeConfig:getKdChallengeCreepsCfg(creepsMasterId)
	return self._kdChallengeCreepsCfgs[creepsMasterId]
end

function KdChallengeConfig:getKdChallengeCreepsData(creepsMasterId, creepsId)
	return self._kdChallengeCreepsCfgs[creepsMasterId][creepsId]
end

function KdChallengeConfig:getTaskCfgByPlan(plan)
	return self._loginTaskPlan[plan]
end

function KdChallengeConfig:getDailyBuffCfgByPlan(plan)
	return self._daliyBuffCfg[plan]
end

KdChallengeConfig.instance = KdChallengeConfig.New()

return KdChallengeConfig
