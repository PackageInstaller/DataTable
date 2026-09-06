-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_step.lua

module("logicconfig.config.t_goddess_trial_step", package.seeall)

local title = {
	bossId = 9,
	endTime = 4,
	superTrialPlanId = 7,
	rankPrizePlanId = 10,
	stepId = 2,
	normalTrialPlanId = 6,
	systemPetPlanId = 5,
	superTrialScorePlanId = 8,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		574001,
		1,
		"2026-03-13T05:00:00",
		"2026-03-20T05:00:00",
		1,
		1,
		1,
		1,
		1,
		1
	},
	{
		574001,
		2,
		"2026-03-20T05:00:00",
		"2026-03-27T05:00:00",
		1,
		2,
		2,
		1,
		2,
		1
	},
	{
		574001,
		3,
		"2026-03-27T05:00:00",
		"2026-04-03T05:00:00",
		1,
		3,
		3,
		1,
		3,
		1
	}
}
local t_goddess_trial_step = {
	[574001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_goddess_trial_step.dataList = dataList

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

return t_goddess_trial_step
