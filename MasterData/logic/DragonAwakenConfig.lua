-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/config/DragonAwakenConfig.lua

module("logic.extensions.dragonawaken.config.DragonAwakenConfig", package.seeall)

local DragonAwakenConfig = class("DragonAwakenConfig", BaseConfig)

function DragonAwakenConfig:getNames()
	return {
		"dragon_awaken_support",
		"dragon_awaken_training_form",
		"dragon_awaken_creeps",
		"dragon_awaken_equipment_cost",
		"dragon_awaken_equipment_level",
		"dragon_awaken_holy_stripe",
		"dragon_awaken_monster",
		"dragon_awaken_pet_level",
		"dragon_awaken_phase",
		"dragon_awaken_rank_prize",
		"dragon_awaken_stage_plan",
		"dragon_awaken_training",
		"dragon_awaken_stargod_level",
		"dragon_awaken_awaken_cost",
		"dragon_awaken_activity"
	}
end

function DragonAwakenConfig:handleConfig(name, content)
	if name == "dragon_awaken_support" then
		self._dragon_awaken_support = content
	elseif name == "dragon_awaken_training_form" then
		self._dragon_awaken_training_form = content
	elseif name == "dragon_awaken_creeps" then
		self._dragon_awaken_creeps = content
	elseif name == "dragon_awaken_equipment_cost" then
		self._dragon_awaken_equipment_cost = content
	elseif name == "dragon_awaken_equipment_level" then
		self._dragon_awaken_equipment_level = content
	elseif name == "dragon_awaken_holy_stripe" then
		self._dragon_awaken_holy_stripe = content
	elseif name == "dragon_awaken_monster" then
		self._dragon_awaken_monster = content
	elseif name == "dragon_awaken_pet_level" then
		self._dragon_awaken_pet_level = content
	elseif name == "dragon_awaken_phase" then
		self._dragon_awaken_phase = content
	elseif name == "dragon_awaken_rank_prize" then
		self._dragon_awaken_rank_prize = content
	elseif name == "dragon_awaken_stage_plan" then
		self._dragon_awaken_stage_plan = content
	elseif name == "dragon_awaken_training" then
		self._dragon_awaken_training = content
	elseif name == "dragon_awaken_stargod_level" then
		self._dragon_awaken_stargod_level = content
	elseif name == "dragon_awaken_awaken_cost" then
		self._dragon_awaken_awaken_cost = content
	elseif name == "dragon_awaken_activity" then
		self._dragon_awaken_activity = content
	end
end

function DragonAwakenConfig:getActivityCfg(actId)
	return self._dragon_awaken_activity[actId]
end

function DragonAwakenConfig:getPhaseCfgs(actId)
	return self._dragon_awaken_phase[actId]
end

function DragonAwakenConfig:getPhaseCfgById(actId, phaseId)
	local cfgs = self:getPhaseCfgs(actId) or {}

	return cfgs[phaseId]
end

function DragonAwakenConfig:getAllSupportCfgs(actId)
	return self._dragon_awaken_support[actId]
end

function DragonAwakenConfig:getSupportCfgById(actId, creepsId)
	local cfgs = self:getAllSupportCfgs(actId) or {}

	return cfgs[creepsId]
end

function DragonAwakenConfig:getSupportCfgByPhaseId(actId, phaseId)
	local cfgs = self:getAllSupportCfgs(actId) or {}

	for creepsId, cfg in ipairs(cfgs) do
		if cfg.mustFormPhase == phaseId then
			return cfg
		end
	end
end

function DragonAwakenConfig:getRankCfgByRank(actId, rank)
	if not self._dragon_awaken_rank_prize[actId] then
		for range, cfg in pairs(self._dragon_awaken_rank_prize[actId]) do
			if rank >= range[1] and rank <= range[2] then
				return cfg
			end
		end
	end
end

function DragonAwakenConfig:getTrainingCfgs(actId)
	return self._dragon_awaken_training[actId]
end

function DragonAwakenConfig:getTrainingCfgByHard(actId, hard)
	local cfgs = self:getTrainingCfgs(actId) or {}

	return cfgs[hard]
end

function DragonAwakenConfig:getTrainingFormCfgs(actId, hard)
	local cfg = self:getTrainingCfgByHard(actId, hard)

	return self._dragon_awaken_training_form[cfg.trainingFormPlan]
end

function DragonAwakenConfig:getTrainingFormCfgByFromId(actId, hard, formId)
	local cfgs = self:getTrainingFormCfgs(actId, hard) or {}

	return cfgs[formId]
end

function DragonAwakenConfig:getStageCfgs(planId)
	return self._dragon_awaken_stage_plan[planId]
end

function DragonAwakenConfig:getStageCfgByStageId(planId, stageId)
	local cfgs = self:getStageCfgs(planId) or {}

	return cfgs[stageId]
end

function DragonAwakenConfig:getFormationCfg(creepsMasterId)
	return self._dragon_awaken_monster[creepsMasterId] or {}
end

function DragonAwakenConfig:getCreepCfgs(creepsMasterId)
	return self._dragon_awaken_creeps[creepsMasterId] or {}
end

function DragonAwakenConfig:getStarGodCfgs(actId)
	return self._dragon_awaken_stargod_level[actId]
end

function DragonAwakenConfig:getStarGodCfgByLv(actId, level)
	local cfgs = self:getStarGodCfgs(actId) or {}

	return cfgs[level]
end

function DragonAwakenConfig:getAwakenCostCfgs(actId)
	return self._dragon_awaken_awaken_cost[actId]
end

function DragonAwakenConfig:getAwakenCostCfgByLv(actId, level)
	local cfgs = self:getAwakenCostCfgs(actId) or {}

	return cfgs[level]
end

function DragonAwakenConfig:getHolyStripeCfgs(actId)
	return self._dragon_awaken_holy_stripe[actId]
end

function DragonAwakenConfig:getHolyStripeCostByLv(actId, level)
	local cfgs = self:getHolyStripeCfgs(actId) or {}

	return cfgs[1][level]
end

function DragonAwakenConfig:getEquipCostById(activityId, lvl)
	if self._dragon_awaken_equipment_cost[activityId] then
		return self._dragon_awaken_equipment_cost[activityId][lvl]
	end
end

function DragonAwakenConfig:getEquipCfg(activityId, job, posId, lvl)
	local cfg = self._dragon_awaken_equipment_level

	if cfg[activityId] and cfg[activityId][job] and cfg[activityId][job][posId] then
		return cfg[activityId][job][posId][lvl]
	end
end

function DragonAwakenConfig:getPetLvUpCostById(activityId, lvl)
	if self._dragon_awaken_pet_level[activityId] then
		return self._dragon_awaken_pet_level[activityId][lvl]
	end
end

DragonAwakenConfig.instance = DragonAwakenConfig.New()

return DragonAwakenConfig
