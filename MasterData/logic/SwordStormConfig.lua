-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/config/SwordStormConfig.lua

module("logic.extensions.swordstorm.config.SwordStormConfig", package.seeall)

local SwordStormConfig = class("SwordStormConfig", BaseConfig)

function SwordStormConfig:getNames()
	return {
		"sword_storm_stage",
		"sword_storm_creeps",
		"sword_storm_monster",
		"sword_storm_phase",
		"sword_storm_support_pet",
		"sword_storm_condition",
		"sword_storm_activity"
	}
end

function SwordStormConfig:handleConfig(name, content)
	if name == "sword_storm_stage" then
		self._sword_storm_stage = content
	elseif name == "sword_storm_creeps" then
		self._sword_storm_creeps = content
	elseif name == "sword_storm_monster" then
		self._sword_storm_monster = content
	elseif name == "sword_storm_phase" then
		self._sword_storm_phase = content
	elseif name == "sword_storm_support_pet" then
		self._sword_storm_support_pet = content
	elseif name == "sword_storm_condition" then
		self._sword_storm_condition = content
	elseif name == "sword_storm_activity" then
		self._sword_storm_activity = content
	end
end

function SwordStormConfig:getActivityCfg(activityId)
	return self._sword_storm_activity[activityId]
end

function SwordStormConfig:getPhaseCfgs(activityId)
	return self._sword_storm_phase[activityId]
end

function SwordStormConfig:getPhaseCfg(activityId, phaseId)
	if self._sword_storm_phase[activityId] then
		return self._sword_storm_phase[activityId][phaseId]
	end
end

function SwordStormConfig:getStageCfgs(activityId, phaseId)
	if self._sword_storm_stage[activityId] then
		return self._sword_storm_stage[activityId][phaseId]
	end
end

function SwordStormConfig:getStageCfg(activityId, phaseId, stageId)
	if self._sword_storm_stage[activityId] and self._sword_storm_stage[activityId][phaseId] then
		return self._sword_storm_stage[activityId][phaseId][stageId]
	end
end

function SwordStormConfig:getTeamCfg(creepsMasterId)
	return self._sword_storm_monster[creepsMasterId]
end

function SwordStormConfig:getCreepsCfg(creepsMasterId)
	return self._sword_storm_creeps[creepsMasterId]
end

function SwordStormConfig:getConditionPlanCfgs(conditionPlanId)
	return self._sword_storm_condition[conditionPlanId]
end

function SwordStormConfig:getConditionCfg(conditionPlanId, conditionId)
	if self._sword_storm_condition[conditionPlanId] then
		return self._sword_storm_condition[conditionPlanId][conditionId]
	end
end

function SwordStormConfig:getSupportPetCfgs(supportPetPlanId)
	return self._sword_storm_support_pet[supportPetPlanId]
end

function SwordStormConfig:getSupportPetCfg(supportPetPlanId, creepsId)
	if self._sword_storm_support_pet[supportPetPlanId] then
		return self._sword_storm_support_pet[supportPetPlanId][creepsId]
	end
end

SwordStormConfig.instance = SwordStormConfig.New()

return SwordStormConfig
