-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/PackageUtil.lua

module("logic.common.sdk.nativeutil.PackageUtil", package.seeall)

local PackageUtil = {}
local clazz = "com.baitian.wrap.PackageUtilWrap"

function PackageUtil.hasSysteFeature(feature)
	local param = {}

	param.feature = feature or "android.hardware.sensor.gyroscope"

	local hasFeature = NativeBridge.instance:invokeBool("com.baitian.wrap.PackageUtilWrap", "hasSystemFeature", param)

	forcePrint("hasFeature: " .. tostring(hasFeature))
end

return PackageUtil
