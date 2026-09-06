-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_activity.lua

module("logicconfig.config.t_canton_opera_road_activity", package.seeall)

local title = {
	energyId = 2,
	pvProgressPlanId = 4,
	activityId = 1,
	planId = 5,
	pvPrize = 6,
	resKey = 8,
	bossProgressPlanId = 3,
	ruleKey = 7
}
local dataList = {
	{
		189001,
		5,
		1,
		1,
		1,
		"10:17017:100",
		"YuejuRoad_rule",
		"10:17017:1"
	}
}
local t_canton_opera_road_activity = {
	[189001] = dataList[1]
}

t_canton_opera_road_activity.dataList = dataList

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

return t_canton_opera_road_activity
