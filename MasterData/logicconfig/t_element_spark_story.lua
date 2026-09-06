-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_story.lua

module("logicconfig.config.t_element_spark_story", package.seeall)

local title = {
	stageId = 2,
	storyId = 5,
	winStoryId = 6,
	endTime = 4,
	noCampStoryId = 7,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		311001,
		1,
		"2023-12-22T05:00:00",
		"2023-12-29T07:59:59",
		4590001,
		0,
		0
	},
	{
		311001,
		2,
		"2023-12-29T08:00:00",
		"2023-12-31T23:59:59",
		4590002,
		0,
		0
	},
	{
		311001,
		3,
		"2024-01-01T00:00:00",
		"2024-01-05T04:59:59",
		0,
		4590003,
		4590004
	},
	{
		311002,
		1,
		"2024-01-05T05:00:00",
		"2024-01-12T07:59:59",
		4590005,
		0,
		0
	},
	{
		311002,
		2,
		"2024-01-12T08:00:00",
		"2024-01-14T23:59:59",
		4590006,
		0,
		0
	},
	{
		311002,
		3,
		"2024-01-15T00:00:00",
		"2024-01-19T04:59:59",
		0,
		4590007,
		4590008
	}
}
local t_element_spark_story = {
	[311001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[311002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_element_spark_story.dataList = dataList

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

return t_element_spark_story
