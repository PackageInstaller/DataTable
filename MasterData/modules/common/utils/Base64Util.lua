-- chunkname: @modules/common/utils/Base64Util.lua

module("modules.common.utils.Base64Util", package.seeall)

local Base64Util = _M

Base64Util.b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function Base64Util.encode(data)
	return (data:gsub(".", function(x)
		local r, b = "", x:byte()

		for i = 8, 1, -1 do
			r = r .. (b % 2^i - b % 2^(i - 1) > 0 and "1" or "0")
		end

		return r
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
		if #x < 6 then
			return ""
		end

		local c = 0

		for i = 1, 6 do
			c = c + ((x:sub(i, i) == "1" or nil) and (2^(6 - i) or 0))
		end

		return Base64Util.b:sub(c + 1, c + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#data % 3 + 1]
end

function Base64Util.decode(data)
	data = string.gsub(data, "data:image/jpeg;base64,", "", 1)
	data = string.gsub(data, "data:image/png;base64,", "", 1)
	data = string.gsub(data, "[^" .. Base64Util.b .. "=]", "")

	return (data:gsub(".", function(x)
		if x == "=" then
			return ""
		end

		local r, f = "", Base64Util.b:find(x) - 1

		for i = 6, 1, -1 do
			r = r .. (f % 2^i - f % 2^(i - 1) > 0 and "1" or "0")
		end

		return r
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
		if #x ~= 8 then
			return ""
		end

		local c = 0

		for i = 1, 8 do
			c = c + ((x:sub(i, i) == "1" or nil) and (2^(8 - i) or 0))
		end

		return string.char(c)
	end))
end

function Base64Util.saveImage(box64String)
	local bytes = Base64Util.decode(box64String)
	local directory = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot")
	local now = System.DateTime.Now
	local fileName = string.format("screenshot_%s%s%s_%s%s%s%s.png", now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second, now.Millisecond)
	local path = System.IO.Path.Combine(directory, fileName)

	SLFramework.FileHelper.WriteAllBytesToPath(path, bytes)
	SDKMgr.instance:saveImage(path)
end

return Base64Util
