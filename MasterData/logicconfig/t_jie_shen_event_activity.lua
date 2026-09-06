-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jie_shen_event_activity.lua

module("logicconfig.config.t_jie_shen_event_activity", package.seeall)

local title = {
	storyId = 7,
	informerCount = 3,
	redPointId = 4,
	dailyViewTimes = 2,
	raceId = 6,
	relationshipActId = 5,
	activityId = 1,
	gameRuleKey = 8
}
local dataList = {
	{
		397001,
		6,
		3,
		601,
		129006,
		"80013",
		4700001,
		"jie_shen_game_rule"
	}
}
local t_jie_shen_event_activity = {
	[397001] = dataList[1]
}

t_jie_shen_event_activity.dataList = dataList

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

return t_jie_shen_event_activity
