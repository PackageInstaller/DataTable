-- chunkname: @modules/logic/currencyexchange/model/CurrencyExchangeMo.lua

module("modules.logic.currencyexchange.model.CurrencyExchangeMo", package.seeall)

local CurrencyExchangeMo = pureTable("CurrencyExchangeMo")

function CurrencyExchangeMo:init(infoMo)
	self.currencyId = infoMo.currencyId
	self.quantity = infoMo.quantity
	self.isProp = infoMo.isPoped
end

function CurrencyExchangeMo:isProped()
	return self.isProp ~= CurrencyExchangeEnum.PropState.NoProp
end

return CurrencyExchangeMo
