-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_box_game_flower.lua

module("logicconfig.config.t_guess_box_game_flower", package.seeall)

local title = {
	score = 4,
	picturePath = 5,
	flowerPlanId = 1,
	openEffect = 6,
	guessPrize = 3,
	flowerId = 2
}
local dataList = {
	{
		1,
		1,
		"10:137001:1",
		0,
		"items/icon_sh_hua03",
		""
	},
	{
		1,
		2,
		"10:137001:2",
		0,
		"items/icon_lailisihua",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		2,
		1,
		"8:1:500",
		0,
		"items/icon_sh_hua03",
		""
	},
	{
		2,
		2,
		"8:1:10000",
		20,
		"items/icon_xuerenzhuomicang_01",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		2,
		3,
		"8:1:10000",
		20,
		"items/icon_xuerenzhuomicang_02",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		2,
		4,
		"8:1:10000",
		20,
		"items/icon_xuerenzhuomicang_03",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		3,
		1,
		"",
		0,
		"items/icon_sh_hua03",
		""
	},
	{
		3,
		2,
		"",
		10,
		"items/icon_tianzhuzhenwu_03",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		4,
		1,
		"",
		0,
		"items/board_wuwenfenshen_04",
		""
	},
	{
		4,
		2,
		"",
		10,
		"items/board_wuwenfenshen_05",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		5,
		1,
		"8:1:500",
		0,
		"items/icon_sh_hua03",
		""
	},
	{
		5,
		2,
		"8:1:10000",
		10,
		"items/icon_zijigeng",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		5,
		3,
		"8:1:10000",
		10,
		"items/icon_yujinxiang",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	},
	{
		5,
		4,
		"8:1:10000",
		10,
		"items/icon_ziluolan",
		"20220318/songhua/fx_ui_songhua_shangsheng"
	}
}
local t_guess_box_game_flower = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_guess_box_game_flower.dataList = dataList

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

return t_guess_box_game_flower
