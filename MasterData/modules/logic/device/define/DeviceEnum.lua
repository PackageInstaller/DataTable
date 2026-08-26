-- chunkname: @modules/logic/device/define/DeviceEnum.lua

module("modules.logic.device.define.DeviceEnum", package.seeall)

local DeviceEnum = _M

DeviceEnum.Const = {
	MaxBatteryValue = 100
}
DeviceEnum.NetWorkType = {
	Wifi = 2,
	Other = 999,
	Mobile = 1,
	None = -1
}
DeviceEnum.BatteryStatus = {
	Charge = 1,
	Normal = 0
}

return DeviceEnum
