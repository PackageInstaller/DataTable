-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/config/InfinitefutureConfig.lua

module("logic.extensions.infinitefuture.config.InfinitefutureConfig", package.seeall)

local InfinitefutureConfig = class("InfinitefutureConfig", BaseConfig)

function InfinitefutureConfig:onInit()
	InfinitefutureConfig.super.onInit(self)
end

function InfinitefutureConfig:getNames()
	return {
		"infinite_future_activity",
		"infinite_future_stage",
		"infinite_future_stage_team",
		"infinite_future_team",
		"infinite_future_creeps",
		"infinite_future_buff",
		"infinite_future_buff_select",
		"infinite_future_currency",
		"infinite_future_helper_pet"
	}
end

function InfinitefutureConfig:handleConfig(name, content)
	if name == "infinite_future_activity" then
		self._planCfg = content
	elseif name == "infinite_future_stage" then
		self._stageCfg = content
	elseif name == "infinite_future_stage_team" then
		self._teamCfg = content
	elseif name == "infinite_future_buff" then
		self._signCfg = content
	elseif name == "infinite_future_team" then
		self._teamCreepCfg = content
	elseif name == "infinite_future_creeps" then
		self._creepCfg = content
	elseif name == "infinite_future_buff_select" then
		self._buffSelectCfg = content
	elseif name == "infinite_future_currency" then
		self._commonCfg = content
	elseif name == "infinite_future_helper_pet" then
		self._helperPetCfg = content
	end
end

function InfinitefutureConfig:getCommonCfg(key)
	return self._commonCfg[key].value
end

function InfinitefutureConfig:getPlanCfg(actid)
	return self._planCfg[actid]
end

function InfinitefutureConfig:getStageCfgs(actid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return self._stageCfg[planid]
end

function InfinitefutureConfig:getStageCfg(actid, stageid)
	local planid = self:getPlanCfg(actid).challengePlanId

	if self._stageCfg[planid] then
		return self._stageCfg[planid][stageid]
	end
end

function InfinitefutureConfig:getStageCount(actid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return #self._stageCfg[planid]
end

function InfinitefutureConfig:getStagePassCount(actid, stageid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return self._stageCfg[planid][stageid].passCount
end

function InfinitefutureConfig:getTeamCfgs(actid, sid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return self._teamCfg[planid][sid]
end

function InfinitefutureConfig:getCreepCfgs(creepId)
	return self._creepCfg[creepId]
end

function InfinitefutureConfig:getTeamCfg(masterId)
	return self._teamCreepCfg[masterId]
end

function InfinitefutureConfig:getSignCfgs(actid)
	local planid = self:getPlanCfg(actid).buffPlanId

	return self._signCfg[planid]
end

function InfinitefutureConfig:getSelectBuffCfg(actid, id)
	local planid = self:getPlanCfg(actid).buffSelectPlanId

	if id then
		return self._buffSelectCfg[planid][id]
	end

	return self._buffSelectCfg[planid]
end

function InfinitefutureConfig:getOpenBuffCfgs(actid, curId)
	local planid = self:getPlanCfg(actid).buffSelectPlanId
	local tab = {}

	for i, v in ipairs(self._buffSelectCfg[planid]) do
		if curId >= v.stageId then
			table.insert(tab, 1, v)
		end
	end

	return tab
end

function InfinitefutureConfig:getHelperPet(planId)
	return self._helperPetCfg[planId]
end

function InfinitefutureConfig:getExcludePublicStrengthens(id)
	local planid = self:getPlanCfg(id)

	if planid then
		return planid.excludePublicStrengthens
	end

	return false
end

InfinitefutureConfig.instance = InfinitefutureConfig.New()

return InfinitefutureConfig
