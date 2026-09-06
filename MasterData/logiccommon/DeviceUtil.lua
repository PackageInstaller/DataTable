-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/DeviceUtil.lua

module("logiccommon.common.sdk.DeviceUtil", package.seeall)

local DeviceUtil = {}
local clazz = "com.baitian.wrap.DeviceUtilWrap"

function DeviceUtil.isEmulator()
	return NativeBridge.instance:invokeBool(clazz, "isEmulator")
end

function DeviceUtil.getTemperature()
	return NativeBridge.instance:invokeInt(clazz, "getTemperature")
end

function DeviceUtil.getTemperatureState()
	local retJson = NativeBridge.instance:invokeString(clazz, "getTemperatureState")

	return json.decode(retJson)
end

function DeviceUtil.checkHeadphoneState()
	return NativeBridge.instance:invokeInt(clazz, "checkHeadphoneState")
end

function DeviceUtil.getCpuCoresNumber()
	return NativeBridge.instance:invokeInt(clazz, "getCpuCoresNumber")
end

function DeviceUtil.getCpuCurFreq(cpuIndex)
	local param = {}

	param.cpuIndex = cpuIndex

	return NativeBridge.instance:invokeString(clazz, "getCpuCurFreq", param)
end

function DeviceUtil.getCpuScalingAvailableFrequencies(cpuIndex)
	local param = {}

	param.cpuIndex = cpuIndex

	return NativeBridge.instance:invokeString(clazz, "getCpuScalingAvailableFrequencies", param)
end

function DeviceUtil.getCpuIndexOnlineStatus(cpuIndex)
	local param = {}

	param.cpuIndex = cpuIndex

	return NativeBridge.instance:invokeString(clazz, "getCpuIndexOnlineStatus", param)
end

function DeviceUtil.getCpuOnlineStatus()
	return NativeBridge.instance:invokeString(clazz, "getCpuOnlineStatus")
end

function DeviceUtil.getAndroidSdkVersion()
	return NativeBridge.instance:invokeInt(clazz, "getAndroidSdkVersion")
end

return DeviceUtil
