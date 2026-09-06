-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_pet_level.lua

module("logicconfig.config.t_dragon_awaken_pet_level", package.seeall)

local title = {
	cost = 5,
	lv = 3,
	talentLv = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		419001,
		0,
		1,
		0,
		""
	},
	{
		419001,
		1,
		10,
		0,
		"10:419002:20"
	},
	{
		419001,
		2,
		20,
		1,
		"10:419002:30"
	},
	{
		419001,
		3,
		30,
		2,
		"10:419002:50"
	},
	{
		419001,
		4,
		40,
		3,
		"10:419002:100"
	},
	{
		419001,
		5,
		50,
		5,
		"10:419002:200"
	},
	{
		419001,
		6,
		60,
		7,
		"10:419002:300"
	},
	{
		419001,
		7,
		70,
		9,
		"10:419002:400"
	},
	{
		419001,
		8,
		80,
		11,
		"10:419002:500"
	},
	{
		419001,
		9,
		90,
		13,
		"10:419002:600"
	},
	{
		419001,
		10,
		100,
		15,
		"10:419002:800"
	},
	{
		419002,
		0,
		1,
		0,
		""
	},
	{
		419002,
		1,
		10,
		0,
		"10:419005:20"
	},
	{
		419002,
		2,
		20,
		1,
		"10:419005:30"
	},
	{
		419002,
		3,
		30,
		2,
		"10:419005:50"
	},
	{
		419002,
		4,
		40,
		3,
		"10:419005:100"
	},
	{
		419002,
		5,
		50,
		5,
		"10:419005:200"
	},
	{
		419002,
		6,
		60,
		7,
		"10:419005:300"
	},
	{
		419002,
		7,
		70,
		9,
		"10:419005:400"
	},
	{
		419002,
		8,
		80,
		11,
		"10:419005:500"
	},
	{
		419002,
		9,
		90,
		13,
		"10:419005:600"
	},
	{
		419002,
		10,
		100,
		15,
		"10:419005:800"
	}
}
local t_dragon_awaken_pet_level = {
	[419001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	},
	[419002] = {
		[0] = dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	}
}

t_dragon_awaken_pet_level.dataList = dataList

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

return t_dragon_awaken_pet_level
