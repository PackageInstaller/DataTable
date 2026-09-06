-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_taskbuttontext.lua

module("logicconfig.config.t_taskbuttontext", package.seeall)

local title = {
	id = 1,
	text = 2
}
local dataList = {}
local t_taskbuttontext = {}

t_taskbuttontext.dataList = dataList

local multiLanguageCells = {
	text = true
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

return t_taskbuttontext
