-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/ScreenUtil.lua

module("logiccommon.common.sdk.ScreenUtil", package.seeall)

local ScreenUtil = {}
local clazz = "com.baitian.wrap.ScreenUtilWrap"

function ScreenUtil.getScreenBrightness()
	return NativeBridge.instance:invokeInt(clazz, "getScreenBrightness")
end

function ScreenUtil.setScreenBrightness(brightness)
	local param = {}

	param.brightness = brightness

	NativeBridge.instance:invoke(clazz, "setScreenBrightness", param)
end

return ScreenUtil
