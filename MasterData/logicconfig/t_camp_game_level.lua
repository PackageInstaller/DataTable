-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_game_level.lua

module("logicconfig.config.t_camp_game_level", package.seeall)

local title = {
	icon = 6,
	baseScore = 3,
	addCampScore = 7,
	levelName = 2,
	tieCampScore = 9,
	loseScore = 5,
	addScore = 4,
	loseCampScore = 8,
	level = 1
}
local dataList = {
	{
		1,
		"新晋选手",
		0,
		90,
		0,
		"scuffleicon1",
		90,
		30,
		45
	},
	{
		2,
		"坚韧勇者",
		151,
		90,
		0,
		"scuffleicon2",
		120,
		40,
		60
	},
	{
		3,
		"不屈斗士",
		301,
		90,
		6,
		"scuffleicon3",
		150,
		50,
		75
	},
	{
		4,
		"超凡战神",
		501,
		90,
		12,
		"scuffleicon4",
		180,
		60,
		90
	},
	{
		5,
		"荣耀王者",
		801,
		90,
		24,
		"scuffleicon5",
		210,
		70,
		105
	},
	{
		6,
		"史诗英雄",
		1101,
		90,
		36,
		"scuffleicon6",
		240,
		80,
		120
	},
	{
		7,
		"斗战圣皇",
		1401,
		90,
		48,
		"scuffleicon7",
		270,
		90,
		135
	},
	{
		8,
		"傲世豪杰",
		1801,
		90,
		60,
		"scuffleicon8",
		300,
		100,
		150
	},
	{
		9,
		"超神传说",
		2501,
		90,
		72,
		"scuffleicon9",
		330,
		110,
		165
	}
}
local t_camp_game_level = {
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

t_camp_game_level.dataList = dataList

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

return t_camp_game_level
