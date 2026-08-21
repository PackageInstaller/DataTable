-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/StorageUtil.lua

module("logic.common.sdk.nativeutil.StorageUtil", package.seeall)

local StorageUtil = {}
local clazz = "com.baitian.wrap.StorageWrap"

function StorageUtil.getAvailableInternalSize()
	return NativeBridge.instance:invokeLong(clazz, "getAvailableInternalSize")
end

function StorageUtil.getTotalInternalSize()
	return NativeBridge.instance:invokeLong(clazz, "getTotalInternalSize")
end

function StorageUtil.isSdCardExist()
	return NativeBridge.instance:invokeBool(clazz, "isSdCardExist")
end

function StorageUtil.getAvailableExternalSize()
	return NativeBridge.instance:invokeLong(clazz, "getAvailableExternalSize")
end

function StorageUtil.getTotalExternalSize()
	return NativeBridge.instance:invokeLong(clazz, "getTotalExternalSize")
end

return StorageUtil
