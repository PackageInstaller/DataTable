-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/NetworkUtil.lua

module("logic.common.sdk.nativeutil.NetworkUtil", package.seeall)

local NetworkUtil = {}
local clazz = "com.baitian.wrap.NetworkUtilWrap"
local NETWORK_TYPE_DISCONNECT = -1
local NETWORK_TYPE_CELLULAR = 1
local NETWORK_TYPE_WIFI = 2
local NETWORK_TYPE_OTHERS = 999

function NetworkUtil.getCurrentNetworkType(host)
	local param = {}

	if host ~= nil then
		param.host = host
	end

	return NativeBridge.instance:invokeInt(clazz, "getCurrentNetworkType", param)
end

return NetworkUtil
