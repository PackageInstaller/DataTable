-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_activity.lua

module("logicconfig.config.t_goddess_activity", package.seeall)

local title = {
	gamePlanId = 3,
	chatRedPointId = 6,
	flowerPlanId = 4,
	touchPlanId = 2,
	prizeRedPointId = 7,
	activityId = 1,
	chatPlanId = 5
}
local dataList = {
	{
		121001,
		1,
		1,
		1,
		1,
		209,
		210
	}
}
local t_goddess_activity = {
	[121001] = dataList[1]
}

t_goddess_activity.dataList = dataList

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

return t_goddess_activity
