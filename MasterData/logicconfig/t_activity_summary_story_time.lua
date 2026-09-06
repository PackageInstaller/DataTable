-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_story_time.lua

module("logicconfig.config.t_activity_summary_story_time", package.seeall)

local title = {
	endTime = 4,
	storyId = 5,
	summaryId = 1,
	id = 2,
	startTime = 3
}
local dataList = {
	{
		17042,
		1,
		"2022-06-02T05:00:00",
		"2022-06-24T05:00:00",
		4270001
	},
	{
		17042,
		2,
		"2022-06-24T05:00:00",
		"2022-07-01T05:00:00",
		4270002
	},
	{
		17104,
		1,
		"2024-02-08T05:00:00",
		"2024-03-01T05:00:00",
		4270002
	},
	{
		17106,
		1,
		"2024-03-01T05:00:00",
		"2024-03-29T05:00:00",
		4620001
	}
}
local t_activity_summary_story_time = {
	[17042] = {
		dataList[1],
		dataList[2]
	},
	[17104] = {
		dataList[3]
	},
	[17106] = {
		dataList[4]
	}
}

t_activity_summary_story_time.dataList = dataList

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

return t_activity_summary_story_time
