-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/config/PayStrengthenConfig.lua

module("logic.extensions.paystrengthen.config.PayStrengthenConfig", package.seeall)

local PayStrengthenConfig = class("PayStrengthenConfig", BaseConfig)

function PayStrengthenConfig:onInit()
	PayStrengthenConfig.super.onInit(self)

	self.pay_strengthen_permanent = nil
	self.pay_strengthen_activity = nil
	self.pay_strengthen_equipment = nil
	self.pay_strengthen_star_god_filter = nil
end

function PayStrengthenConfig:getNames()
	return {
		"pay_strengthen_permanent",
		"pay_strengthen_activity",
		"pay_strengthen_equipment",
		"pay_strengthen_star_god_filter",
		"pay_strengthen_permanent_limit",
		"pay_strengthen_price_plan",
		"pay_strengthen_red_star_god_price"
	}
end

function PayStrengthenConfig:handleConfig(name, content)
	if name == "pay_strengthen_permanent" then
		self.pay_strengthen_permanent = content
	elseif name == "pay_strengthen_activity" then
		self.pay_strengthen_activity = content
	elseif name == "pay_strengthen_equipment" then
		self.pay_strengthen_equipment = content
	elseif name == "pay_strengthen_star_god_filter" then
		self.pay_strengthen_star_god_filter = content
	elseif name == "pay_strengthen_permanent_limit" then
		self.pay_strengthen_permanent_limitCfg = content
	elseif name == "pay_strengthen_price_plan" then
		self._pay_strengthen_price_plan = content
	elseif name == "pay_strengthen_red_star_god_price" then
		self._pay_strengthen_red_star_god_price = content
	end
end

function PayStrengthenConfig:getLimitCfg(actId, type)
	if self.pay_strengthen_permanent_limitCfg[actId] then
		return self.pay_strengthen_permanent_limitCfg[actId][type]
	end

	return nil
end

function PayStrengthenConfig:getPermanentCfgById(type)
	return self.pay_strengthen_permanent[type]
end

function PayStrengthenConfig:getActivityCfg(activityId, type)
	if self.pay_strengthen_activity[activityId] then
		return self.pay_strengthen_activity[activityId][type]
	end
end

function PayStrengthenConfig:getEquipmentCfg(job, attr)
	if self.pay_strengthen_equipment[job] then
		return self.pay_strengthen_equipment[job][attr]
	end
end

function PayStrengthenConfig:getStarGodCfg(id)
	return self.pay_strengthen_star_god_filter[id]
end

function PayStrengthenConfig:getRacePCfg(id)
	id = checknumber(id)

	return self._pay_strengthen_red_star_god_price[id]
end

function PayStrengthenConfig:getPriceCfgByPlanId(id)
	return self._pay_strengthen_price_plan[id]
end

function PayStrengthenConfig:getStarGodList()
	return self.pay_strengthen_star_god_filter.dataList
end

PayStrengthenConfig.instance = PayStrengthenConfig.New()

return PayStrengthenConfig
