-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_wen_explore_prize.lua

module("logicconfig.config.t_ling_wen_explore_prize", package.seeall)

local title = {
	id = 1,
	range = 2,
	endPrize = 4,
	normalPrize = 3
}
local dataList = {
	{
		1,
		{
			13,
			13
		},
		"8:1:31250",
		"9:80036:5#4:30006:8#4:30005:2"
	},
	{
		2,
		{
			12,
			12
		},
		"8:1:29680",
		"9:80038:5#4:30006:8"
	},
	{
		3,
		{
			11,
			11
		},
		"8:1:28125",
		"9:80039:5#4:30006:7#4:30005:3"
	},
	{
		4,
		{
			10,
			10
		},
		"8:1:26560",
		"9:80040:5#4:30006:7#4:30005:1"
	},
	{
		5,
		{
			9,
			9
		},
		"8:1:25000",
		"9:80041:5#4:30006:6#4:30005:3"
	},
	{
		6,
		{
			8,
			8
		},
		"8:1:23440",
		"9:80042:5#4:30006:5#4:30005:3"
	},
	{
		7,
		{
			7,
			7
		},
		"8:1:21875",
		"9:80043:5#4:30006:4#4:30005:3"
	},
	{
		8,
		{
			6,
			6
		},
		"8:1:20310",
		"9:80044:5#4:30006:3#4:30005:4"
	},
	{
		9,
		{
			5,
			5
		},
		"8:1:18750",
		"9:80045:5#4:30006:3"
	},
	{
		10,
		{
			4,
			4
		},
		"8:1:17180",
		"9:80046:5#4:30005:12"
	},
	{
		11,
		{
			3,
			3
		},
		"8:1:15625",
		"9:80047:5#4:30005:8"
	},
	{
		12,
		{
			2,
			2
		},
		"8:1:14060",
		"9:80048:5#4:30005:5"
	},
	{
		13,
		{
			1,
			1
		},
		"8:1:12500",
		"9:80049:5#4:30005:3"
	}
}
local t_ling_wen_explore_prize = {
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
	dataList[13]
}

t_ling_wen_explore_prize.dataList = dataList

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

return t_ling_wen_explore_prize
