-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fishing_game_activity.lua

module("logicconfig.config.t_fishing_game_activity", package.seeall)

local title = {
	maxScoreLimit = 3,
	ruleKeyImg = 6,
	gamePlanId = 4,
	dailyTimes = 2,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		607001,
		3,
		999999,
		1001,
		"fishinggamemainview_rule",
		"fishing_game_pic_rule_1"
	}
}
local t_fishing_game_activity = {
	[607001] = dataList[1]
}

t_fishing_game_activity.dataList = dataList

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

return t_fishing_game_activity
