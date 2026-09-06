-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_age_launch_activity.lua

module("logicconfig.config.t_origin_age_launch_activity", package.seeall)

local title = {
	progressId = 4,
	templateId = 5,
	redPointId = 3,
	oldPlayerRegisterDays = 2,
	activityId = 1
}
local dataList = {
	{
		532001,
		30,
		737,
		1,
		90
	}
}
local t_origin_age_launch_activity = {
	[532001] = dataList[1]
}

t_origin_age_launch_activity.dataList = dataList

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

return t_origin_age_launch_activity
