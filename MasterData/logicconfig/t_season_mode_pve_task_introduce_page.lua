-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_task_introduce_page.lua

module("logicconfig.config.t_season_mode_pve_task_introduce_page", package.seeall)

local title = {
	changePage = 7,
	taskIds = 5,
	seasonId = 1,
	imgRes = 3,
	txtBubble = 4,
	pageId = 2,
	changePos = 6
}
local dataList = {
	{
		2,
		1,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			1,
			10,
			25
		},
		4350,
		1
	},
	{
		2,
		2,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			2,
			9
		},
		4350,
		2
	},
	{
		2,
		3,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			3,
			21
		},
		4350,
		3
	},
	{
		2,
		4,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			4,
			28
		},
		4350,
		4
	},
	{
		2,
		5,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			5,
			17
		},
		4350,
		5
	},
	{
		2,
		6,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			6,
			11,
			24
		},
		4350,
		10
	},
	{
		2,
		7,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			7,
			18,
			27
		},
		4350,
		11
	},
	{
		2,
		8,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			8,
			26
		},
		4350,
		12
	},
	{
		2,
		9,
		"",
		"跟随我的指引完成9宫挑战，即可结束异界战场",
		{
			12,
			19,
			23
		},
		4350,
		13
	},
	{
		2,
		10,
		"",
		"我们需要击败赤焰龙皇，才能关闭异界战场",
		{
			6,
			11,
			14
		},
		0,
		0
	},
	{
		2,
		11,
		"",
		"我们需要击败赤焰龙皇，才能关闭异界战场",
		{
			7,
			18,
			13
		},
		0,
		0
	},
	{
		2,
		12,
		"",
		"我们需要击败赤焰龙皇，才能关闭异界战场",
		{
			8,
			26,
			15
		},
		0,
		0
	},
	{
		2,
		13,
		"",
		"我们需要击败赤焰龙皇，才能关闭异界战场",
		{
			12,
			20,
			23
		},
		0,
		0
	}
}
local t_season_mode_pve_task_introduce_page = {
	[2] = {
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
}

t_season_mode_pve_task_introduce_page.dataList = dataList

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

return t_season_mode_pve_task_introduce_page
