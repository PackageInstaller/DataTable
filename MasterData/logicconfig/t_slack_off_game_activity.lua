-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_slack_off_game_activity.lua

module("logicconfig.config.t_slack_off_game_activity", package.seeall)

local title = {
	scaleVec3 = 9,
	shakeVec3 = 11,
	scaleTimes = 10,
	intervalTime = 6,
	gameSec = 3,
	redPointId = 4,
	targets = 5,
	dailyTimes = 2,
	duration = 7,
	activityId = 1,
	ruleKey = 8
}
local dataList = {
	{
		442001,
		3,
		45,
		666,
		"60#60",
		{
			6,
			8
		},
		{
			2,
			3
		},
		"rule_1",
		{
			1.1,
			1.1,
			1
		},
		0.1,
		{
			5,
			0,
			0
		}
	}
}
local t_slack_off_game_activity = {
	[442001] = dataList[1]
}

t_slack_off_game_activity.dataList = dataList

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

return t_slack_off_game_activity
