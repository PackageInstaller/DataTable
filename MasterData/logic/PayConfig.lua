-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pay/config/PayConfig.lua

module("logic.extensions.pay.config.PayConfig", package.seeall)

local PayConfig = class("PayConfig", BaseConfig)

function PayConfig:onInit()
	PayConfig.super.onInit(self)

	self.pay_goods = nil
end

function PayConfig:getNames()
	return {
		"pay_goods"
	}
end

function PayConfig:handleConfig(name, content)
	if name == "pay_goods" then
		self.pay_goods = content
	end
end

function PayConfig:getPayGoodsCfg(id)
	id = tostring(id)

	return self.pay_goods[id]
end

function PayConfig:getPayMoney(id)
	local cfg = self:getPayGoodsCfg(id)

	return cfg.payMoney
end

function PayConfig:getPayMoneyYuan(id)
	local cfg = self:getPayGoodsCfg(id)

	if cfg == nil then
		return 0
	else
		return cfg.payMoney / 100
	end
end

PayConfig.instance = PayConfig.New()

return PayConfig
