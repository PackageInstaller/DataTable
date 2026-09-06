-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_investor_prize.lua

module("logicconfig.config.t_angel_investor_prize", package.seeall)

local title = {
	prizeId = 2,
	prizeMpKey = 4,
	activityId = 1,
	type = 7,
	maxGainLimit = 5,
	unlockLv = 3,
	payGainLimit = 6
}
local dataList = {
	{
		588001,
		1,
		2,
		"4:30006",
		400,
		520,
		1
	},
	{
		588001,
		2,
		1,
		"60:1",
		20000,
		26000,
		1
	},
	{
		588001,
		3,
		1,
		"8:1",
		50000000,
		65000000,
		1
	},
	{
		588001,
		4,
		1,
		"4:7008",
		200,
		260,
		1
	},
	{
		588001,
		5,
		1,
		"4:36",
		60,
		78,
		1
	},
	{
		588001,
		6,
		3,
		"4:400004",
		100,
		200,
		1
	},
	{
		588001,
		7,
		1,
		"4:400002",
		600,
		780,
		1
	},
	{
		588001,
		8,
		1,
		"4:92002",
		56,
		73,
		2
	},
	{
		588001,
		9,
		1,
		"4:2001",
		770,
		1001,
		2
	},
	{
		588001,
		10,
		1,
		"4:901",
		100000,
		130000,
		2
	},
	{
		588001,
		11,
		1,
		"4:100000",
		600,
		780,
		2
	},
	{
		588001,
		12,
		1,
		"4:92003",
		42,
		55,
		2
	},
	{
		588001,
		13,
		1,
		"4:2002",
		560,
		728,
		2
	},
	{
		588001,
		14,
		1,
		"4:902",
		700,
		910,
		2
	},
	{
		588001,
		15,
		1,
		"4:92004",
		14,
		19,
		2
	},
	{
		588001,
		16,
		1,
		"4:2003",
		350,
		455,
		2
	},
	{
		588001,
		17,
		1,
		"8:16",
		10000,
		13000,
		3
	},
	{
		588001,
		18,
		1,
		"8:27",
		4000,
		5200,
		3
	},
	{
		588001,
		19,
		1,
		"8:20",
		15000,
		19500,
		3
	},
	{
		588001,
		20,
		1,
		"4:11003",
		50000,
		65000,
		3
	},
	{
		588001,
		21,
		1,
		"8:5",
		10000,
		13000,
		3
	},
	{
		588001,
		22,
		1,
		"8:3",
		10000,
		13000,
		3
	},
	{
		588001,
		23,
		1,
		"8:10",
		10000,
		13000,
		3
	},
	{
		588001,
		24,
		2,
		"8:22",
		7500,
		9750,
		3
	},
	{
		588001,
		25,
		3,
		"8:25",
		2400,
		3600,
		3
	}
}
local t_angel_investor_prize = {
	[588001] = {
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_angel_investor_prize.dataList = dataList

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

return t_angel_investor_prize
