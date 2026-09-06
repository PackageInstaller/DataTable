-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_grid_game_prize.lua

module("logicconfig.config.t_beast_rich_man_grid_game_prize", package.seeall)

local title = {
	score = 3,
	prize = 4,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		558001,
		1,
		10,
		500
	},
	{
		558001,
		1,
		20,
		800
	},
	{
		558001,
		1,
		30,
		1100
	},
	{
		558001,
		1,
		40,
		1500
	},
	{
		558001,
		2,
		50,
		500
	},
	{
		558001,
		2,
		80,
		800
	},
	{
		558001,
		2,
		110,
		1100
	},
	{
		558001,
		2,
		150,
		1500
	},
	{
		558001,
		3,
		20,
		500
	},
	{
		558001,
		3,
		25,
		800
	},
	{
		558001,
		3,
		30,
		1100
	},
	{
		558001,
		3,
		35,
		1500
	},
	{
		558001,
		4,
		5,
		500
	},
	{
		558001,
		4,
		10,
		800
	},
	{
		558001,
		4,
		20,
		1100
	},
	{
		558001,
		4,
		30,
		1500
	}
}
local t_beast_rich_man_grid_game_prize = {
	[558001] = {
		{
			[10] = dataList[1],
			[20] = dataList[2],
			[30] = dataList[3],
			[40] = dataList[4]
		},
		{
			[50] = dataList[5],
			[80] = dataList[6],
			[110] = dataList[7],
			[150] = dataList[8]
		},
		{
			[20] = dataList[9],
			[25] = dataList[10],
			[30] = dataList[11],
			[35] = dataList[12]
		},
		{
			[5] = dataList[13],
			[10] = dataList[14],
			[20] = dataList[15],
			[30] = dataList[16]
		}
	}
}

t_beast_rich_man_grid_game_prize.dataList = dataList

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

return t_beast_rich_man_grid_game_prize
