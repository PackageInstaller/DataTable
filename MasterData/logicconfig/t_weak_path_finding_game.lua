-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weak_path_finding_game.lua

module("logicconfig.config.t_weak_path_finding_game", package.seeall)

local title = {
	targetMin = 4,
	countdown = 3,
	gamePlanId = 1,
	targetMax = 5,
	debrisNum = 7,
	debris = 6,
	gameId = 2
}
local dataList = {
	{
		1,
		1,
		10,
		20,
		25,
		{
			5,
			10,
			6,
			9,
			11,
			3
		},
		20
	},
	{
		1,
		2,
		10,
		10,
		13,
		{
			6,
			5,
			9,
			3,
			7
		},
		20
	},
	{
		1,
		3,
		10,
		40,
		47,
		{
			11,
			9,
			16,
			17,
			20,
			3
		},
		20
	},
	{
		1,
		4,
		10,
		21,
		26,
		{
			13,
			17,
			9,
			5,
			2
		},
		20
	},
	{
		1,
		5,
		10,
		18,
		25,
		{
			8,
			3,
			5,
			9,
			7
		},
		20
	},
	{
		1,
		6,
		10,
		15,
		21,
		{
			17,
			13,
			9,
			6,
			3,
			4
		},
		20
	},
	{
		1,
		7,
		10,
		5,
		9,
		{
			1,
			3,
			6,
			2,
			4
		},
		20
	},
	{
		1,
		8,
		10,
		12,
		18,
		{
			3,
			7,
			4,
			8,
			10,
			15
		},
		20
	},
	{
		1,
		9,
		10,
		37,
		46,
		{
			16,
			18,
			25,
			7,
			28,
			10
		},
		20
	},
	{
		1,
		10,
		10,
		28,
		33,
		{
			17,
			14,
			20,
			13,
			2,
			4
		},
		20
	}
}
local t_weak_path_finding_game = {
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

t_weak_path_finding_game.dataList = dataList

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

return t_weak_path_finding_game
