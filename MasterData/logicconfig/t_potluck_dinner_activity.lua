-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_potluck_dinner_activity.lua

module("logicconfig.config.t_potluck_dinner_activity", package.seeall)

local title = {
	lanternId = 2,
	redPointId = 3,
	activityId = 1,
	timeDesc = 4
}
local dataList = {
	{
		196001,
		44,
		-287,
		"活动时间:9.30 5:00-10.14 5:00"
	}
}
local t_potluck_dinner_activity = {
	[196001] = dataList[1]
}

t_potluck_dinner_activity.dataList = dataList

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

return t_potluck_dinner_activity
