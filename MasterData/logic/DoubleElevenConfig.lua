-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/config/DoubleElevenConfig.lua

module("logic.extensions.doubleeleven.config.DoubleElevenConfig", package.seeall)

local DoubleElevenConfig = class("DoubleElevenConfig", BaseConfig)

function DoubleElevenConfig:onInit()
	DoubleElevenConfig.super.onInit(self)

	self._tabBaseCfgs = nil
	self._rechargeBaseCfgs = nil
	self._rechargeCommonCfgs = nil
	self._seckillBaseCfgs = nil
	self._seckillPlanCfgs = nil
	self._freeBaseCfgs = nil
	self._freePlanCfgs = nil
	self._dayRechargeCfgs = nil
end

function DoubleElevenConfig:getNames()
	return {
		"double_eleven",
		"days_recharge",
		"days_recharge_common",
		"second_sale_activity_plan",
		"second_sale_plan_item",
		"free_pay_store_activity",
		"free_pay_store_item",
		"rebate_mall_activity",
		"rebate_mall_item",
		"rebate_mall_prize"
	}
end

function DoubleElevenConfig:handleConfig(name, content)
	if name == "double_eleven" then
		self._tabBaseCfgs = content
	elseif name == "days_recharge" then
		self:_setDaysRechargeCfgs(content.dataList)

		self._dayRechargeCfgs = content
	elseif name == "days_recharge_common" then
		self._rechargeCommonCfgs = content
	elseif name == "second_sale_activity_plan" then
		self._seckillBaseCfgs = content
	elseif name == "second_sale_plan_item" then
		self._seckillPlanCfgs = content
	elseif name == "free_pay_store_activity" then
		self._freeBaseCfgs = content
	elseif name == "free_pay_store_item" then
		self._freePlanCfgs = content
	elseif name == "rebate_mall_activity" then
		self._rebatemallCfgs = content
	elseif name == "rebate_mall_item" then
		self._rebateItemCfgs = content
	elseif name == "rebate_mall_prize" then
		self._rebatePrizeCfgs = content
	end
end

function DoubleElevenConfig:getAllDoubleElevenTabCfgs()
	return self._tabBaseCfgs or {}
end

function DoubleElevenConfig:getDoubleElevenTabCfgByTabId(tabId)
	if tabId == nil or self._tabBaseCfgs == nil then
		return nil
	end

	return self._tabBaseCfgs[tabId]
end

function DoubleElevenConfig:_getActivityIdByActivityType(acType)
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(acType)

	if cfgs == nil then
		return 0
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -1
end

function DoubleElevenConfig:_setDaysRechargeCfgs(data)
	self._rechargeBaseCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and cfg.itemId then
			self._rechargeBaseCfgs[cfg.activityId] = self._rechargeBaseCfgs[cfg.activityId] or {}
			self._rechargeBaseCfgs[cfg.activityId][cfg.money] = self._rechargeBaseCfgs[cfg.activityId][cfg.money] or {}

			table.insert(self._rechargeBaseCfgs[cfg.activityId][cfg.money], cfg)
		end
	end

	for _, myList in pairs(self._rechargeBaseCfgs) do
		for id, list in pairs(myList or {}) do
			if list and #list > 1 then
				table.sort(list, function(a, b)
					return a.rechargeDays < b.rechargeDays
				end)
			end
		end
	end
end

function DoubleElevenConfig:getDaysRechargeActivityId()
	return DoubleElevenModel.instance:getActId()
end

function DoubleElevenConfig:getDaysRechargeAllCfgs(actId)
	local actId = self:getDaysRechargeActivityId()

	if checknumber(actId) <= 0 then
		return nil
	end

	if self._rechargeBaseCfgs == nil or self._rechargeBaseCfgs[actId] == nil then
		return nil
	end

	return self._rechargeBaseCfgs[actId]
end

function DoubleElevenConfig:getDaysRechargeMoneyCfgs(money)
	local list = self:getDaysRechargeAllCfgs()

	if list == nil or list[money] == nil then
		return {}
	end

	return list[money]
end

function DoubleElevenConfig:getDayRechargeCfg()
	local actId = self:getDaysRechargeActivityId()
	local cfg = self._dayRechargeCfgs[actId]

	table.sort(cfg, function(a, b)
		return a.rechargeDays < b.rechargeDays
	end)

	local newCfg = {}

	for i = 1, #cfg - 1 do
		table.insert(newCfg, cfg[i])
	end

	return newCfg
end

function DoubleElevenConfig:getLastestRechargeCfg()
	local actId = self:getDaysRechargeActivityId()
	local cfg = self._dayRechargeCfgs[actId]

	return cfg[#cfg]
end

function DoubleElevenConfig:getSeckillZoneActivityId()
	return self:_getActivityIdByActivityType(GameEnum.ActivityType.SeckillZone)
end

function DoubleElevenConfig:getSeckillZoneTabCfgs()
	local actId = self:getSeckillZoneActivityId()

	if checknumber(actId) <= 0 then
		return nil
	end

	if self._seckillBaseCfgs == nil or self._seckillBaseCfgs[actId] == nil then
		return nil
	end

	return self._seckillBaseCfgs[actId]
end

function DoubleElevenConfig:getSeckillZonePlanCfgs(planId)
	if planId == nil or self._seckillPlanCfgs == nil or self._seckillPlanCfgs[planId] == nil then
		return nil
	end

	return self._seckillPlanCfgs[planId]
end

function DoubleElevenConfig:getFreeZoneActivityId()
	return self:_getActivityIdByActivityType(GameEnum.ActivityType.FreeZone)
end

function DoubleElevenConfig:getFreeZoneBaseCfgs()
	local actId = self:getFreeZoneActivityId()

	if checknumber(actId) <= 0 then
		return nil
	end

	if self._freeBaseCfgs == nil or self._freeBaseCfgs[actId] == nil then
		return nil
	end

	return self._freeBaseCfgs[actId]
end

function DoubleElevenConfig:getFreeZonePlanCfgs(planId)
	if planId == nil or self._freePlanCfgs == nil or self._freePlanCfgs[planId] == nil then
		return nil
	end

	return self._freePlanCfgs[planId]
end

function DoubleElevenConfig:getFreeZoneItemCfg(planId, itemId)
	if planId == nil or self._freePlanCfgs == nil or self._freePlanCfgs[planId] == nil then
		return nil
	end

	return self._freePlanCfgs[planId][itemId]
end

function DoubleElevenConfig:getDaysRechargeCommonValue(key, need2number)
	if need2number then
		return checknumber(self._rechargeCommonCfgs[key].value)
	end

	return self._rechargeCommonCfgs[key].value
end

function DoubleElevenConfig:getRebateMallActCfgs(activityId)
	return self._rebatemallCfgs[activityId]
end

function DoubleElevenConfig:getRebateItemCfgs(activityId)
	return self._rebateItemCfgs[activityId]
end

function DoubleElevenConfig:getRebatePrizeCfgs(activityId)
	return self._rebatePrizeCfgs[activityId]
end

DoubleElevenConfig.instance = DoubleElevenConfig.New()

return DoubleElevenConfig
