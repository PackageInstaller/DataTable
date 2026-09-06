-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_genius_type_config.lua

module("logicconfig.config.t_genius_type_config", package.seeall)

local title = {
	geniusType = 1,
	name = 2,
	minTotalStar = 4,
	cost = 3
}
local dataList = {}
local t_genius_type_config = {}

t_genius_type_config.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_genius_type_config
