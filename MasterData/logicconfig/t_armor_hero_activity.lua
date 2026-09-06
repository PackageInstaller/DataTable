-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_activity.lua

module("logicconfig.config.t_armor_hero_activity", package.seeall)

local title = {
	progressId = 3,
	summonRedPointId = 6,
	sharePrize = 10,
	prizeOpenTime = 2,
	progressRedPointId = 7,
	taskDescPlanId = 12,
	taskPrize = 9,
	ruleKey = 13,
	bookPrize = 11,
	dailyClgTimes = 4,
	taskRedPointId = 8,
	activityId = 1,
	loginDays = 5
}
local dataList = {
	{
		540001,
		"2026-01-16T05:00:00",
		1,
		3,
		2,
		742,
		748,
		749,
		"4:400004:40",
		"104:2:188",
		"104:2:188",
		1,
		"armor_hero_rule"
	},
	{
		540002,
		"2026-05-29T05:00:00",
		1,
		3,
		4,
		742,
		748,
		749,
		"4:410002:1",
		"104:2:188",
		"104:2:188",
		1,
		"armor_hero_rule"
	}
}
local t_armor_hero_activity = {
	[540001] = dataList[1],
	[540002] = dataList[2]
}

t_armor_hero_activity.dataList = dataList

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

return t_armor_hero_activity
