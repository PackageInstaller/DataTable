-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fee_skin.lua

module("logicconfig.config.t_annual_fee_skin", package.seeall)

local title = {
	buyCost = 6,
	lotteryCost = 4,
	turn = 12,
	prizePlanId = 3,
	extraPrize = 11,
	lotteryCoupon = 5,
	buyLimit = 8,
	prizeId = 9,
	lotteryItem = 7,
	lotteryPlanId = 2,
	activityId = 1,
	startTime = 10
}
local dataList = {
	{
		8002,
		1,
		1,
		"204:100001:48",
		"",
		"",
		"",
		15,
		8,
		"2022-01-07T05:00:00",
		"8:1:1000",
		1
	},
	{
		8003,
		2,
		2,
		"204:100001:52",
		"4:90341:1",
		"",
		"",
		15,
		8,
		"2022-12-30T05:00:00",
		"8:1:1000",
		1
	},
	{
		8004,
		3,
		3,
		"204:100001:52",
		"4:90429:1",
		"",
		"",
		15,
		8,
		"2024-01-01T05:00:00",
		"8:1:1000",
		2
	},
	{
		8005,
		4,
		4,
		"204:100001:52",
		"4:510409:1",
		"",
		"",
		15,
		8,
		"2025-01-01T05:00:00",
		"8:1:1000",
		3
	},
	{
		8006,
		5,
		5,
		"204:100001:66",
		"4:510671:1",
		"",
		"",
		15,
		8,
		"2026-01-01T05:00:00",
		"8:1:1000",
		1
	}
}
local t_annual_fee_skin = {
	[8002] = dataList[1],
	[8003] = dataList[2],
	[8004] = dataList[3],
	[8005] = dataList[4],
	[8006] = dataList[5]
}

t_annual_fee_skin.dataList = dataList

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

return t_annual_fee_skin
