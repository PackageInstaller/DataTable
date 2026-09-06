-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_story_text.lua

module("logicconfig.config.t_story_text", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1,
		82036939
	},
	{
		2,
		82036940
	},
	{
		3,
		82036941
	},
	{
		4,
		82036942
	},
	{
		5,
		82036943
	},
	{
		6,
		82036944
	},
	{
		7,
		82036945
	},
	{
		8,
		82036946
	},
	{
		9,
		82036947
	},
	{
		10,
		82036948
	},
	{
		11,
		82036949
	},
	{
		12,
		82036950
	},
	{
		13,
		0
	},
	{
		14,
		0
	},
	{
		15,
		0
	}
}
local t_story_text = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_story_text.dataList = dataList

local multiLanguageCells = {
	content = true
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

return t_story_text
