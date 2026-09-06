-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_works_display_activity.lua

module("logicconfig.config.t_fire_works_display_activity", package.seeall)

local title = {
	restTime = 9,
	timeShow = 10,
	criticalPlanId = 6,
	firstStoryld = 11,
	scenePlanId = 2,
	sceneTimePlanId = 3,
	worldProgressPrizePlanId = 5,
	dailyTimes = 7,
	worldProgressPlanId = 4,
	activityId = 1,
	normalPrizePlanId = 8
}
local dataList = {
	{
		145001,
		1,
		1,
		1,
		1,
		1,
		6,
		"1",
		"",
		"活动时间：04.15 5:00 - 04.29 5:00",
		""
	},
	{
		145002,
		1,
		1,
		2,
		2,
		1,
		6,
		"2",
		"",
		"活动时间:9.16 5:00-9.30 5:00",
		""
	},
	{
		145003,
		1,
		1,
		3,
		3,
		1,
		6,
		"3",
		"",
		"活动时间:4.14 5:00-4.28 5:00",
		""
	},
	{
		145004,
		1,
		1,
		3,
		4,
		1,
		6,
		"4",
		"",
		"活动时间:4.3 5:00-4.30 5:00",
		""
	},
	{
		145005,
		1,
		1,
		5,
		5,
		1,
		6,
		"5",
		"",
		"活动时间:1.28 5:00-2.28 5:00",
		"4760003"
	}
}
local t_fire_works_display_activity = {
	[145001] = dataList[1],
	[145002] = dataList[2],
	[145003] = dataList[3],
	[145004] = dataList[4],
	[145005] = dataList[5]
}

t_fire_works_display_activity.dataList = dataList

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

return t_fire_works_display_activity
