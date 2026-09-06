-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_activity.lua

module("logicconfig.config.t_king_ciyuan_activity", package.seeall)

local title = {
	bossChallengeTime = 3,
	bossPlanId = 6,
	extTagPlan = 5,
	extPlanId = 4,
	extChallengeTime = 2,
	redPointId = 7,
	activityId = 1
}
local dataList = {
	{
		241001,
		"2023-01-20T05:00:00",
		"2034-12-31T05:00:00",
		1,
		1,
		1,
		444
	}
}
local t_king_ciyuan_activity = {
	[241001] = dataList[1]
}

t_king_ciyuan_activity.dataList = dataList

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

return t_king_ciyuan_activity
