-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mirror_trial_activity.lua

module("logicconfig.config.t_mirror_trial_activity", package.seeall)

local title = {
	buyScoreCost = 3,
	dailyBuyTimeLimit = 5,
	allowBuyRelativeDays = 6,
	payGoodsId = 2,
	showEnergy = 8,
	prizePlanId = 7,
	activityId = 1,
	buyScoreAdd = 4
}
local dataList = {
	{
		51001,
		"rmb_30",
		"105:179:50",
		10,
		10,
		7,
		1,
		"66:2"
	}
}
local t_mirror_trial_activity = {
	[51001] = dataList[1]
}

t_mirror_trial_activity.dataList = dataList

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

return t_mirror_trial_activity
