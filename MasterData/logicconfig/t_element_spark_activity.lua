-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_activity.lua

module("logicconfig.config.t_element_spark_activity", package.seeall)

local title = {
	restTimeRange = 5,
	warEndTime = 4,
	jumpTo = 9,
	mapPlanId = 7,
	mapLvPlanId = 8,
	mapSize = 6,
	warStartTime = 3,
	registerEndTime = 2,
	activityId = 1
}
local dataList = {
	{
		311001,
		"2023-12-29T07:00:00",
		"2023-12-29T08:00:00",
		"2023-12-31T23:59:59",
		"00:00-08:00",
		{
			25,
			25
		},
		1,
		1,
		"func#191#17#17100"
	},
	{
		311002,
		"2024-01-12T07:00:00",
		"2024-01-12T08:00:00",
		"2024-01-14T23:59:59",
		"00:00-08:00",
		{
			25,
			25
		},
		1,
		1,
		"func#191#17#17100"
	}
}
local t_element_spark_activity = {
	[311001] = dataList[1],
	[311002] = dataList[2]
}

t_element_spark_activity.dataList = dataList

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

return t_element_spark_activity
