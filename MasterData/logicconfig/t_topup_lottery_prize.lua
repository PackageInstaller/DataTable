-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_topup_lottery_prize.lua

module("logicconfig.config.t_topup_lottery_prize", package.seeall)

local title = {
	prizeId = 2,
	bigPrize = 4,
	prize = 3,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"4:36:10",
		1
	},
	{
		1,
		2,
		"4:31:10",
		1
	},
	{
		1,
		3,
		"4:111:10",
		1
	},
	{
		1,
		4,
		"8:1:100000",
		0
	},
	{
		1,
		5,
		"8:1:200000",
		0
	},
	{
		1,
		6,
		"8:1:200001",
		0
	},
	{
		1,
		7,
		"8:1:200002",
		0
	},
	{
		1,
		8,
		"8:1:200003",
		0
	},
	{
		1,
		9,
		"8:1:200004",
		0
	},
	{
		1,
		10,
		"8:1:200005",
		0
	},
	{
		1,
		11,
		"8:1:200006",
		0
	}
}
local t_topup_lottery_prize = {
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
		dataList[11]
	}
}

t_topup_lottery_prize.dataList = dataList

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

return t_topup_lottery_prize
