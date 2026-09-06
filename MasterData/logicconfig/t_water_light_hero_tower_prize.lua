-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_light_hero_tower_prize.lua

module("logicconfig.config.t_water_light_hero_tower_prize", package.seeall)

local title = {
	prizeId = 2,
	challengeId = 1,
	prize = 4,
	score = 3
}
local dataList = {
	{
		28,
		1,
		1000,
		"4:31:2"
	},
	{
		28,
		2,
		2000,
		"4:31:2"
	},
	{
		28,
		3,
		3000,
		"4:111:2"
	},
	{
		28,
		4,
		4000,
		"4:31:2"
	},
	{
		28,
		5,
		5000,
		"4:31:2"
	},
	{
		28,
		6,
		6000,
		"4:31:2"
	},
	{
		28,
		7,
		7000,
		"100:14004:1:1"
	},
	{
		115,
		1,
		100,
		"4:196:200"
	},
	{
		115,
		2,
		300,
		"4:196:400"
	},
	{
		115,
		3,
		500,
		"4:196:600"
	},
	{
		115,
		4,
		1000,
		"4:196:700"
	},
	{
		115,
		5,
		1500,
		"4:196:800"
	},
	{
		115,
		6,
		2500,
		"4:196:900"
	},
	{
		115,
		7,
		3500,
		"4:196:1000"
	},
	{
		115,
		8,
		5500,
		"4:196:1200"
	},
	{
		138,
		1,
		100,
		"4:209:200"
	},
	{
		138,
		2,
		300,
		"4:209:400"
	},
	{
		138,
		3,
		500,
		"4:209:600"
	},
	{
		138,
		4,
		1000,
		"4:209:700"
	},
	{
		138,
		5,
		1500,
		"4:209:800"
	},
	{
		138,
		6,
		2500,
		"4:209:900"
	},
	{
		138,
		7,
		3500,
		"4:209:1000"
	},
	{
		138,
		8,
		5500,
		"4:209:1200"
	}
}
local t_water_light_hero_tower_prize = {
	[28] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[115] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[138] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23]
	}
}

t_water_light_hero_tower_prize.dataList = dataList

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

return t_water_light_hero_tower_prize
