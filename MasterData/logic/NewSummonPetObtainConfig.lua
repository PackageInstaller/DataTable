-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/config/NewSummonPetObtainConfig.lua

module("logic.extensions.newsummonpetobtain.config.NewSummonPetObtainConfig", package.seeall)

local NewSummonPetObtainConfig = class("NewSummonPetObtainConfig", BaseConfig)

function NewSummonPetObtainConfig:onInit()
	NewSummonPetObtainConfig.super.onInit(self)
end

function NewSummonPetObtainConfig:getNames()
	return {
		"new_summon_pet_obtain",
		"new_summon_pet_obtain_common",
		"new_summon_pet_obtain_prize",
		"new_summon_pet_obtain_task",
		"new_summon_pet_obtain_tier",
		"new_summon_pet_obtain_stage",
		"new_summon_pet_obtain_master",
		"new_summon_pet_obtain_creeps",
		"new_summon_pet_obtain_rule"
	}
end

function NewSummonPetObtainConfig:handleConfig(name, content)
	if name == "new_summon_pet_obtain" then
		self._nspoBaseCfg = content
	elseif name == "new_summon_pet_obtain_common" then
		self._nspoCommonCfg = content
	elseif name == "new_summon_pet_obtain_prize" then
		self._nspoPrizeCfgs = content
	elseif name == "new_summon_pet_obtain_task" then
		self._nspoTaskCfgs = content
	elseif name == "new_summon_pet_obtain_tier" then
		self._nspoTierCfgs = content
	elseif name == "new_summon_pet_obtain_stage" then
		self._nspoStageCfgs = content
	elseif name == "new_summon_pet_obtain_master" then
		self._nspoMasterCfg = content
	elseif name == "new_summon_pet_obtain_creeps" then
		self._nspoCreepsCfgs = content
	elseif name == "new_summon_pet_obtain_rule" then
		self._nspoRuleCfg = content
	end
end

function NewSummonPetObtainConfig:getNspoBaseData(activityId)
	return self._nspoBaseCfg[activityId]
end

function NewSummonPetObtainConfig:getNspoPrizeCfg(prizePlanId)
	return self._nspoPrizeCfgs[prizePlanId]
end

function NewSummonPetObtainConfig:getNspoPrizeData(prizePlanId, prizeId)
	return self._nspoPrizeCfgs[prizePlanId][prizeId]
end

function NewSummonPetObtainConfig:getNspoPrizeCfgById(activityId)
	local prizePlanId = self:getNspoBaseData(activityId).prizePlanId

	return self._nspoPrizeCfgs[prizePlanId]
end

function NewSummonPetObtainConfig:getNspoPrizeDataById(activityId, prizeId)
	local prizePlanId = self:getNspoBaseData(activityId).prizePlanId

	return self._nspoPrizeCfgs[prizePlanId][prizeId]
end

function NewSummonPetObtainConfig:getNspoTaskCfg(taskPlanId)
	return self._nspoTaskCfgs[taskPlanId]
end

function NewSummonPetObtainConfig:getNspoTaskData(taskPlanId, taskId)
	return self._nspoTaskCfgs[taskPlanId][taskId]
end

function NewSummonPetObtainConfig:getNspoTaskCfgById(activityId)
	local taskPlanId = self:getNspoBaseData(activityId).taskPlanId

	return self._nspoTaskCfgs[taskPlanId]
end

function NewSummonPetObtainConfig:getNspoTaskDataById(activityId, taskId)
	local taskPlanId = self:getNspoBaseData(activityId).taskPlanId

	return self._nspoTaskCfgs[taskPlanId][taskId]
end

function NewSummonPetObtainConfig:getNspoTaskCount(activityId)
	local cfg = self:getNspoTaskCfgById(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function NewSummonPetObtainConfig:getNspoTierCfg(tierPlanId)
	return self._nspoTierCfgs[tierPlanId]
end

function NewSummonPetObtainConfig:getNspoTierData(tierPlanId, tier)
	return self._nspoTierCfgs[tierPlanId][tier]
end

function NewSummonPetObtainConfig:getNspoTierCfgById(activityId)
	local tierPlanId = self:getNspoBaseData(activityId).tierPlanId

	return self._nspoTierCfgs[tierPlanId]
end

function NewSummonPetObtainConfig:getNspoTierDataById(activityId, tier)
	local tierPlanId = self:getNspoBaseData(activityId).tierPlanId

	return self._nspoTierCfgs[tierPlanId][tier]
end

function NewSummonPetObtainConfig:getNspoMasterCfg()
	return self._nspoMasterCfg
end

function NewSummonPetObtainConfig:getNspoMasterData(creepsMasterId)
	return self._nspoMasterCfg[creepsMasterId]
end

function NewSummonPetObtainConfig:getNspoStageCfg(stagePlanId)
	return self._nspoStageCfgs[stagePlanId]
end

function NewSummonPetObtainConfig:getNspoStageData(stagePlanId, stageId)
	return self._nspoStageCfgs[stagePlanId][stageId]
end

function NewSummonPetObtainConfig:getNspoCreepsCfg(creepsMasterId)
	return self._nspoCreepsCfgs[creepsMasterId]
end

function NewSummonPetObtainConfig:getNspoCreepsData(creepsMasterId, creepsId)
	return self._nspoCreepsCfgs[creepsMasterId][creepsId]
end

function NewSummonPetObtainConfig:getNspoRuleData(ruleId)
	return self._nspoRuleCfg[ruleId]
end

function NewSummonPetObtainConfig:getNspoCommonValue(activityId, key, isToNumber)
	local comPlanId = self:getNspoBaseData(activityId).comPlanId
	local data = self._nspoCommonCfg[comPlanId][key]
	local value

	if data then
		value = data.value

		if isToNumber then
			value = checknumber(value)
		end
	end

	return value
end

function NewSummonPetObtainConfig:getNspoMusicCanPlayRedId(activityId)
	return self:getNspoCommonValue(activityId, "NSOP_MUSIC_CAN_PLAY")
end

function NewSummonPetObtainConfig:getNspoMusicPrizeRedId(activityId)
	return self:getNspoCommonValue(activityId, "NSOP_MUSIC_PRIZE")
end

function NewSummonPetObtainConfig:getNspoProgressPrizeRedId(activityId)
	return self:getNspoCommonValue(activityId, "NSOP_PROGRESS_PRIZE")
end

function NewSummonPetObtainConfig:getNspoPetSkinId(activityId)
	return self:getNspoCommonValue(activityId, "NSOP_PET_SKINID", true)
end

NewSummonPetObtainConfig.instance = NewSummonPetObtainConfig.New()

return NewSummonPetObtainConfig
