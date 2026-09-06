-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_activity.lua

module("logicconfig.config.t_goddess_trial_activity", package.seeall)

local title = {
	showRaceId = 5,
	redPointId = 2,
	superStageScoreGender = 4,
	activityId = 1,
	dailyBossTimes = 3
}
local dataList = {
	{
		574001,
		761,
		5,
		"1",
		11036
	}
}
local t_goddess_trial_activity = {
	[574001] = dataList[1]
}

t_goddess_trial_activity.dataList = dataList

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

return t_goddess_trial_activity
