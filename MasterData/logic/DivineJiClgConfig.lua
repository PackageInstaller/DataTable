-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/config/DivineJiClgConfig.lua

module("logic.extensions.divinejiclg.config.DivineJiClgConfig", package.seeall)

local DivineJiClgConfig = class("DivineJiClgConfig", BaseConfig)

function DivineJiClgConfig:getNames()
	return {
		"divine_ji_clg",
		"divine_ji_extreme_clg_stage",
		"divine_ji_extreme_clg_buff_plan",
		"divine_ji_extreme_clg_factor_plan",
		"divine_ji_normal_clg_buff",
		"divine_ji_normal_clg_progress",
		"divine_ji_clg_creeps_master",
		"divine_ji_clg_creeps"
	}
end

function DivineJiClgConfig:handleConfig(name, content)
	if name == "divine_ji_clg" then
		self.divine_ji_clg = content
	elseif name == "divine_ji_extreme_clg_stage" then
		self.divine_ji_extreme_clg_stage = content
	elseif name == "divine_ji_extreme_clg_buff_plan" then
		self.divine_ji_extreme_clg_buff_plan = content
	elseif name == "divine_ji_extreme_clg_factor_plan" then
		self.divine_ji_extreme_clg_factor_plan = content
	elseif name == "divine_ji_normal_clg_buff" then
		self.divine_ji_normal_clg_buff = content
	elseif name == "divine_ji_normal_clg_progress" then
		self.divine_ji_normal_clg_progress = content
	elseif name == "divine_ji_clg_creeps_master" then
		self.divine_ji_clg_creeps_master = content
	elseif name == "divine_ji_clg_creeps" then
		self.divine_ji_clg_creeps = content
	end
end

function DivineJiClgConfig:getActivityCfgByActId(activityId)
	return self.divine_ji_clg[activityId]
end

function DivineJiClgConfig:getExtremeStageCfgByActId(activityId)
	return self.divine_ji_extreme_clg_stage[activityId]
end

function DivineJiClgConfig:getExtremeSingleStageCfg(activityId, stageId)
	return self.divine_ji_extreme_clg_stage[activityId][stageId]
end

function DivineJiClgConfig:getExtremeClgBuffPlanCfgById(buffPlanId)
	return self.divine_ji_extreme_clg_buff_plan[buffPlanId]
end

function DivineJiClgConfig:getExtremeStageBuffPlan(activityId, stageId)
	local stageCfg = self:getExtremeSingleStageCfg(activityId, stageId)
	local buffPlanId = checknumber(stageCfg and stageCfg.buffPlanId)

	if buffPlanId then
		return self:getExtremeClgBuffPlanCfgById(buffPlanId)
	end

	return {}
end

function DivineJiClgConfig:getExtremeFactorPlanCfgById(factorPlanId)
	return self.divine_ji_extreme_clg_factor_plan[factorPlanId]
end

function DivineJiClgConfig:getExtremeFactorPlanCfgByStageId(activityId, stageId)
	print("[YuTestPrint] =====>\t activityId = " .. tostring(activityId) .. "\t stageId = " .. tostring(stageId))

	local stageCfg = self:getExtremeSingleStageCfg(activityId, stageId)
	local factorPlanId = checknumber(stageCfg and stageCfg.factorPlanId)

	print("[YuTestPrint] =====>\t factorPlanId = " .. tostring(factorPlanId))

	if factorPlanId then
		return self:getExtremeFactorPlanCfgById(factorPlanId)
	end

	return {}
end

function DivineJiClgConfig:getNormalBuffCfgByActId(activityId)
	return self.divine_ji_normal_clg_buff[activityId]
end

function DivineJiClgConfig:getNormalSinlgeBuffCfg(activityId, buffId)
	return self.divine_ji_normal_clg_buff[activityId][buffId]
end

function DivineJiClgConfig:getNormalProgressCfgByActId(activityId)
	return self.divine_ji_normal_clg_progress[activityId]
end

function DivineJiClgConfig:getNormalCreepsMasterCfgByCreepsId(creepsMasterId)
	return self.divine_ji_clg_creeps_master[creepsMasterId]
end

function DivineJiClgConfig:getNormalCreepsCfgByCreepsId(creepsMasterId)
	return self.divine_ji_clg_creeps[creepsMasterId]
end

DivineJiClgConfig.instance = DivineJiClgConfig.New()

return DivineJiClgConfig
