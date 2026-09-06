-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/config/JiuClgConfig.lua

module("logic.extensions.jiuclg.config.JiuClgConfig", package.seeall)

local JiuClgConfig = class("JiuClgConfig", BaseConfig)

function JiuClgConfig:getNames()
	return {
		"jiu_clg",
		"jiu_normal_clg_phase",
		"jiu_normal_clg_stage",
		"jiu_extreme_clg_phase",
		"jiu_extreme_clg_stage",
		"jiu_extreme_clg_lock_pet_plan",
		"jiu_clg_creeps_master",
		"jiu_clg_creeps",
		"jiu_clg_common"
	}
end

function JiuClgConfig:handleConfig(name, content)
	if name == "jiu_clg" then
		self.jiu_clg = content
	elseif name == "jiu_normal_clg_phase" then
		self.jiu_normal_clg_phase = content
	elseif name == "jiu_normal_clg_stage" then
		self.jiu_normal_clg_stage = content
	elseif name == "jiu_extreme_clg_phase" then
		self.jiu_extreme_clg_phase = content
	elseif name == "jiu_extreme_clg_stage" then
		self.jiu_extreme_clg_stage = content
	elseif name == "jiu_extreme_clg_lock_pet_plan" then
		self.jiu_extreme_clg_lock_pet_plan = content
	elseif name == "jiu_clg_creeps_master" then
		self.jiu_clg_creeps_master = content
	elseif name == "jiu_clg_creeps" then
		self.jiu_clg_creeps = content
	elseif name == "jiu_clg_common" then
		self.jiu_clg_common = content
	end
end

function JiuClgConfig:getActivityCfg(activityId)
	return self.jiu_clg[activityId]
end

function JiuClgConfig:getNormalPhaseCfgList(activityId)
	return self.jiu_normal_clg_phase[activityId]
end

function JiuClgConfig:getNormalPhaseCfg(activityId, phaseId)
	return self.jiu_normal_clg_phase[activityId] and self.jiu_normal_clg_phase[activityId][phaseId]
end

function JiuClgConfig:getNormalStageCfgList(activityId, phaseId)
	return self.jiu_normal_clg_stage[activityId] and self.jiu_normal_clg_stage[activityId][phaseId]
end

function JiuClgConfig:getNormalStageCfg(activityId, phaseId, stageId)
	return self.jiu_normal_clg_stage[activityId] and self.jiu_normal_clg_stage[activityId][phaseId] and self.jiu_normal_clg_stage[activityId][phaseId][stageId]
end

function JiuClgConfig:getExtremePhaseCfgList(activityId)
	return self.jiu_extreme_clg_phase[activityId]
end

function JiuClgConfig:getExtremePhaseCfg(activityId, phaseId)
	return self.jiu_extreme_clg_phase[activityId] and self.jiu_extreme_clg_phase[activityId][phaseId]
end

function JiuClgConfig:getExtremeStageList(activityId, phaseId)
	return self.jiu_extreme_clg_stage[activityId] and self.jiu_extreme_clg_stage[activityId][phaseId]
end

function JiuClgConfig:getExtremeStageCfg(activityId, phaseId, stageId)
	return self.jiu_extreme_clg_stage[activityId] and self.jiu_extreme_clg_stage[activityId][phaseId] and self.jiu_extreme_clg_stage[activityId][phaseId][stageId]
end

function JiuClgConfig:getExtremeLockPetPlanList(planId)
	return self.jiu_extreme_clg_lock_pet_plan[planId]
end

function JiuClgConfig:getMonsterCfg(creepsMasterId)
	return self.jiu_clg_creeps_master[creepsMasterId]
end

function JiuClgConfig:getCreeps(creepsMasterId)
	return self.jiu_clg_creeps[creepsMasterId]
end

function JiuClgConfig:getCommonValue(key)
	return self.jiu_clg_common[key] and self.jiu_clg_common[key].value
end

JiuClgConfig.instance = JiuClgConfig.New()

return JiuClgConfig
