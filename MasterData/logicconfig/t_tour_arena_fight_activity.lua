-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tour_arena_fight_activity.lua

module("logicconfig.config.t_tour_arena_fight_activity", package.seeall)

local title = {
	mainViewRankZoneId = 9,
	zoneTermId = 6,
	periodId = 4,
	periodType = 3,
	comPlanId = 8,
	redPointId = 7,
	canNotRankNum = 5,
	collectItemId = 2,
	activityId = 1
}
local dataList = {
	{
		310001,
		310001,
		"",
		0,
		0,
		1,
		0,
		1,
		0
	},
	{
		310002,
		310002,
		"",
		0,
		0,
		1,
		0,
		2,
		0
	},
	{
		310003,
		310003,
		"",
		0,
		0,
		2,
		0,
		3,
		1
	},
	{
		310004,
		310004,
		"",
		0,
		0,
		2,
		0,
		4,
		1
	},
	{
		310005,
		310005,
		"",
		0,
		0,
		1,
		626,
		5,
		0
	},
	{
		310006,
		310006,
		"",
		0,
		0,
		3,
		626,
		6,
		0
	},
	{
		310007,
		310007,
		"",
		0,
		0,
		4,
		626,
		6,
		1
	},
	{
		310008,
		310008,
		"",
		0,
		0,
		4,
		626,
		6,
		1
	},
	{
		310009,
		310009,
		"",
		0,
		0,
		4,
		626,
		6,
		1
	},
	{
		310010,
		310010,
		"",
		0,
		0,
		4,
		626,
		6,
		1
	},
	{
		310011,
		310011,
		"1",
		1,
		500,
		4,
		626,
		6,
		1
	},
	{
		310012,
		310012,
		"1",
		1,
		500,
		4,
		626,
		6,
		1
	},
	{
		310013,
		310013,
		"1",
		1,
		500,
		4,
		626,
		6,
		1
	},
	{
		310014,
		310014,
		"1",
		1,
		500,
		4,
		626,
		6,
		1
	},
	{
		310015,
		310015,
		"2",
		2,
		500,
		5,
		626,
		7,
		1
	},
	{
		310016,
		310016,
		"2",
		2,
		500,
		5,
		626,
		7,
		1
	},
	{
		310017,
		310017,
		"2",
		2,
		500,
		5,
		626,
		7,
		1
	},
	{
		310018,
		310018,
		"2",
		2,
		500,
		5,
		626,
		7,
		1
	},
	{
		310019,
		310019,
		"3",
		3,
		500,
		6,
		626,
		8,
		1
	},
	{
		310020,
		310020,
		"3",
		3,
		500,
		6,
		626,
		8,
		1
	},
	{
		310021,
		310021,
		"3",
		3,
		500,
		6,
		626,
		8,
		1
	},
	{
		310022,
		310022,
		"3",
		3,
		500,
		6,
		626,
		8,
		1
	},
	{
		310023,
		310023,
		"4",
		4,
		500,
		6,
		626,
		9,
		1
	},
	{
		310024,
		310024,
		"4",
		4,
		500,
		6,
		626,
		9,
		1
	},
	{
		310025,
		310025,
		"4",
		4,
		500,
		6,
		626,
		9,
		1
	},
	{
		310026,
		310026,
		"4",
		4,
		500,
		6,
		626,
		9,
		1
	},
	{
		310027,
		310027,
		"5",
		5,
		500,
		6,
		626,
		10,
		1
	},
	{
		310028,
		310028,
		"5",
		5,
		500,
		6,
		626,
		10,
		1
	},
	{
		310029,
		310029,
		"5",
		5,
		500,
		6,
		626,
		10,
		1
	},
	{
		310030,
		310030,
		"5",
		5,
		500,
		6,
		626,
		10,
		1
	}
}
local t_tour_arena_fight_activity = {
	[310001] = dataList[1],
	[310002] = dataList[2],
	[310003] = dataList[3],
	[310004] = dataList[4],
	[310005] = dataList[5],
	[310006] = dataList[6],
	[310007] = dataList[7],
	[310008] = dataList[8],
	[310009] = dataList[9],
	[310010] = dataList[10],
	[310011] = dataList[11],
	[310012] = dataList[12],
	[310013] = dataList[13],
	[310014] = dataList[14],
	[310015] = dataList[15],
	[310016] = dataList[16],
	[310017] = dataList[17],
	[310018] = dataList[18],
	[310019] = dataList[19],
	[310020] = dataList[20],
	[310021] = dataList[21],
	[310022] = dataList[22],
	[310023] = dataList[23],
	[310024] = dataList[24],
	[310025] = dataList[25],
	[310026] = dataList[26],
	[310027] = dataList[27],
	[310028] = dataList[28],
	[310029] = dataList[29],
	[310030] = dataList[30]
}

t_tour_arena_fight_activity.dataList = dataList

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

return t_tour_arena_fight_activity
