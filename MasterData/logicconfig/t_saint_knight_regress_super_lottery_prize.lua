-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_super_lottery_prize.lua

module("logicconfig.config.t_saint_knight_regress_super_lottery_prize", package.seeall)

local title = {
	id = 2,
	prize = 3,
	activityId = 1,
	pos = 4
}
local dataList = {
	{
		483001,
		1,
		"1004:1451:1",
		{
			54,
			-86
		}
	},
	{
		483001,
		2,
		"1004:1452:1",
		{
			147,
			-83
		}
	},
	{
		483001,
		3,
		"1004:1453:1",
		{
			147,
			-4
		}
	},
	{
		483001,
		4,
		"1004:1454:1",
		{
			-30.3,
			18
		}
	},
	{
		483001,
		5,
		"1004:1455:1",
		{
			64.6,
			7.9
		}
	},
	{
		483001,
		6,
		"1004:1456:1",
		{
			119.9,
			84.3
		}
	},
	{
		483001,
		7,
		"1004:1457:1",
		{
			-145.6,
			67.3
		}
	},
	{
		483001,
		8,
		"1004:1458:1",
		{
			15,
			95.3
		}
	}
}
local t_saint_knight_regress_super_lottery_prize = {
	[483001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_saint_knight_regress_super_lottery_prize.dataList = dataList

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

return t_saint_knight_regress_super_lottery_prize
