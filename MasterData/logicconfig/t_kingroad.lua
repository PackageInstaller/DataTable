-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kingroad.lua

module("logicconfig.config.t_kingroad", package.seeall)

local title = {
	choosePrefab = 3,
	extParam = 4,
	name = 2,
	extLang3 = 7,
	id = 1,
	extLang2 = 6,
	extLang4 = 8,
	extLang1 = 5
}
local dataList = {
	{
		1,
		82000096,
		"c1",
		"",
		0,
		0,
		0,
		0
	},
	{
		2,
		82000100,
		"c2",
		"",
		82000157,
		82000158,
		82000103,
		0
	},
	{
		3,
		82000065,
		"c3",
		"104",
		82000097,
		82000098,
		82000099,
		82000129
	},
	{
		4,
		82000095,
		"c4",
		"",
		82000104,
		82000311,
		82000106,
		82000107
	},
	{
		5,
		82000083,
		"c5",
		"102#103",
		82000089,
		82000090,
		82000091,
		82000094
	},
	{
		6,
		82000130,
		"c6",
		"",
		0,
		0,
		0,
		0
	}
}
local t_kingroad = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_kingroad.dataList = dataList

local multiLanguageCells = {
	extLang4 = true,
	name = true,
	extLang3 = true,
	extLang2 = true,
	extLang1 = true
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

return t_kingroad
