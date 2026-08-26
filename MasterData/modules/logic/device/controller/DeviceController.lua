-- chunkname: @modules/logic/device/controller/DeviceController.lua

module("modules.logic.device.controller.DeviceController", package.seeall)

local DeviceController = class("DeviceController", BaseController)

function DeviceController:onInit()
	local deviceInfo = SDKMgr.instance:getInitDeviceInfo(true)

	if deviceInfo then
		self:onBatteryValueChange(deviceInfo.batteryValue)
		self:onBatteryStatusChange(deviceInfo.batteryStatus)
		self:onNetworkTypeChange(deviceInfo.networkType)
	end

	self._isInit = true
end

function DeviceController:onInitFinish()
	return
end

function DeviceController:addConstEvents()
	MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, self._onFirstEnterMain, self)
end

function DeviceController:reInit()
	return
end

function DeviceController:_onFirstEnterMain()
	local isReview = VersionValidator.instance:isInReviewing()

	if isReview or SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	local isEmulator = SDKMgr.instance:isEmulator()

	if isEmulator then
		local deviceInfo = SDKMgr.instance:getDeviceInfo()
		local osVersion = deviceInfo and deviceInfo.osVersion

		if osVersion and tonumber(osVersion) == 9 then
			logNormal("DeviceController._onFirstEnterMain return")

			return
		end
	end

	SDKMgr.instance:requestLocationPermission()
end

function DeviceController:onBatteryValueChange(value)
	value = value and tonumber(value)

	DeviceModel.instance:setBatteryValue(value)

	if self._isInit then
		self:dispatchEvent(DeviceEvent.OnBatteryValueChange)
	end
end

function DeviceController:onBatteryStatusChange(status)
	status = status and tonumber(status)

	DeviceModel.instance:setBatteryStatus(status)

	if self._isInit then
		self:dispatchEvent(DeviceEvent.OnBatteryStatusChange)
	end
end

function DeviceController:onNetworkTypeChange(networkType)
	networkType = networkType and tonumber(networkType)

	DeviceModel.instance:setNetworkType(networkType)

	if self._isInit then
		self:dispatchEvent(DeviceEvent.OnNetworkTypeChange)
	end
end

function DeviceController:getDeviceLocation()
	local isReview = VersionValidator.instance:isInReviewing()

	if isReview then
		return
	end

	local isEmulator = SDKMgr.instance:isEmulator()

	if isEmulator then
		local deviceInfo = SDKMgr.instance:getDeviceInfo()
		local osVersion = deviceInfo and deviceInfo.osVersion

		if osVersion and tonumber(osVersion) == 9 then
			logNormal("DeviceController.getDeviceLocation return")

			return
		end
	end

	local lat, lon
	local result = SDKMgr.instance:getCurrentLocation()

	if not string.nilorempty(result) then
		lat, lon = string.match(result, "latitude:([%-%d%.]+),longitude:([%-%d%.]+)")
	end

	lat = tonumber(lat)
	lon = tonumber(lon)

	return lat, lon
end

DeviceController.instance = DeviceController.New()

return DeviceController
