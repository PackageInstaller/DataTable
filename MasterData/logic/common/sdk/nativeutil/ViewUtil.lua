-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/ViewUtil.lua

module("logic.common.sdk.nativeutil.ViewUtil", package.seeall)

local ViewUtil = {}
local clazz = "com.baitian.wrap.ViewUtilWrap"

function ViewUtil.forceDecorViewRequestLayout()
	return NativeBridge.instance:invoke(clazz, "forceDecorViewRequestLayout")
end

function ViewUtil.getSafeArea()
	local safeAreaJson = NativeBridge.instance:invokeString(clazz, "getSafeArea")

	return json.decode(safeJson)
end

function ViewUtil.setLayoutParam(width, height)
	local param = {}

	param.width = width
	param.height = height

	NativeBridge.instance:invoke(clazz, "setLayoutParam", param)
end

return ViewUtil
