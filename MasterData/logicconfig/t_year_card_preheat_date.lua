-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_year_card_preheat_date.lua

module("logicconfig.config.t_year_card_preheat_date", package.seeall)

local title = {
	preheatview = 5,
	endTime = 4,
	perheatId = 2,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		8001,
		1001,
		"2021-12-17T05:00:00",
		"2021-12-24T05:00:00",
		"yearcardpreheathudview"
	},
	{
		8002,
		1001,
		"2021-12-24T05:00:00",
		"2021-12-31T05:00:00",
		"yearcardpreheathudview"
	},
	{
		8003,
		1002,
		"2022-12-23T05:00:00",
		"2022-12-30T05:00:00",
		"yearcardpreheathud2023view"
	},
	{
		8004,
		1003,
		"2023-12-22T05:00:00",
		"2024-01-01T05:00:00",
		"yearcardpreheathud2024view"
	},
	{
		8005,
		1004,
		"2024-12-20T05:00:00",
		"2025-01-01T05:00:00",
		"yearcardpreheathud2025view"
	},
	{
		8006,
		1005,
		"2025-12-19T05:00:00",
		"2026-01-01T05:00:00",
		"yearcardpreheathud2026view"
	}
}
local t_year_card_preheat_date = {
	[8001] = {
		[1001] = dataList[1]
	},
	[8002] = {
		[1001] = dataList[2]
	},
	[8003] = {
		[1002] = dataList[3]
	},
	[8004] = {
		[1003] = dataList[4]
	},
	[8005] = {
		[1004] = dataList[5]
	},
	[8006] = {
		[1005] = dataList[6]
	}
}

t_year_card_preheat_date.dataList = dataList

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

return t_year_card_preheat_date
