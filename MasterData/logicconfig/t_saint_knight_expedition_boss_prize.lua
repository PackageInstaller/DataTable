-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_boss_prize.lua

module("logicconfig.config.t_saint_knight_expedition_boss_prize", package.seeall)

local title = {
	prizeId = 3,
	zoneId = 2,
	damage = 4,
	prize = 5,
	activityId = 1
}
local dataList = {
	{
		481001,
		1,
		1,
		"500000",
		"10:481001:500"
	},
	{
		481001,
		1,
		2,
		"1000000",
		"10:481001:500"
	},
	{
		481001,
		1,
		3,
		"5000000",
		"10:481001:500"
	},
	{
		481001,
		1,
		4,
		"10000000",
		"10:481001:500"
	},
	{
		481001,
		1,
		5,
		"50000000",
		"10:481001:500"
	},
	{
		481001,
		2,
		1,
		"500000",
		"10:481001:500"
	},
	{
		481001,
		2,
		2,
		"1000000",
		"10:481001:500"
	},
	{
		481001,
		2,
		3,
		"5000000",
		"10:481001:500"
	},
	{
		481001,
		2,
		4,
		"10000000",
		"10:481001:500"
	},
	{
		481001,
		2,
		5,
		"50000000",
		"10:481001:500"
	},
	{
		481001,
		3,
		1,
		"500000",
		"10:481001:500"
	},
	{
		481001,
		3,
		2,
		"1000000",
		"10:481001:500"
	},
	{
		481001,
		3,
		3,
		"5000000",
		"10:481001:500"
	},
	{
		481001,
		3,
		4,
		"10000000",
		"10:481001:500"
	},
	{
		481001,
		3,
		5,
		"50000000",
		"10:481001:500"
	},
	{
		481001,
		4,
		1,
		"500000",
		"10:481001:500"
	},
	{
		481001,
		4,
		2,
		"1000000",
		"10:481001:500"
	},
	{
		481001,
		4,
		3,
		"5000000",
		"10:481001:500"
	},
	{
		481001,
		4,
		4,
		"10000000",
		"10:481001:500"
	},
	{
		481001,
		4,
		5,
		"50000000",
		"10:481001:500"
	}
}
local t_saint_knight_expedition_boss_prize = {
	[481001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		}
	}
}

t_saint_knight_expedition_boss_prize.dataList = dataList

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

return t_saint_knight_expedition_boss_prize
