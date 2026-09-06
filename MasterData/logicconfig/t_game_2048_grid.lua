-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_grid.lua

module("logicconfig.config.t_game_2048_grid", package.seeall)

local title = {
	gridId = 2,
	gridPlanId = 1,
	gbId = 3
}
local dataList = {
	{
		1,
		-1,
		-1
	},
	{
		1,
		0,
		0
	},
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		1,
		3,
		3
	},
	{
		1,
		4,
		4
	},
	{
		1,
		5,
		5
	},
	{
		1,
		6,
		6
	},
	{
		1,
		7,
		7
	},
	{
		1,
		8,
		8
	},
	{
		1,
		9,
		9
	},
	{
		1,
		10,
		10
	},
	{
		1,
		11,
		11
	},
	{
		1,
		12,
		12
	},
	{
		1,
		13,
		13
	},
	{
		1,
		14,
		14
	},
	{
		1,
		15,
		15
	},
	{
		1,
		16,
		16
	},
	{
		1,
		17,
		17
	},
	{
		1,
		18,
		18
	},
	{
		1,
		19,
		19
	},
	{
		1,
		20,
		20
	},
	{
		1,
		21,
		21
	},
	{
		1,
		22,
		22
	},
	{
		1,
		23,
		23
	},
	{
		1,
		24,
		24
	},
	{
		1,
		25,
		25
	},
	{
		1,
		26,
		26
	},
	{
		1,
		27,
		27
	},
	{
		1,
		28,
		28
	},
	{
		1,
		29,
		29
	},
	{
		1,
		30,
		30
	},
	{
		1,
		31,
		31
	}
}
local t_game_2048_grid = {
	{
		[-1] = dataList[1],
		[0] = dataList[2],
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32],
		dataList[33]
	}
}

t_game_2048_grid.dataList = dataList

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

return t_game_2048_grid
