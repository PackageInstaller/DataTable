-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_support.lua

module("logicconfig.config.t_saint_knight_expedition_support", package.seeall)

local title = {
	initOpen = 3,
	carriedPetId = 17,
	creepsId = 2,
	maxHp = 8,
	faceId = 9,
	summonedPetId = 11,
	talentLv = 7,
	summonMasterId = 10,
	holyStripeSuitName = 13,
	activityId = 1,
	oraclePetId = 19,
	fixedStarGodId = 12,
	imgUrl = 15,
	holyStripeSuitDesc = 14,
	creepsName = 5,
	raceId = 4,
	oracleMasterId = 18,
	lv = 6,
	carriedMasterId = 16
}
local dataList = {
	{
		481001,
		100000001,
		true,
		11007,
		"圣骑·天闪",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			404,
			410,
			406
		},
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		0,
		0,
		0,
		0
	},
	{
		481001,
		100000002,
		true,
		14008,
		"圣骑·光轮",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			402,
			410,
			403
		},
		"圣痕裂风",
		"生命百分比越低，伤害越高，最高30%",
		"icon_xitong_lingwen_06",
		0,
		0,
		0,
		0
	},
	{
		481001,
		100000003,
		true,
		13001,
		"圣骑·迷踪",
		1,
		0,
		"",
		"",
		"",
		"100000004",
		{
			402,
			403,
			410,
			407
		},
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07",
		0,
		0,
		0,
		0
	},
	{
		481001,
		100000004,
		true,
		12007,
		"圣骑·烈心",
		1,
		0,
		"",
		"",
		"100000003",
		"",
		{
			401,
			404,
			410,
			406
		},
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		0,
		0,
		0,
		0
	},
	{
		481001,
		100000005,
		true,
		12008,
		"圣骑·炎神",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			402,
			410,
			403
		},
		"圣痕裂风",
		"生命百分比越低，伤害越高，最高30%",
		"icon_xitong_lingwen_06",
		0,
		0,
		0,
		0
	},
	{
		481001,
		100000006,
		true,
		15011,
		"圣骑·阎罗",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			404,
			410,
			406
		},
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		0,
		0,
		0,
		0
	},
	{
		481001,
		200000001,
		false,
		11029,
		"神曜圣骑·苍穹天闪",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			404,
			410,
			406
		},
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		0,
		0,
		0,
		0
	},
	{
		481001,
		200000002,
		false,
		14035,
		"神曜圣骑·审判光轮",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			402,
			410,
			403
		},
		"圣痕裂风",
		"生命百分比越低，伤害越高，最高30%",
		"icon_xitong_lingwen_06",
		0,
		0,
		0,
		0
	},
	{
		481001,
		200000003,
		false,
		13024,
		"神曜圣骑·万象迷踪",
		1,
		0,
		"",
		"",
		"",
		"200000004",
		{
			402,
			403,
			410,
			407
		},
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07",
		0,
		0,
		0,
		0
	},
	{
		481001,
		200000004,
		false,
		12031,
		"神曜圣骑·红莲烈心",
		1,
		0,
		"",
		"",
		"200000003",
		"",
		{
			401,
			404,
			410,
			406
		},
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		0,
		0,
		0,
		0
	},
	{
		481001,
		200000005,
		false,
		12032,
		"神曜圣骑·怒麟炎神",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			402,
			410,
			403
		},
		"圣痕裂风",
		"生命百分比越低，伤害越高，最高30%",
		"icon_xitong_lingwen_06",
		0,
		0,
		0,
		0
	},
	{
		481001,
		200000006,
		false,
		15035,
		"神曜圣骑·疾刃阎罗",
		1,
		0,
		"",
		"",
		"",
		"",
		{
			401,
			404,
			410,
			406
		},
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02",
		0,
		0,
		0,
		0
	}
}
local t_saint_knight_expedition_support = {
	[481001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6],
		[200000001] = dataList[7],
		[200000002] = dataList[8],
		[200000003] = dataList[9],
		[200000004] = dataList[10],
		[200000005] = dataList[11],
		[200000006] = dataList[12]
	}
}

t_saint_knight_expedition_support.dataList = dataList

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

return t_saint_knight_expedition_support
