-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_stick_couplet_activity.lua

module("logicconfig.config.t_stick_couplet_activity", package.seeall)

local title = {
	normalTime = 7,
	normalPetIcon = 10,
	dailyGameTimes = 2,
	skinId = 14,
	firstStoryId = 12,
	wordHouse = 9,
	maxScore = 3,
	hardScore = 6,
	redPointId = 4,
	hardTime = 8,
	hardPetIcon = 11,
	normalScore = 5,
	activityId = 1,
	ruleKey = 13
}
local dataList = {
	{
		439001,
		2,
		100,
		637,
		10,
		20,
		60,
		100,
		"喜#气#洋#过#大#年#红#火",
		"img_15006_longzun",
		"img_15000_huiwu",
		4440001,
		"tieduilian_rule",
		12028
	}
}
local t_stick_couplet_activity = {
	[439001] = dataList[1]
}

t_stick_couplet_activity.dataList = dataList

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

return t_stick_couplet_activity
