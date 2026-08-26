-- chunkname: @modules/configs/JsonToLuaParser.lua

module("modules.configs.JsonToLuaParser", package.seeall)

local JsonToLuaParser = {}

function JsonToLuaParser.parse(json, fields, primaryKey, mlStringKeyDict)
	local configDict = {}
	local configList = json
	local metatable = {}

	function metatable.__index(t, key)
		local fieldIndex = fields[key]
		local value = rawget(t, fieldIndex)

		if mlStringKeyDict and mlStringKeyDict[key] then
			return lang(value)
		end

		return value
	end

	function metatable.__newindex(_, key, value)
		logError("Can't modify config field: " .. key)
	end

	for _, configRow in ipairs(configList) do
		setmetatable(configRow, metatable)

		local dict = configDict

		for i, pkKey in ipairs(primaryKey) do
			local pkValue = configRow[pkKey]

			if i == #primaryKey then
				dict[pkValue] = configRow
			else
				dict[pkValue] = dict[pkValue] or {}
				dict = dict[pkValue]
			end
		end
	end

	return configList, configDict
end

return JsonToLuaParser
