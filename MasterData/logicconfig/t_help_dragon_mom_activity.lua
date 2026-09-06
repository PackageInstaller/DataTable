-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_help_dragon_mom_activity.lua

module("logicconfig.config.t_help_dragon_mom_activity", package.seeall)

local title = {
	playerRewardPlanId = 6,
	clickThreshold = 4,
	scoreAddPlanId = 5,
	maxScore = 3,
	countdown = 9,
	costItem = 2,
	playEndTime = 8,
	worldRewardPlanId = 7,
	activityId = 1
}
local dataList = {
	{
		160001,
		"10:160001:300",
		300,
		1,
		1,
		1,
		1,
		"2022-06-24T05:00:00",
		5
	}
}
local t_help_dragon_mom_activity = {
	[160001] = dataList[1]
}

t_help_dragon_mom_activity.dataList = dataList

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

return t_help_dragon_mom_activity
