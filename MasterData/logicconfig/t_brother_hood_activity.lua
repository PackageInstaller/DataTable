-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_hood_activity.lua

module("logicconfig.config.t_brother_hood_activity", package.seeall)

local title = {
	plotPlanReward = 3,
	activityId = 1,
	redPointId = 7,
	physicalCostPlanId = 5,
	rules = 6,
	plotPlan = 2,
	energy = 4
}
local dataList = {
	{
		214001,
		{
			1,
			2,
			3,
			4,
			5
		},
		1,
		"66:6",
		1,
		"",
		369
	},
	{
		214002,
		{
			6
		},
		1,
		"66:8",
		1,
		"",
		369
	}
}
local t_brother_hood_activity = {
	[214001] = dataList[1],
	[214002] = dataList[2]
}

t_brother_hood_activity.dataList = dataList

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

return t_brother_hood_activity
