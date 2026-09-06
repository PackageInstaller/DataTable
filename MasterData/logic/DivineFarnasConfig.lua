-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/config/DivineFarnasConfig.lua

module("logic.extensions.divineeternaldragonclg.config.DivineFarnasConfig", package.seeall)

local DivineFarnasConfig = class("DivineFarnasConfig", BaseConfig)

function DivineFarnasConfig:getNames()
	return {
		"divine_farnas_clg_activity",
		"divine_farnas_clg_extreme_stage",
		"divine_farnas_clg_extreme_buff",
		"divine_farnas_clg_creeps_master",
		"divine_farnas_clg_creeps",
		"divine_farnas_clg_normal_stage_plan",
		"divine_farnas_normal_clg_prize",
		"divine_farnas_clg_support_pet"
	}
end

function DivineFarnasConfig:handleConfig(name, content)
	if name == "divine_farnas_clg_activity" then
		self._divine_farnas_clg_activity = content
	elseif name == "divine_farnas_clg_extreme_stage" then
		self._divine_farnas_clg_extreme_stage = content
	elseif name == "divine_farnas_clg_extreme_buff" then
		self._divine_farnas_clg_extreme_buff = content
	elseif name == "divine_farnas_clg_creeps_master" then
		self._divine_farnas_clg_creeps_master = content
	elseif name == "divine_farnas_clg_creeps" then
		self._divine_farnas_clg_creeps = content
	elseif name == "divine_farnas_clg_normal_stage_plan" then
		self._divine_farnas_clg_normal_stage_plan = content
	elseif name == "divine_farnas_normal_clg_prize" then
		self._divine_farnas_normal_clg_prize = content
	elseif name == "divine_farnas_clg_support_pet" then
		self._divine_farnas_clg_support_pet = content
	end
end

function DivineFarnasConfig:getActCfg(activityId)
	return self._divine_farnas_clg_activity[activityId]
end

function DivineFarnasConfig:getExtStageCfgs(activityId)
	return self._divine_farnas_clg_extreme_stage[activityId]
end

function DivineFarnasConfig:getExtStageCfgByStageId(activityId, stageId)
	return self._divine_farnas_clg_extreme_stage[activityId] and self._divine_farnas_clg_extreme_stage[activityId][stageId]
end

function DivineFarnasConfig:getBuffCfgs(activityId)
	return self._divine_farnas_clg_extreme_buff[activityId]
end

function DivineFarnasConfig:getBuffCfgByBuffId(activityId, buffId)
	return self._divine_farnas_clg_extreme_buff[activityId] and self._divine_farnas_clg_extreme_buff[activityId][buffId]
end

function DivineFarnasConfig:getCreepMasterCfg(creepsMasterId)
	return self._divine_farnas_clg_creeps_master[creepsMasterId]
end

function DivineFarnasConfig:getCreepsCfg(creepsMasterId)
	return self._divine_farnas_clg_creeps[creepsMasterId]
end

function DivineFarnasConfig:getNorPlanCfgs(acticityId)
	return self._divine_farnas_clg_normal_stage_plan[acticityId]
end

function DivineFarnasConfig:getNorPlanCfgsByGroupId(acticityId, groupId)
	return self._divine_farnas_clg_normal_stage_plan[acticityId] and self._divine_farnas_clg_normal_stage_plan[acticityId][groupId]
end

function DivineFarnasConfig:getNorPlanCfgByStageId(activityId, groupId, stageId)
	local cfgs = self:getNorPlanCfgsByGroupId(activityId, groupId)

	return cfgs and cfgs[stageId]
end

function DivineFarnasConfig:getNorPrizeCfgs(activityId)
	return self._divine_farnas_normal_clg_prize[activityId]
end

function DivineFarnasConfig:getNorPrizeCfgByPrizeId(activityId, prizeId)
	return self._divine_farnas_normal_clg_prize[activityId] and self._divine_farnas_normal_clg_prize[activityId][prizeId]
end

function DivineFarnasConfig:getSupportPetCfgs(activityId)
	return self._divine_farnas_clg_support_pet[activityId]
end

function DivineFarnasConfig:getSupportPetCfgByCreepsId(activityId, creepsId)
	return self._divine_farnas_clg_support_pet[activityId] and self._divine_farnas_clg_support_pet[activityId][creepsId]
end

function DivineFarnasConfig:getExtCreepsMasterId(activityId, stageId)
	local stageCfg = self:getExtStageCfgByStageId(activityId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function DivineFarnasConfig:getNorCreepsMasterId(activityId, groupId, stageId)
	local planCfg = self:getNorPlanCfgByStageId(activityId, groupId, stageId)

	return planCfg and planCfg.creepsMasterId
end

function DivineFarnasConfig:getFmtCfg(activityId, groupId, stageId)
	local creepsMasterId = self:getNorCreepsMasterId(activityId, groupId, stageId)

	if creepsMasterId then
		return (self:getCreepsCfg(creepsMasterId))
	end
end

function DivineFarnasConfig:getFirstPetSkinId(activityId, stageId)
	local creepsMasterId = self:getExtCreepsMasterId(activityId, stageId)

	if creepsMasterId then
		local creepsMasterCfg = self:getCreepsCfg(creepsMasterId)
		local firstPetCfg = creepsMasterCfg[1]

		return firstPetCfg and firstPetCfg.raceId
	end
end

DivineFarnasConfig.instance = DivineFarnasConfig.New()

return DivineFarnasConfig
