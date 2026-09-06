-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_season.lua

module("logicconfig.config.t_origin_material_game_season", package.seeall)

local title = {
	stagePlanId = 3,
	weaponPlanId = 5,
	reOpenNum = 6,
	prizePlanId = 4,
	id = 1,
	beginTime = 2
}
local dataList = {
	{
		1,
		"2025-11-21",
		1,
		1,
		1,
		0
	},
	{
		2,
		"2025-12-19",
		2,
		1,
		1,
		1
	},
	{
		3,
		"2026-01-16",
		3,
		2,
		1,
		1
	},
	{
		4,
		"2026-02-13",
		4,
		1,
		1,
		1
	},
	{
		5,
		"2026-03-13",
		5,
		3,
		1,
		1
	},
	{
		6,
		"2026-04-03",
		6,
		1,
		2,
		1
	},
	{
		7,
		"2026-04-30",
		7,
		1,
		2,
		1
	},
	{
		8,
		"2026-05-29",
		8,
		1,
		2,
		1
	},
	{
		9,
		"2026-06-26",
		9,
		3,
		2,
		1
	},
	{
		10,
		"2026-07-24",
		10,
		3,
		2,
		1
	},
	{
		11,
		"2026-08-21",
		6,
		1,
		2,
		1
	}
}
local t_origin_material_game_season = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11]
}

t_origin_material_game_season.dataList = dataList

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

return t_origin_material_game_season
