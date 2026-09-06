-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/config/GuardDestroyConfig.lua

module("logic.extensions.guarddestroy.agent.GuardDestroyConfig", package.seeall)

local GuardDestroyConfig = class("GuardDestroyConfig", BaseConfig)

function GuardDestroyConfig:onInit()
	GuardDestroyConfig.super.onInit(self)
end

function GuardDestroyConfig:getNames()
	return {
		"guard_destroy_stage",
		"guard_destroy_activity",
		"guard_destroy_progress_prize",
		"guard_destroy_rank_prize",
		"guard_destroy_master",
		"guard_destroy_creeps",
		"guard_destroy_support_pet",
		"guard_destroy_sign_in_buff"
	}
end

function GuardDestroyConfig:handleConfig(name, content)
	if name == "guard_destroy_activity" then
		self._guard_destroy_activity = content
	elseif name == "guard_destroy_stage" then
		self._guard_destroy_stage = content
	elseif name == "guard_destroy_progress_prize" then
		self._guard_destroy_progress_prize = content
	elseif name == "guard_destroy_rank_prize" then
		self._guard_destroy_rank_prize = content
	elseif name == "guard_destroy_master" then
		self._guard_destroy_master = content
	elseif name == "guard_destroy_creeps" then
		self._guard_destroy_creeps = content
	elseif name == "guard_destroy_support_pet" then
		self._guard_destroy_support_pet = content
	elseif name == "guard_destroy_sign_in_buff" then
		self._guard_destroy_sign_in_buff = content
	end
end

function GuardDestroyConfig:getActivityCfg(activityId)
	return self._guard_destroy_activity[activityId]
end

function GuardDestroyConfig:getStageCfg(activityId, stageId)
	if self._guard_destroy_stage[activityId] then
		return self._guard_destroy_stage[activityId][stageId]
	end
end

function GuardDestroyConfig:getStageCfgs(activityId)
	return self._guard_destroy_stage[activityId]
end

function GuardDestroyConfig:getTeamCfg(creepsMasterId)
	return self._guard_destroy_master[creepsMasterId]
end

function GuardDestroyConfig:getCreepsCfg(creepsMasterId)
	return self._guard_destroy_creeps[creepsMasterId]
end

function GuardDestroyConfig:getRankPrizeCfgs(activityId)
	return self._guard_destroy_rank_prize[activityId]
end

function GuardDestroyConfig:getProgressPrizeCfgs(activityId, type)
	if self._guard_destroy_progress_prize[activityId] then
		return self._guard_destroy_progress_prize[activityId][type]
	end
end

function GuardDestroyConfig:getSupportPetCfgs(supportPetPlanId)
	return self._guard_destroy_support_pet[supportPetPlanId]
end

function GuardDestroyConfig:getSupportPetCfg(supportPetPlanId, creepsId)
	if self._guard_destroy_support_pet[supportPetPlanId] then
		return self._guard_destroy_support_pet[supportPetPlanId][creepsId]
	end
end

function GuardDestroyConfig:getSignInBuffCfgs(activityId)
	return self._guard_destroy_sign_in_buff[activityId]
end

function GuardDestroyConfig:getSignInBuff(activityId, level)
	if self._guard_destroy_sign_in_buff[activityId] then
		return self._guard_destroy_sign_in_buff[activityId][level]
	end
end

GuardDestroyConfig.instance = GuardDestroyConfig.New()

return GuardDestroyConfig
