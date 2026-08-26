-- chunkname: @modules/logic/currencyexchange/define/CurrencyExchangeEnum.lua

module("modules.logic.currencyexchange.define.CurrencyExchangeEnum", package.seeall)

local CurrencyExchangeEnum = _M

CurrencyExchangeEnum.PropState = {
	Proped = 1,
	NoProp = 0
}

return CurrencyExchangeEnum
