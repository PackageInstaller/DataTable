-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_activity.lua

module("logicconfig.config.t_unique_world_activity", package.seeall)

local title = {
	ruleKey = 7,
	dailyStartGameTimes = 2,
	redPointId = 3,
	jumpTo = 6,
	ruleId = 8,
	coinMatStr = 5,
	activityId = 1,
	gameId = 4
}
local dataList = {
	{
		584001,
		1,
		765,
		1,
		"1004:1612:1",
		{
			"func#1440",
			"ui#lottery"
		},
		"bieyoudongtian_rule",
		1
	}
}
local t_unique_world_activity = {
	[584001] = dataList[1]
}

t_unique_world_activity.dataList = dataList

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

return t_unique_world_activity
