-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/controller/OriginpsychicjiController.lua

module("logic.extensions.originpsychicji.controller.OriginpsychicjiController", package.seeall)

local OriginpsychicjiController = class("OriginpsychicjiController", BaseController)

OriginpsychicjiController.ClgType = {
	Extreme = 2,
	Normal = 1
}

function OriginpsychicjiController:ctor()
	return
end

function OriginpsychicjiController:onInit()
	self:onReset()
end

function OriginpsychicjiController:onReset()
	self._extResultMsg = nil
	self._cacheCI = 0
	self._lastStageId = 0
end

function OriginpsychicjiController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(269)
end

function OriginpsychicjiController:onNotifyExtClgRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		if not msg.isWin then
			return false
		end

		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginpsychicjiextresultView, msg, OriginpsychicjiController.ClgType.Extreme)

		return true
	end)
end

function OriginpsychicjiController:onNotifyCommonClgRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		if not msg.isWin then
			return false
		end

		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginpsychicjiextresultView, msg, OriginpsychicjiController.ClgType.Normal)

		return true
	end)
end

function OriginpsychicjiController:getEnergySettleRuleDesc(activityId, clgType, stageId)
	local stageCfg
	local list = {}

	for i, planId in ipairs((clgType == OriginpsychicjiController.ClgType.Normal and OriginpsychicjiConfig.instance:getNormalStageCfg(activityId, stageId) or OriginpsychicjiConfig.instance:getExtStageCfg(activityId, stageId)).settlePlan) do
		local cfgs = OriginpsychicjiConfig.instance:getSettlePlanCfgs(activityId, planId)
		local newCfgs = {}

		for i, v in pairs(cfgs) do
			table.insert(newCfgs, v)
		end

		table.sort(newCfgs, function(a, b)
			return a.energy < b.energy
		end)

		for _, cfg in ipairs(newCfgs) do
			if cfg.settleType == "ActiveCount" then
				table.insert(list, string.format("存活%s-%s只精灵，能量值+%s", cfg.num[1], cfg.num[2], cfg.energy))
			elseif cfg.settleType == "CircleCount" then
				table.insert(list, string.format("每%s-%s回合结束，能量值+%s", cfg.num[1], cfg.num[2], cfg.energy))
			elseif cfg.settleType == "UltimateCount" then
				table.insert(list, string.format("超杀次数%s-%s，能量值+%s", cfg.num[1], cfg.num[2], cfg.energy))
			end
		end
	end

	local str = table.concat(list, "、")

	return string.format("本关能量规则：%s", str)
end

function OriginpsychicjiController:getEnergySettleNameDesc(activityId, settlePlanId)
	local cfgs = OriginpsychicjiConfig.instance:getSettlePlanCfgs(activityId, settlePlanId)

	for k, cfg in pairs(cfgs) do
		if cfg.settleType == "ActiveCount" then
			return "存活数："
		elseif cfg.settleType == "CircleCount" then
			return "回合数："
		elseif cfg.settleType == "UltimateCount" then
			return "超杀数："
		end
	end
end

function OriginpsychicjiController:saveExtResultMsg(msg)
	self._extResultMsg = msg
end

function OriginpsychicjiController:onSaveRes(msg)
	local resultMsg = self._extResultMsg

	self._extResultMsg = nil

	if resultMsg and msg.isSave then
		OriginpsychicjiModel.instance:onSaveRes(msg.activityId, resultMsg.stageId, resultMsg.typeToEnergy)

		if msg.changeSetId > 0 then
			OriginpsychicjiModel.instance:onExtClgFinish(msg.activityId)
		end
	end

	if msg.changeSetId > 0 then
		self._cacheCI = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._cacheCI)
	end
end

function OriginpsychicjiController:tryShowCI()
	local ci = self._cacheCI

	self._cacheCI = 0

	if ci and ci > 0 then
		MaterialController.instance:showChangeSetInTemp(ci)
	end
end

function OriginpsychicjiController:setLastSelectStageId(stageId)
	self._lastStageId = stageId
end

function OriginpsychicjiController:getLastSelectStageId()
	return self._lastStageId
end

function OriginpsychicjiController:getEnergyValue(activityId, typeToEnergy)
	if not typeToEnergy then
		return 0
	end

	local value = 0

	for i, v in ipairs(typeToEnergy) do
		local curValue = OriginpsychicjiConfig.instance:getSettleEnergyByNum(activityId, v.left, v.right)

		if curValue > 0 then
			value = value + curValue
		end
	end

	return value
end

OriginpsychicjiController.instance = OriginpsychicjiController.New()

return OriginpsychicjiController
