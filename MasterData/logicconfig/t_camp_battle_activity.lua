-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_activity.lua

module("logicconfig.config.t_camp_battle_activity", package.seeall)

local title = {
	inspireStartTime = 4,
	battleEndTime = 7,
	prizeEndTime = 9,
	inspireGameTimes = 14,
	groupId = 12,
	rankPrizePlanId = 19,
	selectStartTime = 2,
	coinDonateTimes = 13,
	finalPrizePlanId = 15,
	autoSelectStartTime = 10,
	gamePlanId = 17,
	storyId = 21,
	inspireEndTime = 5,
	autoSelectEndTime = 11,
	activityId = 1,
	prizeStartTime = 8,
	gameBuyPlanId = 18,
	battleStartTime = 6,
	animPath = 22,
	donateBuyPlanId = 20,
	shopID = 23,
	selectEndTime = 3,
	prizeViewPlanId = 16
}
local dataList = {
	{
		187001,
		"2022-09-02T05:00:00",
		"2022-09-03T04:59:59",
		"2022-09-03T05:00:00",
		"2022-09-09T04:59:59",
		"2022-09-09T05:00:00",
		"2022-09-15T04:59:59",
		"2022-09-15T05:00:00",
		"2022-09-16T04:59:59",
		"2022-09-03T05:00:00",
		"2022-09-15T04:59:59",
		1,
		3,
		3,
		1,
		1,
		1,
		1,
		1,
		1,
		4290019,
		"storyconfig/animations/dh_zhenyingzhizheng.txt",
		197001
	},
	{
		187002,
		"2022-09-16T05:00:00",
		"2022-09-17T04:59:59",
		"2022-09-17T05:00:00",
		"2022-09-23T04:59:59",
		"2022-09-23T05:00:00",
		"2022-09-29T04:59:59",
		"2022-09-29T05:00:00",
		"2022-09-30T05:00:00",
		"2022-09-17T05:00:00",
		"2022-09-29T04:59:59",
		1,
		3,
		3,
		2,
		2,
		2,
		2,
		2,
		2,
		4290019,
		"storyconfig/animations/dh_zhenyingzhizheng.txt",
		197001
	}
}
local t_camp_battle_activity = {
	[187001] = dataList[1],
	[187002] = dataList[2]
}

t_camp_battle_activity.dataList = dataList

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

return t_camp_battle_activity
