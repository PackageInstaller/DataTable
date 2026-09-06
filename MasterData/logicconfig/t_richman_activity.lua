-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_richman_activity.lua

module("logicconfig.config.t_richman_activity", package.seeall)

local title = {
	itemKey = 8,
	rankPlanId = 7,
	revengeBuffId = 5,
	mapPlan = 2,
	showbar = 9,
	revengeAddition = 6,
	redPointId = 10,
	campPlanId = 3,
	bPlanId = 4,
	activityId = 1
}
local dataList = {
	{
		230001,
		1,
		1,
		1,
		1,
		1000,
		1,
		"10:230001",
		"10:230001#104:2#8:1",
		430
	},
	{
		230002,
		1,
		2,
		1,
		1,
		1000,
		1,
		"10:230002",
		"10:230002#104:2#8:1",
		430
	}
}
local t_richman_activity = {
	[230001] = dataList[1],
	[230002] = dataList[2]
}

t_richman_activity.dataList = dataList

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

return t_richman_activity
