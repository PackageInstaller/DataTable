-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_arena_season.lua

module("logicconfig.config.t_king_arena_season", package.seeall)

local title = {
	exchangeItem = 2,
	openTime = 3,
	shopJump = 10,
	bestRankPrizePlanId = 7,
	selectCostPlanId = 8,
	opRangePlanId = 9,
	seasonId = 1,
	endTime = 4,
	buyFightTimePlanId = 6,
	zonePlanId = 5
}
local dataList = {
	{
		1,
		"10:426001",
		"2024-11-08T09:00:00",
		"2025-01-24T05:00:00",
		1,
		1,
		1,
		1,
		1,
		"func#191#426#426001"
	},
	{
		2,
		"10:426002",
		"2025-01-31T09:00:00",
		"2025-05-03T05:00:00",
		2,
		1,
		2,
		1,
		1,
		"func#191#426#426002"
	},
	{
		3,
		"10:426003",
		"2025-05-03T09:00:00",
		"2025-08-02T05:00:00",
		3,
		1,
		3,
		1,
		1,
		"func#191#426#426003"
	},
	{
		4,
		"10:426004",
		"2025-08-02T09:00:00",
		"2025-11-01T05:00:00",
		4,
		1,
		4,
		1,
		1,
		"func#191#426#426004"
	},
	{
		5,
		"10:426005",
		"2025-11-01T09:00:00",
		"2026-01-31T05:00:00",
		5,
		1,
		5,
		1,
		1,
		"func#191#426#426005"
	},
	{
		6,
		"10:426006",
		"2026-01-31T09:00:00",
		"2026-05-02T05:00:00",
		6,
		1,
		6,
		1,
		1,
		"func#191#426#426006"
	},
	{
		7,
		"10:426007",
		"2026-05-02T09:00:00",
		"2026-08-01T05:00:00",
		7,
		1,
		7,
		1,
		1,
		"func#191#426#426007"
	},
	{
		8,
		"10:426008",
		"2026-08-01T09:00:00",
		"2026-10-31T05:00:00",
		8,
		1,
		8,
		1,
		1,
		"func#191#426#426008"
	}
}
local t_king_arena_season = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_king_arena_season.dataList = dataList

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

return t_king_arena_season
