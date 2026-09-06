-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_recharge_personal_prize.lua

module("logicconfig.config.t_group_recharge_personal_prize", package.seeall)

local title = {
	showId = 5,
	consumeMoney = 3,
	id = 2,
	planId = 1,
	gift = 4
}
local dataList = {
	{
		1,
		1,
		6,
		"4:31:5#4:36:5#4:112:1",
		6
	},
	{
		1,
		2,
		12,
		"4:31:10#4:36:5#4:112:1",
		6
	},
	{
		1,
		3,
		30,
		"4:90282:1#4:36:5#4:112:1",
		7
	},
	{
		1,
		4,
		68,
		"4:90282:1#4:36:5#4:112:1",
		8
	},
	{
		1,
		5,
		98,
		"4:90284:1#4:36:10#4:112:3",
		9
	},
	{
		1,
		6,
		148,
		"4:90282:1#4:36:10#4:112:3",
		10
	},
	{
		1,
		7,
		198,
		"4:90273:1#4:36:10#4:112:3",
		11
	},
	{
		1,
		8,
		248,
		"18:404:1#4:36:10#4:112:3",
		12
	},
	{
		1,
		9,
		288,
		"4:90282:1#4:36:10#4:112:3",
		13
	},
	{
		1,
		10,
		328,
		"18:403:1#4:36:10#4:112:3",
		14
	},
	{
		1,
		11,
		368,
		"4:70003:1#4:36:10#4:112:3",
		15
	},
	{
		1,
		12,
		428,
		"4:90145:1#4:36:10#4:112:3",
		15
	},
	{
		1,
		13,
		488,
		"18:410:1#4:36:10#4:112:3",
		15
	},
	{
		1,
		14,
		548,
		"4:70003:1#4:36:10#4:112:3",
		15
	},
	{
		1,
		15,
		648,
		"4:90236:1#4:36:10#4:112:3",
		15
	}
}
local t_group_recharge_personal_prize = {
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
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_group_recharge_personal_prize.dataList = dataList

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

return t_group_recharge_personal_prize
