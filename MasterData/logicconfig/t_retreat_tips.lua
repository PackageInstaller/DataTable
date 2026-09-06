-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_retreat_tips.lua

module("logicconfig.config.t_retreat_tips", package.seeall)

local title = {
	id = 1,
	text = 2
}
local dataList = {
	{
		1,
		82007985
	},
	{
		2,
		82007986
	},
	{
		3,
		82007987
	},
	{
		4,
		82007988
	},
	{
		5,
		82007989
	},
	{
		6,
		82007990
	},
	{
		7,
		82007991
	},
	{
		8,
		82040874
	},
	{
		9,
		82043466
	}
}
local t_retreat_tips = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_retreat_tips.dataList = dataList

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

return t_retreat_tips
