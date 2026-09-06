-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/discountaccruingpay/config/DiscountaccruingpayConfig.lua

module("logic.extensions.discountaccruingpay.config.DiscountaccruingpayConfig", package.seeall)

local DiscountaccruingpayConfig = class("DiscountaccruingpayConfig", BaseConfig)

function DiscountaccruingpayConfig:onInit()
	return
end

function DiscountaccruingpayConfig:getNames()
	return {
		"discount_accruing_pay_config",
		"discount_accruing_pay_gift",
		"discount_accruing_pay_times"
	}
end

function DiscountaccruingpayConfig:handleConfig(name, content)
	if name == "discount_accruing_pay_config" then
		self._discount_accruing_pay_configCfg = content
	elseif name == "discount_accruing_pay_gift" then
		self._discount_accruing_pay_giftCfg = content
	elseif name == "discount_accruing_pay_times" then
		self._discount_accruing_pay_timesCfg = content
	end
end

function DiscountaccruingpayConfig:getActCfg(actId)
	return self._discount_accruing_pay_configCfg[actId]
end

function DiscountaccruingpayConfig:getPlanCfgs(giftPlanId)
	return self._discount_accruing_pay_giftCfg[giftPlanId]
end

function DiscountaccruingpayConfig:getPayPlanCfgs(payPlanId)
	return self._discount_accruing_pay_timesCfg[payPlanId]
end

DiscountaccruingpayConfig.instance = DiscountaccruingpayConfig.New()

return DiscountaccruingpayConfig
