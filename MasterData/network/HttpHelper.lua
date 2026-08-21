-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\HttpHelper.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local HttpUtils = Framework.Network.HttpUtils
local UrlGroup = Framework.Network.UrlGroup
local UrlGroupLegacy = require("Network/UrlGroupLegacy")
local VersionUtils = VersionUtils
local HttpHelper = {}
local self = HttpHelper

function HttpHelper.createUrlGroup(urls, append)
	local group

	if VersionUtils.hasAbilityUrlGroup() then
		group = UrlGroup(unpack(urls))
	else
		group = UrlGroupLegacy(urls)
	end

	group:SetUrlAppend(append)

	return group
end

function HttpHelper.post(urlGroup, strData, callback, retryTimes, timeout)
	if urlGroup == nil then
		return
	end

	if retryTimes == nil then
		retryTimes = 1
	end

	if timeout == nil then
		timeout = 5
	end

	if type(urlGroup) == "string" then
		HttpUtils.Post(urlGroup, strData, callback, retryTimes)
	elseif HttpHelper._isGroupLagecy(urlGroup) then
		HttpUtils.Post(urlGroup:Get(), strData, callback, retryTimes)
	else
		HttpUtils.Post(urlGroup, strData, callback, retryTimes, timeout)
	end
end

function HttpHelper.get(urlGroup, callback, retryTimes, timeout)
	if retryTimes == nil then
		retryTimes = 1
	end

	if timeout == nil then
		timeout = 5
	end

	if type(urlGroup) == "string" then
		HttpUtils.Get(urlGroup, callback, retryTimes)
	elseif HttpHelper._isGroupLagecy(urlGroup) then
		HttpUtils.Get(urlGroup:Get(), callback, retryTimes)
	else
		HttpUtils.Get(urlGroup, callback, retryTimes, timeout)
	end
end

function HttpHelper._isGroupLagecy(urlGroup)
	return type(urlGroup) == "table" and urlGroup:getType() == "UrlGroupLegacy"
end

return HttpHelper
