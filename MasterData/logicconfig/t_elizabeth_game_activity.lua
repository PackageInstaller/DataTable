-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elizabeth_game_activity.lua

module("logicconfig.config.t_elizabeth_game_activity", package.seeall)

local title = {
	clickDuration = 16,
	scalePrizePlanId = 7,
	ballAddVolumnPerClick = 13,
	prizePlanId = 8,
	raceId = 9,
	ballDottedLineVlumn = 18,
	redPointId = 2,
	ballSubVolumnPerSec = 15,
	mianViewSkinIdList = 20,
	gamePlanId = 4,
	dailyFreeGameTimes = 6,
	gameBuyTimesPlanId = 5,
	activityId = 1,
	onceGainMaxNum = 19,
	reviveCost = 17,
	storyId = 21,
	clickNums = 11,
	reviveTimeLimit = 3,
	ballMaxVolumn = 14,
	gameTime = 12,
	petRankPrize = 10
}
local dataList = {
	{
		341001,
		554,
		10,
		1,
		1,
		2,
		1,
		1,
		1,
		"14:24:1",
		1,
		10,
		"3.8:100",
		100,
		"2.5:100",
		"0.3",
		"105:178:30",
		92,
		200,
		"1032401#1601101#1009702#1600501",
		4600006
	},
	{
		341002,
		554,
		10,
		1,
		1,
		2,
		1,
		2,
		1,
		"14:24:1",
		1,
		10,
		"3.8:100",
		100,
		"2.5:100",
		"0.3",
		"105:178:30",
		92,
		200,
		"1032401#1601101#1009702#1600501",
		0
	}
}
local t_elizabeth_game_activity = {
	[341001] = dataList[1],
	[341002] = dataList[2]
}

t_elizabeth_game_activity.dataList = dataList

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

return t_elizabeth_game_activity
