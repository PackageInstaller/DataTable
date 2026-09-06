-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_market_prize_pool.lua

module("logicconfig.config.t_anniversary_market_prize_pool", package.seeall)

local title = {
	prizePoolId = 2,
	refreshPlanId = 4,
	prizePoolName = 5,
	prizePoolDesc = 6,
	refreshPrice = 3,
	activityId = 1,
	startTime = 7
}
local dataList = {
	{
		467001,
		1,
		500,
		1,
		"皮肤",
		"可以从多款皮肤当中随机抽取一个",
		"2025-04-11T05:00:00"
	},
	{
		467001,
		2,
		500,
		2,
		"精灵",
		"可以从多只精灵当中随机抽取一个",
		"2025-04-11T05:00:00"
	},
	{
		467001,
		3,
		500,
		3,
		"神钻",
		"可以获得随机数量神钻",
		"2025-04-11T05:00:00"
	},
	{
		467001,
		4,
		500,
		4,
		"道具",
		"可以从多个道具当中随机抽取一个",
		"2025-04-11T05:00:00"
	},
	{
		467002,
		1,
		500,
		5,
		"皮肤",
		"可以从多款皮肤当中随机抽取一个",
		"2025-11-28T05:00:00"
	},
	{
		467002,
		2,
		500,
		6,
		"精灵",
		"可以从多只精灵当中随机抽取一个",
		"2025-11-21T05:00:00"
	},
	{
		467002,
		3,
		500,
		7,
		"红星",
		"可以获得随机数量红星碎片",
		"2025-11-21T05:00:00"
	},
	{
		467002,
		4,
		500,
		8,
		"道具",
		"可以从多个道具当中随机抽取一个",
		"2025-11-21T05:00:00"
	},
	{
		467003,
		1,
		500,
		9,
		"皮肤",
		"可以从多款皮肤当中随机抽取一个",
		"2026-04-10T05:00:00"
	},
	{
		467003,
		2,
		500,
		10,
		"精灵",
		"可以从多只精灵当中随机抽取一个",
		"2026-04-10T05:00:00"
	},
	{
		467003,
		3,
		500,
		11,
		"神钻",
		"可以获得随机数量神钻",
		"2026-04-10T05:00:00"
	},
	{
		467003,
		4,
		500,
		12,
		"道具",
		"可以从多个道具当中随机抽取一个",
		"2026-04-10T05:00:00"
	},
	{
		467004,
		1,
		500,
		13,
		"皮肤",
		"可以从多款皮肤当中随机抽取一个",
		"2026-07-31T05:00:00"
	},
	{
		467004,
		2,
		500,
		14,
		"精灵",
		"可以从多只精灵当中随机抽取一个",
		"2026-07-31T05:00:00"
	},
	{
		467004,
		3,
		500,
		15,
		"道具",
		"可以从多个道具当中随机抽取一个",
		"2026-07-31T05:00:00"
	}
}
local t_anniversary_market_prize_pool = {
	[467001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[467002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[467003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[467004] = {
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_anniversary_market_prize_pool.dataList = dataList

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

return t_anniversary_market_prize_pool
