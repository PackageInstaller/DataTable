-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_topup_lottery_lottery.lua

module("logicconfig.config.t_topup_lottery_lottery", package.seeall)

local title = {
	lotteryTime = 2,
	lotteryPlanId = 1,
	randPlanId = 3
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		1
	},
	{
		1,
		3,
		1
	},
	{
		1,
		4,
		1
	},
	{
		1,
		5,
		2
	},
	{
		1,
		6,
		1
	},
	{
		1,
		7,
		1
	},
	{
		1,
		8,
		1
	},
	{
		1,
		9,
		1
	},
	{
		1,
		10,
		2
	},
	{
		1,
		11,
		1
	},
	{
		1,
		12,
		1
	},
	{
		1,
		13,
		1
	},
	{
		1,
		14,
		1
	},
	{
		1,
		15,
		2
	}
}
local t_topup_lottery_lottery = {
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

t_topup_lottery_lottery.dataList = dataList

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

return t_topup_lottery_lottery
