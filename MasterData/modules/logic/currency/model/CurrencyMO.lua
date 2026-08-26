-- chunkname: @modules/logic/currency/model/CurrencyMO.lua

module("modules.logic.currency.model.CurrencyMO", package.seeall)

local CurrencyMO = pureTable("CurrencyMO")

function CurrencyMO:ctor()
	self.currencyId = 0
	self.quantity = 0
	self.lastRecoverTime = 0
	self.expiredTime = 0
end

function CurrencyMO:init(info)
	self.currencyId = info.currencyId
	self.quantity = info.quantity
	self.lastRecoverTime = info.lastRecoverTime
	self.expiredTime = info.expiredTime
end

return CurrencyMO
