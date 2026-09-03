-- chunkname: @/tmp/or_script/lua_compile/sdk/CSDHelper.lua

local CSDHelper = {}
local baseUrl = "https://visitor.one.cn/#/?"
local serviceKey = "b572688e-6954-4920-a7fe-dc150663304d"
local secretKey = "ca2032d0-0b52-4610-9f8e-a64ba3f2a72f"
local platform = 3
local account

function CSDHelper:openH5CSD(ID)
	cc.Application:getInstance():openURL(self:getCSDUrl(ID))
end

function CSDHelper:getCSDUrl(ID)
	local url = baseUrl .. "code=" .. self:getCode() .. "&serviceKey=" .. serviceKey .. "&platform=" .. tostring(platform) .. "&os=" .. tostring(self:getOS()) .. "&currentTime=" .. tostring(self:getCurrentTime()) .. "&account=" .. ID

	dump(url, "url")

	return url
end

function CSDHelper:getOS()
	local targetPlatform = cc.Application:getInstance():getTargetPlatform()

	if targetPlatform == cc.PLATFORM_OS_IPHONE or targetPlatform == cc.PLATFORM_OS_IPAD then
		return 1
	elseif cc.PLATFORM_OS_ANDROID == targetPlatform then
		return 2
	end

	return 1
end

function CSDHelper:getCode()
	local originStr = secretKey .. serviceKey .. tostring(platform) .. tostring(self:getOS()) .. tostring(self:getCurrentTime())

	return crypto.md5(originStr)
end

function CSDHelper:getCurrentTime()
	return DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
end

return CSDHelper
