-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_breach_formation_season.lua

module("logicconfig.config.t_new_breach_formation_season", package.seeall)

local title = {
	endDateTime = 3,
	startDateTime = 2,
	seasonId = 1,
	rankLevelPlanId = 4
}
local dataList = {
	{
		1,
		"2023-12-22T05:00:00",
		"2024-01-19T05:00:00",
		1
	},
	{
		2,
		"2024-03-01T05:00:00",
		"2024-03-29T05:00:00",
		1
	},
	{
		3,
		"2024-04-03T05:00:00",
		"2024-04-26T05:00:00",
		1
	},
	{
		4,
		"2024-07-05T05:00:00",
		"2024-07-26T05:00:00",
		1
	},
	{
		5,
		"2024-09-27T05:00:00",
		"2024-10-18T05:00:00",
		1
	},
	{
		6,
		"2025-01-24T05:00:00",
		"2025-02-07T05:00:00",
		1
	},
	{
		7,
		"2025-02-07T05:00:00",
		"2025-02-21T05:00:00",
		1
	},
	{
		8,
		"2026-08-07T05:00:00",
		"2026-08-21T05:00:00",
		1
	}
}
local t_new_breach_formation_season = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_new_breach_formation_season.dataList = dataList

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

return t_new_breach_formation_season
