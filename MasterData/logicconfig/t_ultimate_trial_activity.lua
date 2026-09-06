-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_trial_activity.lua

module("logicconfig.config.t_ultimate_trial_activity", package.seeall)

local title = {
	jumpStrOne = 5,
	activityId = 1,
	jumpRedIdThree = 10,
	jumpStrThree = 7,
	jumpStrTwo = 6,
	jumpRedIdTwo = 9,
	signInBuffPlanId = 3,
	jumpRedIdOne = 8,
	ruleKeyMain = 4,
	rankPrizeMpId = 2
}
local dataList = {
	{
		472001,
		324,
		1,
		"ultimatetrialmainview_rule",
		"ui#ultimatetrialrankfatherview",
		"ui#commongrouptaskmainview#472001",
		"func#191#472#472001",
		"",
		"474",
		""
	}
}
local t_ultimate_trial_activity = {
	[472001] = dataList[1]
}

t_ultimate_trial_activity.dataList = dataList

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

return t_ultimate_trial_activity
