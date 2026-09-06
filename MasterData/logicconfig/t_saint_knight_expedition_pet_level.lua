-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_pet_level.lua

module("logicconfig.config.t_saint_knight_expedition_pet_level", package.seeall)

local title = {
	talentLv = 4,
	lv = 3,
	showLevel = 6,
	exp = 5,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		481001,
		0,
		1,
		0,
		0,
		1
	},
	{
		481001,
		1,
		10,
		1,
		60,
		10
	},
	{
		481001,
		2,
		20,
		2,
		180,
		20
	},
	{
		481001,
		3,
		30,
		3,
		300,
		30
	},
	{
		481001,
		4,
		40,
		4,
		600,
		40
	},
	{
		481001,
		5,
		50,
		5,
		1200,
		50
	},
	{
		481001,
		6,
		55,
		6,
		2400,
		55
	},
	{
		481001,
		7,
		60,
		7,
		3600,
		60
	},
	{
		481001,
		8,
		65,
		8,
		4800,
		65
	},
	{
		481001,
		9,
		70,
		9,
		6000,
		70
	},
	{
		481001,
		10,
		75,
		10,
		9000,
		75
	},
	{
		481001,
		11,
		80,
		11,
		12000,
		80
	},
	{
		481001,
		12,
		85,
		12,
		24000,
		85
	},
	{
		481001,
		13,
		90,
		13,
		36000,
		90
	},
	{
		481001,
		14,
		95,
		14,
		48000,
		95
	},
	{
		481001,
		15,
		100,
		15,
		60000,
		100
	}
}
local t_saint_knight_expedition_pet_level = {
	[481001] = {
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
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_saint_knight_expedition_pet_level.dataList = dataList

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

return t_saint_knight_expedition_pet_level
