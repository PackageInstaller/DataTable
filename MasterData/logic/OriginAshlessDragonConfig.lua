-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/config/OriginAshlessDragonConfig.lua

module("logic.extensions.originashlessdragon.config.OriginAshlessDragonConfig", package.seeall)

local OriginAshlessDragonConfig = class("OriginAshlessDragonConfig", BaseConfig)

function OriginAshlessDragonConfig:getNames()
	return {
		"origin_ashless_dragon_activity",
		"origin_ashless_dragon_balance_plan",
		"origin_ashless_dragon_budget_plan",
		"origin_ashless_dragon_creeps",
		"origin_ashless_dragon_debuff",
		"origin_ashless_dragon_monster",
		"origin_ashless_dragon_phase",
		"origin_ashless_dragon_stage"
	}
end

function OriginAshlessDragonConfig:handleConfig(name, content)
	if name == "origin_ashless_dragon_activity" then
		self._origin_ashless_dragon_activity = content
	elseif name == "origin_ashless_dragon_balance_plan" then
		self._origin_ashless_dragon_balance_plan = content
	elseif name == "origin_ashless_dragon_budget_plan" then
		self._origin_ashless_dragon_budget_plan = content
	elseif name == "origin_ashless_dragon_creeps" then
		self._origin_ashless_dragon_creeps = content
	elseif name == "origin_ashless_dragon_debuff" then
		self._origin_ashless_dragon_debuff = content
	elseif name == "origin_ashless_dragon_monster" then
		self._origin_ashless_dragon_monster = content
	elseif name == "origin_ashless_dragon_phase" then
		self._origin_ashless_dragon_phase = content
	elseif name == "origin_ashless_dragon_stage" then
		self._origin_ashless_dragon_stage = content
	end
end

function OriginAshlessDragonConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function OriginAshlessDragonConfig:getActivityData(activityId)
	return self:_safeGet(self._origin_ashless_dragon_activity, activityId)
end

function OriginAshlessDragonConfig:getBalancePlanData(balancePlanId)
	return self:_safeGet(self._origin_ashless_dragon_balance_plan, balancePlanId)
end

function OriginAshlessDragonConfig:getBudgetPlanData(activityId, phaseId)
	local phaseData = self:getPhaseData(activityId, phaseId)

	if phaseData then
		if not phaseData.budgetPlanId then
			local budgetPlanId = 0

			return self:_safeGet(self._origin_ashless_dragon_budget_plan, budgetPlanId)
		end
	end
end

function OriginAshlessDragonConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_ashless_dragon_creeps, creepsMasterId)
end

function OriginAshlessDragonConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._origin_ashless_dragon_creeps, creepsMasterId, creepsId)
end

function OriginAshlessDragonConfig:getDebuffDatas(activityId)
	return self:_safeGet(self._origin_ashless_dragon_debuff, activityId)
end

function OriginAshlessDragonConfig:getDebuffDataByRisk(activityId, risk)
	local datas = self:getDebuffDatas(activityId)

	return MmUtil.unorderedSearchInSingleKey(datas, "risk", risk)
end

function OriginAshlessDragonConfig:getMonsterData(creepsMasterId)
	return self:_safeGet(self._origin_ashless_dragon_monster, creepsMasterId)
end

function OriginAshlessDragonConfig:getPhaseDatas(activityId)
	return self:_safeGet(self._origin_ashless_dragon_phase, activityId)
end

function OriginAshlessDragonConfig:getPhaseData(activityId, phaseId)
	return self:_safeGet(self._origin_ashless_dragon_phase, activityId, phaseId)
end

function OriginAshlessDragonConfig:getStageDatass(activityId)
	return self:_safeGet(self._origin_ashless_dragon_stage, activityId)
end

function OriginAshlessDragonConfig:getStageDatas(activityId, phaseId)
	return self:_safeGet(self._origin_ashless_dragon_stage, activityId, phaseId)
end

function OriginAshlessDragonConfig:getStageData(activityId, phaseId, stageId)
	return self:_safeGet(self._origin_ashless_dragon_stage, activityId, phaseId, stageId)
end

OriginAshlessDragonConfig.instance = OriginAshlessDragonConfig.New()

return OriginAshlessDragonConfig
