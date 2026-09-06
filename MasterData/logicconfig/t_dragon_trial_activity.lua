-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_activity.lua

module("logicconfig.config.t_dragon_trial_activity", package.seeall)

local title = {
	dreamTrialFreeTimes = 5,
	dreamTrialBuyTimesPlan = 6,
	dreamTrialId = 4,
	dragonTrialFreeTimes = 9,
	dragonTrialBuyTimesPlan = 10,
	secondTrialDayInterval = 11,
	dragonTrialId = 8,
	dreamTrialPetPlan = 7,
	firstTrialId = 2,
	activityId = 1,
	firstTrialPetPlan = 3
}
local dataList = {
	{
		108001,
		1,
		1,
		2,
		4,
		1,
		2,
		3,
		4,
		2,
		1
	},
	{
		108002,
		1,
		1,
		2,
		4,
		1,
		2,
		3,
		4,
		2,
		1
	}
}
local t_dragon_trial_activity = {
	[108001] = dataList[1],
	[108002] = dataList[2]
}

t_dragon_trial_activity.dataList = dataList

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

return t_dragon_trial_activity
