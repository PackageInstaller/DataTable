-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_year_scratch_cycle.lua

module("logicconfig.config.t_year_scratch_cycle", package.seeall)

local title = {
	endTime = 4,
	loginDays = 6,
	needProgress = 7,
	cycleId = 2,
	weekGroupActivityId = 8,
	scratchTime = 5,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		356001,
		1,
		"2024-04-03T05:00:00",
		"2024-04-12T05:00:00",
		"2024-04-12T05:00:00",
		3,
		1200,
		287005
	},
	{
		356001,
		2,
		"2024-04-12T05:00:00",
		"2024-04-19T05:00:00",
		"2024-04-19T05:00:00",
		3,
		1200,
		287006
	},
	{
		356001,
		3,
		"2024-04-19T05:00:00",
		"2024-04-26T05:00:00",
		"2024-04-26T05:00:00",
		3,
		1200,
		287007
	}
}
local t_year_scratch_cycle = {
	[356001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_year_scratch_cycle.dataList = dataList

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

return t_year_scratch_cycle
