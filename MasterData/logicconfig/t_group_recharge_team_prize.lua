-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_recharge_team_prize.lua

module("logicconfig.config.t_group_recharge_team_prize", package.seeall)

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
		30,
		"4:30006:20#104:2:200#8:1:100000",
		6
	},
	{
		1,
		2,
		68,
		"4:30006:20#104:2:200#8:1:100000",
		6
	},
	{
		1,
		3,
		148,
		"4:90284:1#104:2:200#8:1:100000",
		7
	},
	{
		1,
		4,
		248,
		"4:30006:20#1:300027:-1:1#8:1:100000",
		8
	},
	{
		1,
		5,
		328,
		"4:510022:1#104:2:200#8:1:100000",
		9
	},
	{
		1,
		6,
		408,
		"4:30006:20#104:2:200#8:1:100000",
		10
	},
	{
		1,
		7,
		488,
		"4:90284:1#104:2:200#8:1:100000",
		11
	},
	{
		1,
		8,
		648,
		"4:30006:20#104:2:200#8:1:100000",
		12
	},
	{
		1,
		9,
		788,
		"4:510022:1#104:2:200#8:1:100000",
		13
	},
	{
		1,
		10,
		988,
		"4:30006:20#104:2:200#8:1:100000",
		14
	},
	{
		1,
		11,
		1188,
		"4:90284:1#104:2:200#8:1:100000",
		15
	},
	{
		1,
		12,
		1288,
		"4:30006:20#104:2:200#8:1:100000",
		15
	},
	{
		1,
		13,
		1488,
		"4:510022:1#104:2:200#8:1:100000",
		15
	},
	{
		1,
		14,
		1688,
		"4:30006:20#104:2:200#8:1:100000",
		15
	},
	{
		1,
		15,
		1888,
		"4:510022:1#104:2:200#8:1:100000",
		15
	}
}
local t_group_recharge_team_prize = {
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

t_group_recharge_team_prize.dataList = dataList

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

return t_group_recharge_team_prize
