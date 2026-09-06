-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throw_shells_game.lua

module("logicconfig.config.t_throw_shells_game", package.seeall)

local title = {
	stageId = 2,
	airForce = 5,
	prize = 7,
	propId = 3,
	terrainId = 4,
	round = 6,
	gameId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		{
			-3,
			3
		},
		10,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		2,
		1,
		2,
		{
			-5,
			5
		},
		10,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		3,
		1,
		3,
		{
			-5,
			5
		},
		10,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		4,
		2,
		4,
		{
			-5,
			5
		},
		8,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		5,
		2,
		9,
		{
			-5,
			5
		},
		8,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		6,
		2,
		5,
		{
			-10,
			10
		},
		8,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		7,
		3,
		6,
		{
			-10,
			10
		},
		8,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		8,
		3,
		7,
		{
			-10,
			10
		},
		8,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		9,
		3,
		8,
		{
			-10,
			10
		},
		8,
		"104:2:20#4:7011:1#4:8003:50"
	},
	{
		1,
		10,
		3,
		10,
		{
			-10,
			10
		},
		6,
		"104:2:20#4:7011:1#4:8003:50"
	}
}
local t_throw_shells_game = {
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
		dataList[10]
	}
}

t_throw_shells_game.dataList = dataList

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

return t_throw_shells_game
