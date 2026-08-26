-- chunkname: @modules/logic/currencyexchange/controller/CurrencyExchangeEvent.lua

module("modules.logic.currencyexchange.controller.CurrencyExchangeEvent", package.seeall)

local CurrencyExchangeEvent = _M
local _get = GameUtil.getUniqueTb()

CurrencyExchangeEvent.onSubViewClickClose = _get()
CurrencyExchangeEvent.onGetInfo = _get()
CurrencyExchangeEvent.onInfoChange = _get()

return CurrencyExchangeEvent
