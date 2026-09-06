-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gear_game_puzzle.lua

module("logicconfig.config.t_gear_game_puzzle", package.seeall)

local title = {
	cutdownId = 4,
	height = 3,
	geerId = 5,
	width = 2,
	puzzleId = 1
}
local dataList = {
	{
		1,
		2,
		2,
		{
			1
		},
		{
			4
		}
	},
	{
		2,
		2,
		2,
		{
			1
		},
		{
			2,
			3
		}
	},
	{
		3,
		3,
		2,
		{
			3,
			4
		},
		{
			1,
			5
		}
	},
	{
		4,
		3,
		1,
		[5] = {
			2,
			3
		}
	},
	{
		5,
		3,
		2,
		{
			4,
			6
		},
		{
			5
		}
	},
	{
		6,
		3,
		2,
		{
			4,
			6
		},
		{
			1,
			2,
			3
		}
	},
	{
		7,
		3,
		2,
		{
			4,
			5
		},
		{
			1,
			2,
			6
		}
	}
}
local t_gear_game_puzzle = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_gear_game_puzzle.dataList = dataList

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

return t_gear_game_puzzle
