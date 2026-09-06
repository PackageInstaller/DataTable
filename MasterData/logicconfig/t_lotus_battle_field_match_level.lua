-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_match_level.lua

module("logicconfig.config.t_lotus_battle_field_match_level", package.seeall)

local title = {
	endLevel = 5,
	startLevel = 4,
	sec = 3,
	id = 2,
	matchPlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		0,
		40
	},
	{
		1,
		1,
		15,
		0,
		60
	},
	{
		1,
		1,
		30,
		0,
		80
	},
	{
		1,
		1,
		45,
		0,
		100
	},
	{
		1,
		2,
		0,
		41,
		80
	},
	{
		1,
		2,
		15,
		31,
		90
	},
	{
		1,
		2,
		30,
		21,
		100
	},
	{
		1,
		2,
		45,
		0,
		100
	},
	{
		1,
		3,
		0,
		81,
		100
	},
	{
		1,
		3,
		15,
		61,
		100
	},
	{
		1,
		3,
		30,
		41,
		100
	},
	{
		1,
		3,
		45,
		0,
		100
	}
}
local t_lotus_battle_field_match_level = {
	{
		{
			[0] = dataList[1],
			[15] = dataList[2],
			[30] = dataList[3],
			[45] = dataList[4]
		},
		{
			[0] = dataList[5],
			[15] = dataList[6],
			[30] = dataList[7],
			[45] = dataList[8]
		},
		{
			[0] = dataList[9],
			[15] = dataList[10],
			[30] = dataList[11],
			[45] = dataList[12]
		}
	}
}

t_lotus_battle_field_match_level.dataList = dataList

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

return t_lotus_battle_field_match_level
