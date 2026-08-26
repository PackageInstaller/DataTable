-- chunkname: @modules/logic/pay/controller/PayEvent.lua

module("modules.logic.pay.controller.PayEvent", package.seeall)

local PayEvent = _M

PayEvent.GetSignFailed = 1
PayEvent.GetSignSuccess = 2
PayEvent.PayFinished = 11
PayEvent.PayFailed = 12
PayEvent.PayInfoChanged = 13

return PayEvent
