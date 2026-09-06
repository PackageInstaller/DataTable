-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkage_lottery_rand.lua

module("logicconfig.config.t_linkage_lottery_rand", package.seeall)

local title = {
	lotteryId = 2,
	lotteryPlanId = 1,
	prize = 3,
	isBigPrize = 4
}
local dataList = {
	{
		1,
		1,
		"17:1032204:-1:1",
		1
	},
	{
		1,
		2,
		"4:40008:1",
		0
	},
	{
		1,
		3,
		"4:36:5",
		0
	},
	{
		1,
		4,
		"4:31:5",
		0
	},
	{
		1,
		5,
		"8:1:500000",
		0
	},
	{
		1,
		6,
		"4:30003:80",
		0
	},
	{
		1,
		7,
		"4:503:75",
		0
	},
	{
		2,
		1,
		"17:1400101:-1:1",
		1
	},
	{
		2,
		2,
		"4:40008:1",
		0
	},
	{
		2,
		3,
		"4:30006:28",
		0
	},
	{
		2,
		4,
		"4:510022:1",
		0
	},
	{
		2,
		5,
		"8:1:500000",
		0
	},
	{
		2,
		6,
		"4:30003:80",
		0
	},
	{
		2,
		7,
		"4:503:75",
		0
	}
}
local t_linkage_lottery_rand = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_linkage_lottery_rand.dataList = dataList

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

return t_linkage_lottery_rand
