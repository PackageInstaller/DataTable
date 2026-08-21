-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/MemoryUtil.lua

module("logic.common.sdk.nativeutil.MemoryUtil", package.seeall)

local MemoryUtil = {}
local clazz = "com.baitian.wrap.MemoryUtilWrap"

function MemoryUtil.getMemoryInfo()
	return json.decode(NativeBridge.instance:invokeString(clazz, "getMemoryInfo"))
end

function MemoryUtil.getDebugMemoryStats()
	return NativeBridge.instance:invoke(clazz, "getDebugMemoryStats")
end

function MemoryUtil.getDebugPss()
	return NativeBridge.instance:invokeInt(clazz, "getDebugPss")
end

return MemoryUtil
