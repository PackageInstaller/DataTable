-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/config/DivineKingNuoYaConfig.lua

module("logic.extensions.divinekingnuoya.config.DivineKingNuoYaConfig", package.seeall)

local DivineKingNuoYaConfig = class("DivineKingNuoYaConfig", BaseConfig)

function DivineKingNuoYaConfig:onInit()
	return
end

function DivineKingNuoYaConfig:getNames()
	return {
		"divine_king_noah_clg_activity",
		"divine_king_noah_clg_activity_plan",
		"divine_king_noah_clg_stage",
		"divine_king_noah_clg_creeps_master",
		"divine_king_noah_clg_creeps",
		"divine_king_noah_clg_buff",
		"divine_king_noah_clg_progress_prize"
	}
end

function DivineKingNuoYaConfig:handleConfig(name, content)
	if name == "divine_king_noah_clg_activity" then
		self._divine_king_noah_clg_activity = content
	elseif name == "divine_king_noah_clg_activity_plan" then
		self._divine_king_noah_clg_activity_plan = content
	elseif name == "divine_king_noah_clg_stage" then
		self._divine_king_noah_clg_stage = content
	elseif name == "divine_king_noah_clg_creeps_master" then
		self._divine_king_noah_clg_creeps_master = content
	elseif name == "divine_king_noah_clg_creeps" then
		self._divine_king_noah_clg_creeps = content
	elseif name == "divine_king_noah_clg_buff" then
		self._divine_king_noah_clg_buff = content
	elseif name == "divine_king_noah_clg_progress_prize" then
		self._divine_king_noah_clg_progress_prize = content
	end
end

function DivineKingNuoYaConfig:getActCfg(activityId)
	return self._divine_king_noah_clg_activity[activityId]
end

function DivineKingNuoYaConfig:getActPlanCfg(actPlanId)
	return self._divine_king_noah_clg_activity_plan[actPlanId]
end

function DivineKingNuoYaConfig:getStageCfg(stagePlanId, stageId)
	if self._divine_king_noah_clg_stage[stagePlanId] then
		return self._divine_king_noah_clg_stage[stagePlanId][stageId]
	end
end

function DivineKingNuoYaConfig:getStageCfgs(stagePlanId)
	if self._divine_king_noah_clg_stage[stagePlanId] then
		return self._divine_king_noah_clg_stage[stagePlanId]
	end
end

function DivineKingNuoYaConfig:getMasterCfg(masterId)
	return self._divine_king_noah_clg_creeps_master[masterId]
end

function DivineKingNuoYaConfig:getCreepCfg(masterId)
	return self._divine_king_noah_clg_creeps[masterId]
end

function DivineKingNuoYaConfig:getBuffCfg(buffPlanId)
	return self._divine_king_noah_clg_buff[buffPlanId]
end

function DivineKingNuoYaConfig:getPrizeCfg(prizePlanId)
	return self._divine_king_noah_clg_progress_prize[prizePlanId]
end

function DivineKingNuoYaConfig:getSkinId(activityId)
	return self._divine_king_noah_clg_activity[activityId] and self._divine_king_noah_clg_activity[activityId].skinId
end

function DivineKingNuoYaConfig:getCreepsMasterId(activityId, stageId)
	local actPlanId = self._divine_king_noah_clg_activity[activityId].activityPlanId
	local planCfg = self._divine_king_noah_clg_activity_plan[actPlanId]
	local stagePlanId = planCfg and planCfg.stagePlanId

	if checknumber(stagePlanId) > 0 then
		local stageCfg = self:getStageCfg(stagePlanId, stageId)

		return stageCfg and stageCfg.creepsMasterId
	end
end

DivineKingNuoYaConfig.instance = DivineKingNuoYaConfig.New()

return DivineKingNuoYaConfig
