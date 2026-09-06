-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_activity.lua

module("logicconfig.config.t_annual_fuben_activity", package.seeall)

local title = {
	bossCreepsMaterId = 4,
	dailyClue = 3,
	wordProgressPlanId = 5,
	openTimeThree = 7,
	wordTotalTime = 8,
	bossProgressPlanId = 9,
	chapterTwoStoryId = 14,
	chapterThreeEndStoryId = 16,
	enterStoryId = 12,
	chapterOneStoryId = 13,
	redPointId = 2,
	faceId = 10,
	chapterThreeStoryId = 15,
	openTimeTwo = 6,
	activityId = 1,
	jumpTo = 11
}
local dataList = {
	{
		546001,
		747,
		5,
		301,
		1,
		"2025-12-26T05:00:00",
		"2026-01-01T05:00:00",
		86400,
		2,
		18031,
		"func#191#546#546001",
		4820037,
		4820038,
		4820048,
		4820049,
		4820050
	}
}
local t_annual_fuben_activity = {
	[546001] = dataList[1]
}

t_annual_fuben_activity.dataList = dataList

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

return t_annual_fuben_activity
