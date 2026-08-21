-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/SDKOneSDKImpl.lua

module("logic.common.sdk.SDKOneSDKImpl", package.seeall)

local M = class("SDKOneSDKImpl", SDKBase)

function M:getGameId()
	return 100304
end

function M:isOfficialPlatform()
	local isOfficial = false
	local platformId = BootstrapUtil.getPlatformId()

	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		if platformId == 2 then
			isOfficial = true
		end
	elseif platformId == 10 then
		isOfficial = true
	end

	return isOfficial
end

return M
