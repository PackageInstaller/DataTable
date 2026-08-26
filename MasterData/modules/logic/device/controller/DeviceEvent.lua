-- chunkname: @modules/logic/device/controller/DeviceEvent.lua

module("modules.logic.device.controller.DeviceEvent", package.seeall)

local DeviceEvent = _M
local _get = GameUtil.getUniqueTb()

DeviceEvent.OnBatteryValueChange = _get()
DeviceEvent.OnBatteryStatusChange = _get()
DeviceEvent.OnNetworkTypeChange = _get()

return DeviceEvent
