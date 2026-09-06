-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_island_game.lua

module("logicconfig.config.t_saint_knight_expedition_island_game", package.seeall)

local title = {
	openParam = 5,
	condParams = 4,
	condType = 3,
	index = 2,
	activityId = 1
}
local dataList = {
	{
		481001,
		1,
		"islandLevel",
		{
			islandId = "1",
			level = "3"
		},
		{
			scoreType = "2"
		}
	},
	{
		481001,
		2,
		"islandLevel",
		{
			islandId = "2",
			level = "3"
		},
		{
			scoreType = "4"
		}
	},
	{
		481001,
		3,
		"islandLevel",
		{
			islandId = "3",
			level = "3"
		},
		{
			scoreType = "3"
		}
	},
	{
		481001,
		4,
		"islandLevel",
		{
			islandId = "4",
			level = "3"
		},
		{
			scoreType = "1"
		}
	},
	{
		481001,
		5,
		"islandLevel",
		{
			islandId = "5",
			level = "3"
		},
		{
			scoreType = "5"
		}
	},
	{
		481001,
		6,
		""
	}
}
local t_saint_knight_expedition_island_game = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_saint_knight_expedition_island_game.dataList = dataList

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

return t_saint_knight_expedition_island_game
