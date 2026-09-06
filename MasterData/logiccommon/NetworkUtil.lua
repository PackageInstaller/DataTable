-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/NetworkUtil.lua

module("logiccommon.common.sdk.NetworkUtil", package.seeall)

local NetworkUtil = {}
local clazz = "com.baitian.wrap.NetworkUtilWrap"

NetworkUtil.NETWORK_TYPE_DISCONNECT = -1
NetworkUtil.NETWORK_TYPE_CELLULAR = 1
NetworkUtil.NETWORK_TYPE_WIFI = 2
NetworkUtil.NETWORK_TYPE_OTHERS = 999

function NetworkUtil.getCurrentNetworkType(host)
	local param = {}

	if host ~= nil then
		param.host = host
	end

	return NativeBridge.instance:invokeInt(clazz, "getCurrentNetworkType", param)
end

return NetworkUtil
