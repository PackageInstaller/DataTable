-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/config/DivineTianShanClgConfig.lua

module("logic.extensions.divinetianshanclg.config.DivineTianShanClgConfig", package.seeall)

local DivineTianShanClgConfig = class("DivineTianShanClgConfig", BaseConfig)

function DivineTianShanClgConfig:getNames()
	return {
		"divine_tian_shan_clg_activity",
		"divine_tian_shan_clg_creeps",
		"divine_tian_shan_clg_creeps_master",
		"divine_tian_shan_clg_extreme_stage",
		"divine_tian_shan_clg_normal_clg_buff",
		"divine_tian_shan_clg_normal_clg_plan",
		"divine_tian_shan_clg_normal_clg_prize",
		"divine_tian_shan_clg_normal_stage_plan",
		"divine_tian_shan_clg_extreme_stage_desc"
	}
end

function DivineTianShanClgConfig:handleConfig(name, content)
	if name == "divine_tian_shan_clg_activity" then
		self._divine_tian_shan_clg_activity = content
	elseif name == "divine_tian_shan_clg_extreme_stage" then
		self._divine_tian_shan_clg_extreme_stage = content

		self:_handleExtremeStageCfg()
	elseif name == "divine_tian_shan_clg_extreme_stage_desc" then
		self._divine_tian_shan_clg_extreme_stage_desc = content
	elseif name == "divine_tian_shan_clg_normal_stage_plan" then
		self._divine_tian_shan_clg_normal_stage_plan = content
	elseif name == "divine_tian_shan_clg_creeps" then
		self._divine_tian_shan_clg_creeps = content
	elseif name == "divine_tian_shan_clg_creeps_master" then
		self._divine_tian_shan_clg_creeps_master = content
	elseif name == "divine_tian_shan_clg_normal_clg_buff" then
		self._divine_tian_shan_clg_normal_clg_buff = content
	elseif name == "divine_tian_shan_clg_normal_clg_plan" then
		self._divine_tian_shan_clg_normal_clg_plan = content
	elseif name == "divine_tian_shan_clg_normal_clg_prize" then
		self._divine_tian_shan_clg_normal_clg_prize = content
	end
end

function DivineTianShanClgConfig:getActCfgById(actId)
	return self._divine_tian_shan_clg_activity[actId]
end

function DivineTianShanClgConfig:getExtremeStageDescCfgs(planId)
	return self._divine_tian_shan_clg_extreme_stage_desc[planId]
end

function DivineTianShanClgConfig:_handleExtremeStageCfg()
	self._extremeStageCfgs = {}

	for i, v in ipairs(self._divine_tian_shan_clg_extreme_stage.dataList) do
		self._extremeStageCfgs[v.stagePlanId] = self._extremeStageCfgs[v.stagePlanId] or {}
		self._extremeStageCfgs[v.stagePlanId][v.phaseId] = self._extremeStageCfgs[v.stagePlanId][v.phaseId] or {}

		table.insert(self._extremeStageCfgs[v.stagePlanId][v.phaseId], v)
	end
end

function DivineTianShanClgConfig:getExtremeStageCfgsByPhaseId(planId, phaseId)
	if self._extremeStageCfgs[planId] then
		return self._extremeStageCfgs[planId][phaseId]
	end
end

function DivineTianShanClgConfig:getExtremeStageCfgsByPlanId(planId)
	return self._divine_tian_shan_clg_extreme_stage[planId]
end

function DivineTianShanClgConfig:getExtremeStageCfgByStageId(planId, stageId)
	if self._divine_tian_shan_clg_extreme_stage[planId] then
		return self._divine_tian_shan_clg_extreme_stage[planId][stageId]
	end
end

function DivineTianShanClgConfig:getCreepCfgs(creepsMasterId)
	return self._divine_tian_shan_clg_creeps[creepsMasterId]
end

function DivineTianShanClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_tian_shan_clg_creeps_master[creepsMasterId]
end

function DivineTianShanClgConfig:getNormalStagePlanCfgs(planId)
	return self._divine_tian_shan_clg_normal_stage_plan[planId]
end

function DivineTianShanClgConfig:getNormalClgPlanCfg(planId)
	return self._divine_tian_shan_clg_normal_clg_plan[planId]
end

function DivineTianShanClgConfig:getNormalBuffCfgs(planId)
	return self._divine_tian_shan_clg_normal_clg_buff[planId]
end

function DivineTianShanClgConfig:getNormalPrizeCfgs(planId)
	return self._divine_tian_shan_clg_normal_clg_prize[planId]
end

DivineTianShanClgConfig.instance = DivineTianShanClgConfig.New()

return DivineTianShanClgConfig
