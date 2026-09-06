-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_group_activity.lua

module("logicconfig.config.t_brother_group_activity", package.seeall)

local title = {
	itemKey = 3,
	hudPlanId = 4,
	activityId = 1,
	personPrizePlan = 2
}
local dataList = {
	{
		209001,
		1,
		"10:209001",
		1
	}
}
local t_brother_group_activity = {
	[209001] = dataList[1]
}

t_brother_group_activity.dataList = dataList

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

return t_brother_group_activity
