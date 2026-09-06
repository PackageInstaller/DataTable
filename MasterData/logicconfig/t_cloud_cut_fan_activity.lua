-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_activity.lua

module("logicconfig.config.t_cloud_cut_fan_activity", package.seeall)

local title = {
	dailyCraftCount = 3,
	costItem = 8,
	ruleKey = 7,
	skinId = 6,
	creepsMasterId = 5,
	activityId = 1,
	dailyClgCount = 2,
	repairCost = 4
}
local dataList = {
	{
		615001,
		3,
		5,
		"10:615001:50",
		1001,
		1404603,
		"caiyunshan_rule",
		"10:615002:10"
	}
}
local t_cloud_cut_fan_activity = {
	[615001] = dataList[1]
}

t_cloud_cut_fan_activity.dataList = dataList

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

return t_cloud_cut_fan_activity
