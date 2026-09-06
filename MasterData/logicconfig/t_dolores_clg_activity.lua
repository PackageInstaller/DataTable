-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dolores_clg_activity.lua

module("logicconfig.config.t_dolores_clg_activity", package.seeall)

local title = {
	junpStr3 = 5,
	junpStr1 = 3,
	junpStr4 = 6,
	skinId = 7,
	posBuffDesc = 10,
	ruleDesc = 11,
	prize = 2,
	ruleTip = 12,
	junpStr2 = 4,
	showPrizeDesc = 9,
	activityId = 1,
	showPrize = 8
}
local dataList = {
	{
		524001,
		"100:15040:1:1",
		"func#618#15040",
		"mibao#MibaoShop",
		"func#545#3",
		"",
		15040,
		"100:15040:1:1",
		"通关获得\r\n多洛莉丝",
		"所有魔神站位（光圈位置）的精灵存活时，己阵全体+20%闪避率（已吞噬的属性，再上阵不激活加成）",
		"1、战斗中，己方布置在魔神站位（光圈位置）的精灵全部存活时，己阵全体+20%闪避率，破阵后，魔神站位上的精灵属性将被吞噬，后续关卡中上阵相同属性的精灵不再激活魔神加成\r\n2、敌阵全体精灵获得魔主止戈：首次受到攻击时，令自身获得30%闪避率以及降低敌阵25点通灵点，首次死亡时则令自身重生并恢复50%最大生命值",
		"doloresclgmainview_rule"
	},
	{
		524002,
		"100:13030:1:1",
		"func#618#13030",
		"func#1181",
		"func#545#1",
		"func#1332",
		13030,
		"100:13030:1:1",
		"通关获得\r\n阿特拉斯",
		"所有魔神站位（光圈位置）的精灵存活时，己阵全体伤害增加10%（已吞噬的属性，再上阵不激活加成）",
		"1、战斗中，己方布置在圣骑护卫站位（光圈位置）的精灵全部存活时，己阵全体伤害增加10%，破阵后，圣骑护卫站位上的精灵属性将被吞噬，后续关卡中上阵相同属性的精灵不再激活魔神加成\r\n2、敌阵全体精灵获得：敌阵肉盾和平衡职业精灵普攻后，为全阵精灵添加自身最大生命值*15%的护盾（2回合），超杀后为全阵精灵添加自身最大生命值*25%的护盾（2回合）",
		"atelasimainview_rule"
	}
}
local t_dolores_clg_activity = {
	[524001] = dataList[1],
	[524002] = dataList[2]
}

t_dolores_clg_activity.dataList = dataList

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

return t_dolores_clg_activity
