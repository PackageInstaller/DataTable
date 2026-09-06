-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_text.lua

module("logicconfig.config.t_tian_man_wang_challenge_text", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TEXT_1",
		"距离活动结束:%s"
	},
	{
		"TEXT_2",
		"活动已结束"
	},
	{
		"TEXT_3",
		"前%s名\n可获得"
	},
	{
		"TEXT_4",
		"通关苍木千叶任意关卡解锁"
	},
	{
		"TEXT_5",
		"通关森罗万象第%s关后解锁"
	},
	{
		"TEXT_6",
		"未解锁"
	},
	{
		"TEXT_7",
		"未选择"
	},
	{
		"TEXT_8",
		"已解锁:%d/%d"
	},
	{
		"TEXT_9",
		"已通关:%d/%d"
	},
	{
		"TEXT_10",
		"属性等级<color=#FEE04AFF>+%d</color>，%s"
	},
	{
		"TEXT_11",
		"解锁契约精灵\n开启时间:%s"
	},
	{
		"TEXT_12",
		"属性等级+%d"
	},
	{
		"TEXT_13",
		"今日挑战次数：%d/%d"
	},
	{
		"TEXT_14",
		"确定花费%d%s购买挑战次数吗？\n每天最多可购买%d次，还能购买%d次"
	},
	{
		"TEXT_15",
		"今日购买次数已经达到上限，\n次日5点刷新免费次数和购买次数"
	},
	{
		"TEXT_16",
		"奖励:%d"
	},
	{
		"TEXT_17",
		"未上阵天蛮王或选择的契约精灵"
	},
	{
		"TEXT_18",
		"森罗万象通关:%d/%d"
	},
	{
		"TEXT_19",
		"今日挑战次数:<color=#F7E973FF>%d/</color>%d"
	},
	{
		"TEXT_20",
		"天蛮王生命较高，毫无战意，攻击天蛮王会受到反弹伤害。"
	},
	{
		"TEXT_21",
		"天蛮王逐渐苏醒，战意上升，不再反弹伤害但攻击与防御提升。"
	},
	{
		"TEXT_22",
		"天蛮王生命低下，被激化出强烈的战意，天蛮王血量越低伤害越高。"
	},
	{
		"TEXT_23",
		"天蛮王\n剩余血量\n<color=#eb4642>%.1d%%</color>"
	},
	{
		"TEXT_24",
		"%Y/%m/%d\n%H:%M:%S"
	},
	{
		"TEXT_25",
		"天蛮王挑战排行榜"
	},
	{
		"TEXT_26",
		"获得时间"
	},
	{
		"TEXT_27",
		"1.最先通关极限挑战前5999名玩家，可获得专属头像框。\n2.根据通关时间先后进行排名，在精灵背包中展示光明王到聊天频道显示对应名次。"
	},
	{
		"TEXT_28",
		"排行榜"
	},
	{
		"TEXT_29",
		"本次挑战总伤害"
	},
	{
		"TEXT_30",
		"当前累积总伤害"
	},
	{
		"TEXT_31",
		"战斗结束"
	},
	{
		"TEXT_32",
		"击败敌阵所有精灵"
	},
	{
		"TEXT_33",
		"助战天蛮王存活"
	},
	{
		"TEXT_34",
		"战斗胜利"
	},
	{
		"TEXT_35",
		"战斗失败"
	},
	{
		"TEXT_36",
		"天蛮王已被击败"
	},
	{
		"TEXT_37",
		"森罗万象通关数不足"
	},
	{
		"TEXT_38",
		"已击杀"
	},
	{
		"TEXT_39",
		"您还有挑战次数，无需购买"
	}
}
local t_tian_man_wang_challenge_text = {
	TEXT_1 = dataList[1],
	TEXT_2 = dataList[2],
	TEXT_3 = dataList[3],
	TEXT_4 = dataList[4],
	TEXT_5 = dataList[5],
	TEXT_6 = dataList[6],
	TEXT_7 = dataList[7],
	TEXT_8 = dataList[8],
	TEXT_9 = dataList[9],
	TEXT_10 = dataList[10],
	TEXT_11 = dataList[11],
	TEXT_12 = dataList[12],
	TEXT_13 = dataList[13],
	TEXT_14 = dataList[14],
	TEXT_15 = dataList[15],
	TEXT_16 = dataList[16],
	TEXT_17 = dataList[17],
	TEXT_18 = dataList[18],
	TEXT_19 = dataList[19],
	TEXT_20 = dataList[20],
	TEXT_21 = dataList[21],
	TEXT_22 = dataList[22],
	TEXT_23 = dataList[23],
	TEXT_24 = dataList[24],
	TEXT_25 = dataList[25],
	TEXT_26 = dataList[26],
	TEXT_27 = dataList[27],
	TEXT_28 = dataList[28],
	TEXT_29 = dataList[29],
	TEXT_30 = dataList[30],
	TEXT_31 = dataList[31],
	TEXT_32 = dataList[32],
	TEXT_33 = dataList[33],
	TEXT_34 = dataList[34],
	TEXT_35 = dataList[35],
	TEXT_36 = dataList[36],
	TEXT_37 = dataList[37],
	TEXT_38 = dataList[38],
	TEXT_39 = dataList[39]
}

t_tian_man_wang_challenge_text.dataList = dataList

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

return t_tian_man_wang_challenge_text
