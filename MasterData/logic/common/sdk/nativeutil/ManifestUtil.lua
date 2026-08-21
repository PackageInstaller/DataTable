-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/ManifestUtil.lua

module("logic.common.sdk.nativeutil.ManifestUtil", package.seeall)

local ManifestUtil = {}
local clazz = "com.baitian.unity.ManifestUtilWrap"

function ManifestUtil.getIntMetaData(key)
	local param = {}

	param.key = key

	return NativeBridge.instance:invokeInt(clazz, "getIntMetaData", param)
end

function ManifestUtil.getBooleanMetaData(key)
	local param = {}

	param.key = key

	return NativeBridge.instance:invokeBool(clazz, "getBooleanMetaData", param)
end

function ManifestUtil.getStringMetaData(key)
	local param = {}

	param.key = key

	return NativeBridge.instance:invokeString(clazz, "getStringMetaData", param)
end

return ManifestUtil
