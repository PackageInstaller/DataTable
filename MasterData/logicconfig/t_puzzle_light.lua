-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_puzzle_light.lua

module("logicconfig.config.t_puzzle_light", package.seeall)

local title = {
	cost = 7,
	finalPrize = 3,
	bubbleDesc = 9,
	prizePlanId = 2,
	awardDesc = 10,
	finalPrizeTime = 4,
	taskActivityId = 12,
	timeDesc = 8,
	shopId = 5,
	dailyActive = 6,
	icon = 11,
	activityId = 1
}
local dataList = {
	{
		122003,
		1,
		"17:1009703:-1:1",
		nil,
		86029,
		{
			30,
			60,
			90,
			120
		},
		"8:1:1000",
		"活动时间:11.18 5:00-11.25 5:00",
		"奥奇，感谢你的一路相伴~",
		"小末Q版皮肤·鸡腿自由",
		"board_dlwl_13",
		0
	},
	{
		122004,
		1,
		"17:1009703:-1:1",
		nil,
		86029,
		{
			30,
			60,
			90,
			120
		},
		"8:1:1000",
		"活动时间:11.18 5:00-11.25 5:00",
		"奥奇，感谢你的一路相伴~",
		"小末Q版皮肤·鸡腿自由",
		"board_dlwl_13",
		0
	},
	{
		122005,
		2,
		"17:1009703:-1:1",
		"2025-10-28T21:30:00",
		86029,
		{
			30,
			60,
			90,
			120
		},
		"8:1:1000",
		"活动时间:11.17 5:00-12.22 5:00",
		"奥奇，我在生日会等你！要来和我一起做蛋糕噢~",
		"奇迹糕坊·诺亚",
		"board_ganxieyouni_01",
		0
	},
	{
		122006,
		3,
		"",
		"2025-10-28T21:30:00",
		86029,
		nil,
		"10:122006:3",
		"活动时间:10月24日5:00-11月21日5:00",
		"奥奇，画中世界被破坏了，快来一起修补好把！",
		"奇迹糕坊·诺亚",
		"board_mkhhsj_01",
		122006
	}
}
local t_puzzle_light = {
	[122003] = dataList[1],
	[122004] = dataList[2],
	[122005] = dataList[3],
	[122006] = dataList[4]
}

t_puzzle_light.dataList = dataList

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

return t_puzzle_light
