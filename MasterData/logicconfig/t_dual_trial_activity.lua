-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_trial_activity.lua

module("logicconfig.config.t_dual_trial_activity", package.seeall)

local title = {
	dailyVisitTimes = 2,
	redPointId = 3,
	hangingTime = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		468001,
		3,
		687,
		90,
		"dual_trial_activity_rule"
	}
}
local t_dual_trial_activity = {
	[468001] = dataList[1]
}

t_dual_trial_activity.dataList = dataList

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

return t_dual_trial_activity
