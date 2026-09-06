-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_feeling_lv.lua

module("logicconfig.config.t_goddess_feeling_lv", package.seeall)

local title = {
	feeling = 3,
	planId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		0
	},
	{
		1,
		2,
		20
	},
	{
		1,
		3,
		150
	},
	{
		1,
		4,
		250
	},
	{
		1,
		5,
		350
	},
	{
		1,
		6,
		450
	},
	{
		1,
		7,
		550
	},
	{
		1,
		8,
		650
	},
	{
		1,
		9,
		800
	},
	{
		1,
		10,
		900
	},
	{
		1,
		11,
		1100
	}
}
local t_goddess_feeling_lv = {
	{
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
		dataList[11]
	}
}

t_goddess_feeling_lv.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_goddess_feeling_lv
