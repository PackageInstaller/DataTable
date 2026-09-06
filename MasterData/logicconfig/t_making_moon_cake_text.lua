-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake_text.lua

module("logicconfig.config.t_making_moon_cake_text", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BUBBLE_1",
		"咸的甜的都好吃！"
	},
	{
		"BUBBLE_2",
		"要不研究一个榴莲臭豆腐汤圆吧？"
	},
	{
		"BUBBLE_3",
		"卖汤圆卖汤圆，小二哥的汤圆是圆又圆~"
	},
	{
		"BUBBLE_4",
		"东风夜放花千树，更吹落，星如雨"
	},
	{
		"TEXT_2",
		"剩余次数: %d次"
	},
	{
		"TEXT_3",
		"%d秒"
	},
	{
		"TEXT_4",
		"食材弄错啦，重新选择吧~"
	},
	{
		"TEXT_5",
		"剩余次数:<color=#20b376>%d</color>次"
	},
	{
		"TEXT_6",
		"确定花费%d%s购买挑战次数吗？\n每天最多可购买%d次，还能购买%d次"
	},
	{
		"TEXT_7",
		"今日购买次数已经达到上限，\n次日5点刷新免费次数和购买次数"
	},
	{
		"TEXT_8",
		"食材未选齐，请继续选择食材"
	},
	{
		"TEXT_9",
		"现在退出，将不会获得任何奖励，\n也不会扣除游戏次数，是否确认退出？"
	},
	{
		"TEXT_10",
		"知道了%s"
	},
	{
		"TEXT_11",
		"采购原料中\n请%d.%d\n%d:%02d后再来"
	},
	{
		"TEXT_12",
		"没有次数了哦"
	},
	{
		"TEXT_13",
		"本周积分已达到上限"
	}
}
local t_making_moon_cake_text = {
	BUBBLE_1 = dataList[1],
	BUBBLE_2 = dataList[2],
	BUBBLE_3 = dataList[3],
	BUBBLE_4 = dataList[4],
	TEXT_2 = dataList[5],
	TEXT_3 = dataList[6],
	TEXT_4 = dataList[7],
	TEXT_5 = dataList[8],
	TEXT_6 = dataList[9],
	TEXT_7 = dataList[10],
	TEXT_8 = dataList[11],
	TEXT_9 = dataList[12],
	TEXT_10 = dataList[13],
	TEXT_11 = dataList[14],
	TEXT_12 = dataList[15],
	TEXT_13 = dataList[16]
}

t_making_moon_cake_text.dataList = dataList

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

return t_making_moon_cake_text
