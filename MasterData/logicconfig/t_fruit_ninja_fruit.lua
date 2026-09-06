-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_fruit.lua

module("logicconfig.config.t_fruit_ninja_fruit", package.seeall)

local title = {
	score = 3,
	criticalScore = 8,
	name = 2,
	sliceHealth = 4,
	crazyTime = 7,
	clipPath = 13,
	iconPath = 12,
	critEff = 15,
	sliceEff = 14,
	isClearScreen = 9,
	doubleTime = 6,
	outHealth = 5,
	gravityScale = 11,
	scale = 10,
	fruitId = 1
}
local dataList = {
	{
		1,
		"苹果",
		5,
		0,
		-1,
		0,
		0,
		5,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo01",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo12",
			"fruitninja/board_shuiguoyinzhe_shuiguo15"
		},
		"",
		"ui/views/fruitninja/cell/redcritboomeff.prefab"
	},
	{
		2,
		"橙子",
		5,
		0,
		-1,
		0,
		0,
		5,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo02",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo10",
			"fruitninja/board_shuiguoyinzhe_shuiguo11"
		},
		"",
		"ui/views/fruitninja/cell/redcritboomeff.prefab"
	},
	{
		3,
		"雪梨",
		5,
		0,
		-1,
		0,
		0,
		5,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo03",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo06",
			"fruitninja/board_shuiguoyinzhe_shuiguo07"
		},
		"",
		"ui/views/fruitninja/cell/yellowboomredeff.prefab"
	},
	{
		4,
		"草莓",
		5,
		0,
		-1,
		0,
		0,
		5,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo04",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo14",
			"fruitninja/board_shuiguoyinzhe_shuiguo13"
		},
		"",
		"ui/views/fruitninja/cell/yellowboomredeff.prefab"
	},
	{
		5,
		"菠萝",
		5,
		0,
		-1,
		0,
		0,
		5,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo05",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo08",
			"fruitninja/board_shuiguoyinzhe_shuiguo09"
		},
		"",
		"ui/views/fruitninja/cell/yellowboomredeff.prefab"
	},
	{
		6,
		"炸弹",
		-30,
		-1,
		0,
		0,
		0,
		0,
		true,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo22",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo24",
			"fruitninja/board_shuiguoyinzhe_shuiguo23"
		},
		"fx_ui_zdsz/fx_ui_zdsz_baozha",
		""
	},
	{
		7,
		"特殊蓝香蕉",
		0,
		0,
		0,
		10,
		0,
		0,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo19",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo20",
			"fruitninja/board_shuiguoyinzhe_shuiguo21"
		},
		"",
		""
	},
	{
		8,
		"特殊黄香蕉",
		0,
		0,
		0,
		0,
		10,
		0,
		false,
		0,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo16",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo17",
			"fruitninja/board_shuiguoyinzhe_shuiguo18"
		},
		"",
		""
	},
	{
		9,
		"苹果小",
		2,
		0,
		-1,
		0,
		0,
		2,
		false,
		0.7,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo01",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo12",
			"fruitninja/board_shuiguoyinzhe_shuiguo15"
		},
		"",
		"ui/views/fruitninja/cell/redcritboomeff.prefab"
	},
	{
		10,
		"橙子小",
		2,
		0,
		-1,
		0,
		0,
		2,
		false,
		0.7,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo02",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo10",
			"fruitninja/board_shuiguoyinzhe_shuiguo11"
		},
		"",
		"ui/views/fruitninja/cell/redcritboomeff.prefab"
	},
	{
		11,
		"雪梨小",
		2,
		0,
		-1,
		0,
		0,
		2,
		false,
		0.7,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo03",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo06",
			"fruitninja/board_shuiguoyinzhe_shuiguo07"
		},
		"",
		"ui/views/fruitninja/cell/yellowboomredeff.prefab"
	},
	{
		12,
		"草莓小",
		2,
		0,
		-1,
		0,
		0,
		2,
		false,
		0.7,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo04",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo14",
			"fruitninja/board_shuiguoyinzhe_shuiguo13"
		},
		"",
		"ui/views/fruitninja/cell/yellowboomredeff.prefab"
	},
	{
		13,
		"菠萝小",
		2,
		0,
		-1,
		0,
		0,
		2,
		false,
		0.7,
		0.1,
		"fruitninja/board_shuiguoyinzhe_shuiguo05",
		{
			"fruitninja/board_shuiguoyinzhe_shuiguo08",
			"fruitninja/board_shuiguoyinzhe_shuiguo09"
		},
		"",
		"ui/views/fruitninja/cell/yellowboomredeff.prefab"
	}
}
local t_fruit_ninja_fruit = {
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
	dataList[11],
	dataList[12],
	dataList[13]
}

t_fruit_ninja_fruit.dataList = dataList

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

return t_fruit_ninja_fruit
