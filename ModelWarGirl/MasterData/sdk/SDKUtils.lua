-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKUtils.lua

local json = require("cjson")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local logerror = logerror
local SDKUtils = {}

function SDKUtils.stringify(data, keepNum)
	local typeData = type(data)

	if typeData == "string" then
		return data
	elseif typeData == "number" then
		if keepNum then
			return data
		else
			return tostring(data)
		end
	elseif typeData == "boolean" then
		return tostring(data)
	elseif typeData == "table" then
		local newTable = {}

		for k, v in pairs(data) do
			newTable[k] = SDKUtils.stringify(v, keepNum)
		end

		return newTable
	else
		return nil
	end
end

function SDKUtils.isReturnTrue(data)
	return data[AttName.RESULT] ~= "0"
end

return SDKUtils
