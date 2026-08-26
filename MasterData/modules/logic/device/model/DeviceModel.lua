-- chunkname: @modules/logic/device/model/DeviceModel.lua

module("modules.logic.device.model.DeviceModel", package.seeall)

local DeviceModel = class("DeviceModel", BaseModel)

function DeviceModel:onInit()
	return
end

function DeviceModel:reInit()
	return
end

function DeviceModel:setBatteryValue(value)
	self._batteryValue = value
end

function DeviceModel:setBatteryStatus(status)
	self._batteryStatus = status
end

function DeviceModel:setNetworkType(networkType)
	self._networkType = networkType
end

function DeviceModel:getBatteryValue()
	return self._batteryValue
end

function DeviceModel:getBatteryStatus()
	return self._batteryStatus
end

function DeviceModel:getNetworkType()
	return self._networkType
end

DeviceModel.instance = DeviceModel.New()

return DeviceModel
