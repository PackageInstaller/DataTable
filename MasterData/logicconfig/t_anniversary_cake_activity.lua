-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_cake_activity.lua

module("logicconfig.config.t_anniversary_cake_activity", package.seeall)

local title = {
	addPipeCost = 10,
	dailyAddPipeTimes = 11,
	eatCakePrizePlan = 8,
	maxEatCakeCount = 7,
	personalPrizePlan = 3,
	eatCakeTimesLimit = 6,
	eatCakeWorldPrizePlan = 9,
	makeCakeStagePlan = 2,
	eatCakeStartTime = 5,
	activityId = 1,
	worldPrizePlan = 4
}
local dataList = {
	{
		140001,
		1,
		2,
		1,
		"2023-03-15T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140002,
		2,
		5,
		1,
		"2023-03-15T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140003,
		3,
		6,
		1,
		"2023-10-01T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140004,
		4,
		7,
		1,
		"2023-10-01T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140005,
		5,
		8,
		1,
		"2024-06-28T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140006,
		6,
		9,
		1,
		"2024-12-20T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140007,
		7,
		10,
		1,
		"2025-02-28T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	},
	{
		140008,
		8,
		11,
		1,
		"2026-04-03T05:00:00",
		2,
		50,
		4,
		3,
		"105:6013:50",
		5
	}
}
local t_anniversary_cake_activity = {
	[140001] = dataList[1],
	[140002] = dataList[2],
	[140003] = dataList[3],
	[140004] = dataList[4],
	[140005] = dataList[5],
	[140006] = dataList[6],
	[140007] = dataList[7],
	[140008] = dataList[8]
}

t_anniversary_cake_activity.dataList = dataList

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

return t_anniversary_cake_activity
