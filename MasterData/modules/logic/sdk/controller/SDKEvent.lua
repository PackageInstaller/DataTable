-- chunkname: @modules/logic/sdk/controller/SDKEvent.lua

module("modules.logic.sdk.controller.SDKEvent", package.seeall)

local SDKEvent = _M

SDKEvent.BasePropertiesChange = 1
SDKEvent.GuestBindSucc = 2
SDKEvent.UpdateAccountBindBonus = 3

return SDKEvent
