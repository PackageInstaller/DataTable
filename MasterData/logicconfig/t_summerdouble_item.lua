-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summerdouble_item.lua

module("logicconfig.config.t_summerdouble_item", package.seeall)

local title = {
	itemId = 2,
	name = 4,
	isBigItem = 3,
	tabId = 1,
	tag = 6,
	iconpath = 5,
	pos = 7,
	jumpTo = 8
}
local dataList = {
	{
		1,
		1,
		false,
		"10.27-11.3\r\n冒险幻境全民双倍次数翻倍",
		"board_xiajifanbei_05",
		"",
		{
			-315,
			-170
		},
		"func#106"
	},
	{
		1,
		2,
		false,
		"10.27-11.3\r\n每日灵纹幻境次数翻倍",
		"board_xiajifanbei_14",
		"",
		{
			140,
			-170
		},
		"func#611"
	},
	{
		1,
		3,
		false,
		"10.27-11.3\r\n米淇淋餐厅领取体力翻倍",
		"board_xiajifanbei_03",
		"",
		{
			-85,
			-170
		},
		"func#3#supplymergeview"
	},
	{
		1,
		4,
		false,
		"10.27-11.3\r\n失落遗迹掉落奖励翻倍",
		"board_xiajifanbei_02",
		"",
		{
			140,
			30
		},
		"func#52"
	},
	{
		1,
		5,
		false,
		"10.27-11.3\r\n派遣任务奖励翻倍",
		"board_xiajifanbei_12",
		"",
		{
			-315,
			30
		},
		"func#74"
	},
	{
		1,
		6,
		false,
		"10.27-11.3\r\n家族护送奖励翻倍",
		"board_xiajifanbei_11",
		"",
		{
			-85,
			30
		},
		"func#91"
	},
	{
		2,
		1,
		false,
		"10.27-11.3、11.10-11.17\r\n招待所每日刷新宠物冷却减少",
		"board_kaixuefanbei_04",
		"",
		{
			90,
			-60
		},
		"func#910"
	},
	{
		2,
		2,
		false,
		"10.27-11.3、11.10-11.17\r\n旅行社打扫速度加快",
		"board_kaixuefanbei_05",
		"",
		{
			-265,
			-60
		},
		"func#910"
	}
}
local t_summerdouble_item = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	}
}

t_summerdouble_item.dataList = dataList

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

return t_summerdouble_item
