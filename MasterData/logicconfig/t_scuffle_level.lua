-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scuffle_level.lua

module("logicconfig.config.t_scuffle_level", package.seeall)

local title = {
	baseScore = 3,
	addScore = 4,
	loseScore = 5,
	levelName = 2,
	icon = 6,
	level = 1
}
local dataList = {
	{
		1,
		"新晋选手",
		0,
		15,
		0,
		"scuffleicon1"
	},
	{
		2,
		"坚韧勇者",
		151,
		15,
		0,
		"scuffleicon2"
	},
	{
		3,
		"不屈斗士",
		301,
		15,
		1,
		"scuffleicon3"
	},
	{
		4,
		"超凡战神",
		501,
		15,
		2,
		"scuffleicon4"
	},
	{
		5,
		"荣耀王者",
		801,
		15,
		4,
		"scuffleicon5"
	},
	{
		6,
		"史诗英雄",
		1101,
		15,
		6,
		"scuffleicon6"
	},
	{
		7,
		"斗战圣皇",
		1401,
		15,
		8,
		"scuffleicon7"
	},
	{
		8,
		"傲世豪杰",
		1801,
		15,
		10,
		"scuffleicon8"
	},
	{
		9,
		"超神传说",
		2501,
		15,
		12,
		"scuffleicon9"
	}
}
local t_scuffle_level = {
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

t_scuffle_level.dataList = dataList

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

return t_scuffle_level
