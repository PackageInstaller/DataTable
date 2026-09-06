-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_holy_challenge_stage.lua

module("logicconfig.config.t_origin_holy_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 3,
	supportPetId = 5,
	targetKillCount = 6,
	lineRotation = 12,
	planId = 8,
	desc = 9,
	enemyRaceId = 7,
	nodePos = 10,
	linePos = 11,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		608001,
		1,
		"2026-07-10T05:00:00",
		1001,
		100000001,
		1,
		13023,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥1",
		{
			-320,
			0
		},
		{
			157,
			34
		},
		-75
	},
	{
		608001,
		2,
		"2026-07-10T05:00:00",
		1002,
		100000001,
		1,
		14032,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥1",
		{
			0,
			0
		},
		{
			162,
			49
		},
		-75
	},
	{
		608001,
		3,
		"2026-07-10T05:00:00",
		1003,
		100000001,
		1,
		11030,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥1",
		{
			320,
			0
		},
		{
			-160,
			30
		},
		75
	},
	{
		608001,
		4,
		"2026-07-10T05:00:00",
		1004,
		100000001,
		2,
		12033,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥2",
		{
			0,
			0
		},
		{
			-153,
			20
		},
		75
	},
	{
		608001,
		5,
		"2026-07-11T05:00:00",
		1005,
		100000001,
		2,
		15037,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥2",
		{
			-320,
			0
		},
		{
			157,
			34
		},
		-75
	},
	{
		608001,
		6,
		"2026-07-11T05:00:00",
		1006,
		100000001,
		2,
		11036,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥2",
		{
			0,
			0
		},
		{
			157,
			34
		},
		-75
	},
	{
		608001,
		7,
		"2026-07-11T05:00:00",
		1007,
		100000001,
		3,
		12040,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥3",
		{
			320,
			0
		},
		{
			-160,
			30
		},
		75
	},
	{
		608001,
		8,
		"2026-07-11T05:00:00",
		1008,
		100000001,
		3,
		13025,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥3",
		{
			0,
			0
		},
		{
			-160,
			30
		},
		75
	},
	{
		608001,
		9,
		"2026-07-12T05:00:00",
		1009,
		100000001,
		3,
		16041,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥3",
		{
			-320,
			0
		},
		{
			157,
			34
		},
		-75
	},
	{
		608001,
		10,
		"2026-07-12T05:00:00",
		1010,
		100000001,
		3,
		12038,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥3",
		{
			0,
			0
		},
		{
			157,
			34
		},
		-75
	},
	{
		608001,
		11,
		"2026-07-12T05:00:00",
		1011,
		100000001,
		3,
		17025,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥3",
		{
			320,
			0
		},
		{
			-160,
			30
		},
		75
	},
	{
		608001,
		12,
		"2026-07-12T05:00:00",
		1012,
		100000001,
		3,
		15050,
		1,
		"1、击败敌阵全部精灵\r\n2、源起圣光飞龙存活\r\n3、源起圣光飞龙杀数≥3",
		{
			0,
			0
		},
		{
			162,
			49
		},
		-75
	}
}
local t_origin_holy_challenge_stage = {
	[608001] = {
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
		dataList[11],
		dataList[12]
	}
}

t_origin_holy_challenge_stage.dataList = dataList

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

return t_origin_holy_challenge_stage
