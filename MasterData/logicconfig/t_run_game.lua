-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run_game.lua

module("logicconfig.config.t_run_game", package.seeall)

local title = {
	statePlanId = 7,
	openTime = 11,
	dailyGameTimes = 6,
	gameReadyTime = 2,
	prizePlanId = 9,
	gameMinEndTime = 4,
	labelPlanId = 10,
	gameMaxEndTime = 5,
	blessWordPlanId = 8,
	activityId = 1,
	gameEndTime = 3
}
local dataList = {
	{
		228001,
		30,
		60,
		35,
		60,
		3,
		1,
		1,
		1,
		0,
		"2022-12-30 至 01-06 05:00:00"
	},
	{
		228002,
		30,
		60,
		35,
		60,
		3,
		2,
		2,
		2,
		1,
		"2024-03-15 05:00:00至 03-29 05:00:00"
	},
	{
		228003,
		30,
		60,
		35,
		60,
		3,
		1,
		3,
		3,
		0,
		"2024-12-20 05:00:00至 2025-01-29 05:00:00"
	},
	{
		228004,
		30,
		60,
		35,
		60,
		3,
		2,
		4,
		4,
		0,
		"2025-10-31 05:00:00至 2025-11-21 05:00:00"
	}
}
local t_run_game = {
	[228001] = dataList[1],
	[228002] = dataList[2],
	[228003] = dataList[3],
	[228004] = dataList[4]
}

t_run_game.dataList = dataList

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

return t_run_game
