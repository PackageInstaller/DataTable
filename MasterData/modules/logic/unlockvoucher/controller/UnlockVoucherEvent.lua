-- chunkname: @modules/logic/unlockvoucher/controller/UnlockVoucherEvent.lua

module("modules.logic.unlockvoucher.controller.UnlockVoucherEvent", package.seeall)

local UnlockVoucherEvent = _M
local _get = GameUtil.getUniqueTb()

UnlockVoucherEvent.OnUpdateUnlockVoucherInfo = _get()

return UnlockVoucherEvent
