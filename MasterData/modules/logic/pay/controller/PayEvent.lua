-- chunkname: @modules/logic/pay/controller/PayEvent.lua

module("modules.logic.pay.controller.PayEvent", package.seeall)

local PayEvent = _M
local make = GameUtil.getUniqueTb()

PayEvent.GetSignFailed = make()
PayEvent.GetSignSuccess = make()
PayEvent.PayFinished = make()
PayEvent.PayFailed = make()
PayEvent.PayInfoChanged = make()
PayEvent.onReceiveGetPayDiamondInfoReply = make()

return PayEvent
