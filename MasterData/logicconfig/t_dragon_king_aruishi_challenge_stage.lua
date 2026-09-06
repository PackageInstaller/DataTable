-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_aruishi_challenge_stage.lua

module("logicconfig.config.t_dragon_king_aruishi_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	name = 7,
	limit = 9,
	prize = 4,
	desc = 8,
	reviveTime = 6,
	creepsMasterId = 3,
	activityId = 1,
	startTime = 5
}
local dataList = {
	{
		361001,
		1,
		101,
		"4:232:5",
		"2024-05-17T05:00:00",
		{
			1,
			0,
			1,
			2,
			0,
			2,
			3,
			0,
			3
		},
		1,
		"5回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		2,
		102,
		"4:232:5",
		"2024-05-17T05:00:00",
		{
			1,
			0,
			1,
			2,
			0,
			2,
			0,
			3,
			3
		},
		2,
		"5回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		3,
		103,
		"4:232:10",
		"2024-05-17T05:00:00",
		{
			2,
			1,
			1,
			3,
			0,
			2,
			3,
			0,
			0
		},
		3,
		"5回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		4,
		104,
		"4:232:10",
		"2024-05-17T05:00:00",
		{
			6,
			4,
			5,
			6,
			4,
			5,
			6,
			4,
			5
		},
		4,
		"4回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		5,
		105,
		"4:232:15",
		"2024-05-17T05:00:00",
		{
			5,
			6,
			4,
			5,
			4,
			6,
			4,
			6,
			5
		},
		5,
		"4回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		6,
		106,
		"4:232:15",
		"2024-05-17T05:00:00",
		{
			6,
			4,
			5,
			4,
			6,
			5,
			5,
			6,
			4
		},
		6,
		"4回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		7,
		107,
		"4:232:20",
		"2024-05-17T05:00:00",
		{
			9,
			7,
			7,
			9,
			8,
			7,
			9,
			8,
			8
		},
		7,
		"3回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		8,
		108,
		"4:232:20",
		"2024-05-17T05:00:00",
		{
			8,
			7,
			9,
			8,
			8,
			7,
			9,
			7,
			9
		},
		8,
		"3回合内达到伤害即可获胜",
		5
	},
	{
		361001,
		9,
		109,
		"4:232:20",
		"2024-05-17T05:00:00",
		{
			7,
			9,
			8,
			7,
			9,
			8,
			7,
			9,
			8
		},
		9,
		"3回合内达到伤害即可获胜",
		5
	}
}
local t_dragon_king_aruishi_challenge_stage = {
	[361001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_dragon_king_aruishi_challenge_stage.dataList = dataList

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

return t_dragon_king_aruishi_challenge_stage
