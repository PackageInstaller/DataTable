-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_activity.lua

module("logicconfig.config.t_seek_food_activity", package.seeall)

local title = {
	comPlanId = 3,
	seekTimes = 2,
	activityId = 1,
	redPointId = 4
}
local dataList = {
	{
		282001,
		4,
		1,
		497
	}
}
local t_seek_food_activity = {
	[282001] = dataList[1]
}

t_seek_food_activity.dataList = dataList

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

return t_seek_food_activity
