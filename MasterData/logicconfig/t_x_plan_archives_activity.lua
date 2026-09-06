-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_x_plan_archives_activity.lua

module("logicconfig.config.t_x_plan_archives_activity", package.seeall)

local title = {
	mats = 3,
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		378001,
		584,
		"10:378001#10:378002"
	}
}
local t_x_plan_archives_activity = {
	[378001] = dataList[1]
}

t_x_plan_archives_activity.dataList = dataList

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

return t_x_plan_archives_activity
