-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_pet.lua

module("logicconfig.config.t_aoqi_hero_pet", package.seeall)

local title = {
	maxEnergy = 9,
	name = 3,
	unlockCost = 7,
	isFormation = 10,
	res = 11,
	elementId = 5,
	propertyStrategyId = 6,
	faceIds = 4,
	raceId = 2,
	size = 8,
	activityId = 1
}
local dataList = {
	{
		450001,
		12018,
		"龙炎",
		"12018",
		3,
		1,
		"",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		11021,
		"帝释天",
		"11021",
		2,
		2,
		"",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		14018,
		"诺亚",
		"14018",
		4,
		3,
		"",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		13009,
		"阿瑞斯",
		"13009",
		1,
		4,
		"",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		15018,
		"修尔",
		"15018",
		5,
		5,
		"",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		16029,
		"梵天",
		"16029",
		6,
		6,
		"",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		12025,
		"茜茜",
		"12025",
		3,
		7,
		"10:450002:100",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		11022,
		"维多利亚",
		"11022",
		2,
		8,
		"10:450002:100",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		10323,
		"洛世琦",
		"10323",
		4,
		9,
		"10:450002:100",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		13016,
		"潘多拉",
		"13016",
		1,
		10,
		"10:450002:100",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		15028,
		"伊丽莎白",
		"15028",
		5,
		11,
		"10:450002:100",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		16027,
		"极",
		"16027",
		6,
		12,
		"10:450002:100",
		{
			1,
			1
		},
		150,
		true,
		""
	},
	{
		450001,
		10196,
		"暗怪怪",
		"10196",
		5,
		13,
		"",
		{
			1,
			1
		},
		150,
		false,
		""
	},
	{
		450001,
		10037,
		"魔魔",
		"10037",
		5,
		14,
		"",
		{
			1,
			1
		},
		150,
		false,
		""
	},
	{
		450001,
		11025,
		"古拉斯",
		"11025",
		2,
		15,
		"",
		{
			2,
			1
		},
		150,
		false,
		""
	},
	{
		450001,
		10330,
		"艾希",
		"10330",
		5,
		16,
		"",
		{
			1,
			2
		},
		150,
		false,
		""
	},
	{
		450001,
		12019,
		"赤焰龙皇",
		"12019",
		3,
		17,
		"",
		{
			2,
			2
		},
		150,
		false,
		""
	},
	{
		450001,
		10353,
		"宝石鸟",
		"10353",
		0,
		18,
		"",
		{
			1,
			1
		},
		150,
		false,
		"board_aoqiyongshituan_mutong"
	}
}
local t_aoqi_hero_pet = {
	[450001] = {
		[12018] = dataList[1],
		[11021] = dataList[2],
		[14018] = dataList[3],
		[13009] = dataList[4],
		[15018] = dataList[5],
		[16029] = dataList[6],
		[12025] = dataList[7],
		[11022] = dataList[8],
		[10323] = dataList[9],
		[13016] = dataList[10],
		[15028] = dataList[11],
		[16027] = dataList[12],
		[10196] = dataList[13],
		[10037] = dataList[14],
		[11025] = dataList[15],
		[10330] = dataList[16],
		[12019] = dataList[17],
		[10353] = dataList[18]
	}
}

t_aoqi_hero_pet.dataList = dataList

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

return t_aoqi_hero_pet
