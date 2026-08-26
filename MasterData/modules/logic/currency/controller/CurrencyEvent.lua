-- chunkname: @modules/logic/currency/controller/CurrencyEvent.lua

module("modules.logic.currency.controller.CurrencyEvent", package.seeall)

local CurrencyEvent = _M

CurrencyEvent.CurrencyChange = 1
CurrencyEvent.PowerBuyCountChange = 2
CurrencyEvent.GetCurrencyInfoSuccess = 3
CurrencyEvent.PowerBuyTipToggleOn = 4
CurrencyEvent.PowerBuySuccess = 5
CurrencyEvent.RefreshPowerMakerInfo = 6

return CurrencyEvent
