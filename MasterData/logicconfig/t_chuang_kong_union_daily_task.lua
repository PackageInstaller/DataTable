-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_kong_union_daily_task.lua

module("logicconfig.config.t_chuang_kong_union_daily_task", package.seeall)

local title = {
	prize = 5,
	winParams = 4,
	winPrize = 6,
	taskType = 3,
	desc = 10,
	title = 9,
	planId = 1,
	taskId = 2,
	condition = 11,
	jumpto = 12,
	sweepCost = 8,
	losePrize = 7
}
local dataList = {
	{
		1,
		1,
		1,
		"",
		"4:128",
		"",
		"",
		"105:198:20",
		"挑战I",
		"1.伤害越高奖励越多，详见规则说明\r\n2.每次挑战最多获得100个天鸣碎片\r\n3.上阵 [月影王] 每次额外得25碎片\r\n4.扫荡无法获得 [月影王] 加成哦",
		"",
		"npc#1271019"
	},
	{
		1,
		2,
		2,
		"2",
		"4:128",
		"4:128:150",
		"4:128:50",
		"105:198:20",
		"天鸣问答",
		"1.完成天鸣问答考验可获得天鸣碎片\r\n2.胜利得150碎片，失败得50碎片\r\n3.消耗钻石扫荡按照胜利发放奖励",
		"20秒内答对超过2题即可获得胜利；胜利可获得更多的天鸣碎片",
		"npc#1271021"
	},
	{
		1,
		3,
		1,
		"",
		"4:128",
		"",
		"",
		"105:198:20",
		"挑战II",
		"1.伤害越高奖励越多，详见规则说明\r\n2.每次挑战最多获得100个天鸣碎片\r\n3.上阵 [月影王] 每次额外得25碎片\r\n4.扫荡无法获得 [月影王] 加成哦",
		"",
		"npc#1271019"
	},
	{
		1,
		4,
		3,
		"6",
		"4:128",
		"4:128:150",
		"4:128:50",
		"105:198:20",
		"天鸣迷阵",
		"1.在精灵迷阵中找到梵天帝一鸣\r\n2.胜利得150碎片，失败得50碎片\r\n3.消耗钻石扫荡按照胜利发放奖励",
		"在规定时间内找出6个梵天即可获得胜利；胜利可获得更多的天鸣碎片",
		"npc#1271021"
	},
	{
		1,
		5,
		1,
		"",
		"4:128",
		"",
		"",
		"105:198:20",
		"挑战III",
		"1.伤害越高奖励越多，详见规则说明\r\n2.每次挑战最多获得100个天鸣碎片\r\n3.上阵 [月影王] 每次额外得25碎片\r\n4.扫荡无法获得 [月影王] 加成哦",
		"",
		"npc#1271019"
	}
}
local t_chuang_kong_union_daily_task = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_chuang_kong_union_daily_task.dataList = dataList

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

return t_chuang_kong_union_daily_task
