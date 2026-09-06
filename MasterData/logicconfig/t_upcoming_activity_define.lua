-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_upcoming_activity_define.lua

module("logicconfig.config.t_upcoming_activity_define", package.seeall)

local title = {
	progressPrizePlanId = 3,
	gainPrizeEndTime = 5,
	likeEndTime = 6,
	gainPrizeStartTime = 4,
	dailyPrizePlanId = 2,
	activityId = 1
}
local dataList = {
	{
		181001,
		1,
		1,
		"2022-08-26T05:00:00",
		"2022-09-02T05:00:00",
		"2022-09-02T05:00:00"
	},
	{
		181002,
		2,
		2,
		"2023-01-13T05:00:00",
		"2023-01-20T05:00:00",
		"2023-01-20T05:00:00"
	},
	{
		181003,
		1,
		1,
		"2023-01-13T05:00:00",
		"2023-03-03T05:00:00",
		"2023-03-03T05:00:00"
	},
	{
		181004,
		1,
		1,
		"2023-03-03T05:00:00",
		"2023-03-31T05:00:00",
		"2023-03-31T05:00:00"
	},
	{
		181005,
		3,
		3,
		"2023-04-21T05:00:00",
		"2023-04-28T05:00:00",
		"2023-04-28T05:00:00"
	},
	{
		181006,
		4,
		4,
		"2024-03-29T05:00:00",
		"2024-04-03T05:00:00",
		"2024-04-03T05:00:00"
	},
	{
		181007,
		5,
		5,
		"2024-09-20T05:00:00",
		"2024-09-27T05:00:00",
		"2024-09-27T05:00:00"
	},
	{
		181008,
		6,
		6,
		"2025-03-28T05:00:00",
		"2025-04-04T05:00:00",
		"2025-04-04T05:00:00"
	},
	{
		181009,
		6,
		6,
		"2025-03-28T05:00:00",
		"2025-04-04T05:00:00",
		"2025-04-04T05:00:00"
	},
	{
		181010,
		7,
		7,
		"2025-09-19T05:00:00",
		"2025-09-26T05:00:00",
		"2025-09-26T05:00:00"
	},
	{
		181011,
		8,
		8,
		"2026-03-27T05:00:00",
		"2026-04-03T05:00:00",
		"2026-04-03T05:00:00"
	},
	{
		181012,
		9,
		9,
		"2026-03-27T05:00:00",
		"2026-04-03T05:00:00",
		"2026-04-03T05:00:00"
	}
}
local t_upcoming_activity_define = {
	[181001] = dataList[1],
	[181002] = dataList[2],
	[181003] = dataList[3],
	[181004] = dataList[4],
	[181005] = dataList[5],
	[181006] = dataList[6],
	[181007] = dataList[7],
	[181008] = dataList[8],
	[181009] = dataList[9],
	[181010] = dataList[10],
	[181011] = dataList[11],
	[181012] = dataList[12]
}

t_upcoming_activity_define.dataList = dataList

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

return t_upcoming_activity_define
