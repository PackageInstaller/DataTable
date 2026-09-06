-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fishing_game_fish.lua

module("logicconfig.config.t_fishing_game_fish", package.seeall)

local title = {
	score = 6,
	height = 5,
	weight = 3,
	showYRange = 9,
	offsetX = 10,
	resPath = 12,
	fishId = 2,
	spinePath = 13,
	speed = 8,
	fishPlanId = 1,
	effectNum = 7,
	spineScale = 14,
	offsetY = 11,
	type = 15,
	width = 4
}
local dataList = {
	{
		1,
		1,
		50,
		387,
		185,
		15,
		0,
		80,
		{
			-280,
			-180
		},
		75,
		30,
		"",
		"character/diaoyu_03/diaoyu_03-ui_p.prefab",
		4,
		1
	},
	{
		1,
		2,
		100,
		163,
		115,
		10,
		0,
		100,
		{
			-215,
			-80
		},
		15,
		25,
		"",
		"character/diaoyu_02/diaoyu_02-ui_p.prefab",
		4,
		1
	},
	{
		1,
		3,
		200,
		89,
		80,
		5,
		0,
		120,
		{
			-140,
			-35
		},
		0,
		0,
		"",
		"character/diaoyu_01/diaoyu_01-ui_p.prefab",
		4,
		1
	},
	{
		1,
		4,
		0,
		100,
		100,
		2,
		0,
		0,
		nil,
		0,
		0,
		"board_diaoyuxiaoyouxi_05",
		"",
		0,
		3
	},
	{
		1,
		5,
		0,
		172,
		172,
		30,
		0,
		0,
		nil,
		0,
		0,
		"board_diaoyuxiaoyouxi_06",
		"",
		0,
		4
	},
	{
		1,
		6,
		0,
		164,
		160,
		20,
		0,
		0,
		nil,
		0,
		0,
		"board_diaoyuxiaoyouxi_07",
		"",
		0,
		5
	},
	{
		1,
		7,
		0,
		124,
		124,
		0,
		5,
		100,
		nil,
		0,
		0,
		"board_diaoyuxiaoyouxi_14",
		"",
		0,
		6
	},
	{
		1,
		8,
		30,
		124,
		105,
		3,
		-1,
		100,
		{
			-300,
			-40
		},
		0,
		0,
		"",
		"character/diaoyu_05/diaoyu_05-ui_p.prefab",
		4,
		2
	},
	{
		1,
		9,
		30,
		326,
		83,
		0,
		5,
		100,
		{
			-300,
			-150
		},
		20,
		30,
		"",
		"character/diaoyu_04/diaoyu_04-ui_p.prefab",
		4,
		7
	}
}
local t_fishing_game_fish = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_fishing_game_fish.dataList = dataList

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

return t_fishing_game_fish
