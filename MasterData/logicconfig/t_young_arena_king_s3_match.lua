-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_match.lua

module("logicconfig.config.t_young_arena_king_s3_match", package.seeall)

local title = {
	quaLevelPlanId = 5,
	endEarly = 3,
	closedTimeRange = 4,
	dailyGainScore = 11,
	stepId = 2,
	loseDecScore = 12,
	matchBaseScore = 10,
	rankScore3v3PlanId = 8,
	matchRatio = 9,
	matchScorePlanId = 6,
	buffPlanId = 15,
	rankScore1v1PlanId = 7,
	failPrize = 14,
	winPrize = 13,
	activityId = 1,
	stepName = 16
}
local dataList = {
	{
		624001,
		1,
		10,
		"",
		1,
		1,
		1,
		1,
		5,
		100,
		0,
		0,
		"10:624001:100",
		"10:624001:50",
		1,
		"战区预选赛"
	},
	{
		624001,
		2,
		10,
		"02:00:00-09:00:00",
		1,
		1,
		1,
		1,
		5,
		100,
		1000,
		50,
		"",
		"",
		2,
		"战区积分赛"
	},
	{
		624001,
		9999999,
		0,
		"",
		1,
		1,
		1,
		1,
		5,
		100,
		0,
		0,
		"10:624001:100",
		"10:624001:50",
		2,
		"娱乐赛"
	}
}
local t_young_arena_king_s3_match = {
	[624001] = {
		dataList[1],
		dataList[2],
		[9999999] = dataList[3]
	}
}

t_young_arena_king_s3_match.dataList = dataList

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

return t_young_arena_king_s3_match
