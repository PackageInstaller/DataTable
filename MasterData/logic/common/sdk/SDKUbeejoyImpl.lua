-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/SDKUbeejoyImpl.lua

module("logic.common.sdk.SDKUbeejoyImpl", package.seeall)

local M = class("SDKUbeejoyImpl", SDKBase)
local clazz = "com.baitian.wrap.OneSDKWrap"

function M:ctor()
	return
end

function M:logout()
	return
end

function M:getGameId()
	local isExis = NativeBridge.instance:isMethodExist(clazz, "getGameId")
	local gameId = isExis and NativeBridge.instance:invokeString(clazz, "getGameId")

	if not gameId or gameId == "" then
		gameId = 200060
	end

	return gameId
end

return M
