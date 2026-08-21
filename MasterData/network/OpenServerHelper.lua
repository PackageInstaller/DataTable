-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\OpenServerHelper.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local HttpUtils = Framework.Network.HttpUtils
local HttpHelper = require("Network/HttpHelper")
local OpenServerHelper = {}
local self = OpenServerHelper

function OpenServerHelper.httpPost(url, data, callback, retryTimes)
	data = self._fillUUID(data)

	HttpHelper.post(url, ClientUtils.table2String(data), callback, retryTimes)
end

function OpenServerHelper.httpGet(url, data, callback, retryTimes)
	data = self._fillUUID(data)

	local url = ClientUtils.composeGetUrl(url, data)

	HttpHelper.get(url, callback, retryTimes)
end

function OpenServerHelper._fillUUID(data)
	if data == nil then
		data = {}
	end

	data.uuid = LuaToolkit.GetOpenDataUUID()

	return data
end

return OpenServerHelper
