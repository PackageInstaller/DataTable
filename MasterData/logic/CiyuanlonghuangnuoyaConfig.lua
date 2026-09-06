-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/config/CiyuanlonghuangnuoyaConfig.lua

module("logic.extensions.ciyuanlonghuangnuoya.config.CiyuanlonghuangnuoyaConfig", package.seeall)

local CiyuanlonghuangnuoyaConfig = class("CiyuanlonghuangnuoyaConfig", BaseConfig)

function CiyuanlonghuangnuoyaConfig:getNames()
	return {
		"ci_yuan_dragon_nuo_ya_clg_support_pet",
		"ci_yuan_dragon_nuo_ya_clg_creeps",
		"ci_yuan_dragon_nuo_ya_clg_creeps_master",
		"ci_yuan_dragon_nuo_ya_clg_phase",
		"ci_yuan_dragon_nuo_ya_clg_stage",
		"ci_yuan_dragon_nuo_ya_clg",
		"ci_yuan_dragon_nuo_ya_clg_btl_plan"
	}
end

function CiyuanlonghuangnuoyaConfig:handleConfig(name, content)
	if name == "ci_yuan_dragon_nuo_ya_clg_support_pet" then
		self._ci_yuan_dragon_nuo_ya_clg_support_pet = content
	elseif name == "ci_yuan_dragon_nuo_ya_clg_creeps" then
		self._ci_yuan_dragon_nuo_ya_clg_creeps = content
	elseif name == "ci_yuan_dragon_nuo_ya_clg_creeps_master" then
		self._ci_yuan_dragon_nuo_ya_clg_creeps_master = content
	elseif name == "ci_yuan_dragon_nuo_ya_clg_phase" then
		self._ci_yuan_dragon_nuo_ya_clg_phase = content
	elseif name == "ci_yuan_dragon_nuo_ya_clg_stage" then
		self._ci_yuan_dragon_nuo_ya_clg_stage = content
	elseif name == "ci_yuan_dragon_nuo_ya_clg" then
		self._ci_yuan_dragon_nuo_ya_clg = content
	elseif name == "ci_yuan_dragon_nuo_ya_clg_btl_plan" then
		self._ci_yuan_dragon_nuo_ya_clg_btl_plan = content
	end
end

function CiyuanlonghuangnuoyaConfig:getActivityCfgById(activityId)
	return self._ci_yuan_dragon_nuo_ya_clg[activityId]
end

function CiyuanlonghuangnuoyaConfig:getPlanCfgById(planId)
	return self._ci_yuan_dragon_nuo_ya_clg_btl_plan[planId]
end

function CiyuanlonghuangnuoyaConfig:getPhaseListById(activityId)
	return self._ci_yuan_dragon_nuo_ya_clg_phase[activityId]
end

function CiyuanlonghuangnuoyaConfig:getPhaseCfgById(activityId, phaseId)
	if self._ci_yuan_dragon_nuo_ya_clg_phase[activityId] then
		return self._ci_yuan_dragon_nuo_ya_clg_phase[activityId][phaseId]
	end
end

function CiyuanlonghuangnuoyaConfig:getStageListById(activityId, phaseId)
	if self._ci_yuan_dragon_nuo_ya_clg_stage[activityId] then
		return self._ci_yuan_dragon_nuo_ya_clg_stage[activityId][phaseId]
	end
end

function CiyuanlonghuangnuoyaConfig:getStageCfgById(activityId, phaseId, stageId)
	if self._ci_yuan_dragon_nuo_ya_clg_stage[activityId] and self._ci_yuan_dragon_nuo_ya_clg_stage[activityId][phaseId] then
		return self._ci_yuan_dragon_nuo_ya_clg_stage[activityId][phaseId][stageId]
	end
end

function CiyuanlonghuangnuoyaConfig:getSupportCfgById(activityId, creepsMasterId)
	if self._ci_yuan_dragon_nuo_ya_clg_support_pet[activityId] then
		return self._ci_yuan_dragon_nuo_ya_clg_support_pet[activityId][creepsMasterId]
	end
end

function CiyuanlonghuangnuoyaConfig:getCreepsById(creepsMasterId)
	return self._ci_yuan_dragon_nuo_ya_clg_creeps[creepsMasterId]
end

function CiyuanlonghuangnuoyaConfig:getMonsterCfgById(creepsMasterId)
	return self._ci_yuan_dragon_nuo_ya_clg_creeps_master[creepsMasterId]
end

CiyuanlonghuangnuoyaConfig.instance = CiyuanlonghuangnuoyaConfig.New()

return CiyuanlonghuangnuoyaConfig
