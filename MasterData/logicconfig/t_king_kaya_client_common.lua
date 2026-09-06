-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_kaya_client_common.lua

module("logicconfig.config.t_king_kaya_client_common", package.seeall)

local title = {
	jumpStrTwo = 7,
	extClgTips = 15,
	jumpStrOne = 6,
	jumpStrThree = 8,
	ruleKeyExt = 5,
	jumpRedIdThree = 12,
	ruleKeyNor = 4,
	jumpRedIdTwo = 11,
	jumpRedIdFour = 13,
	comPlanId = 1,
	jumpRedIdOne = 10,
	norClgTips = 14,
	jumpStrFour = 9,
	ruleKeyMain = 3,
	skinId = 2
}
local dataList = {
	{
		1,
		13015,
		"kingkayamainview_rule",
		"kingkayaview_quanmin_rule",
		"kingkayaview_jixian_rule",
		"mibao#yingsenzhuxiang2",
		"func#618#13015",
		"func#43#125",
		"",
		"",
		"",
		"",
		"",
		"1.每日<color=#8bcdff>5:00</color>刷新敌阵，使用玩家自己的精灵与实际的属性进行挑战。\r\n2.通关不同难度的关卡积分不同，<color=#8bcdff>简单：20分，普通：25分，困难：30分，地狱：35分，炼狱：40分</color>\r\n3.己阵攻击敌阵相同标记的精灵时，造成正常伤害，攻击敌阵不同标记的精灵时，造成<color=#8bcdff>20%</color>伤害\r\n4.积分足够即可领取奖励",
		"1.己阵与敌阵带有标记的位置上阵精灵可获得以下效果：\r\n<color=#8bcdff>圣盾：首次死亡时，解除禁疗效果后复活并恢复50</color>\r\n<color=#8bcdff>曙光：首次超杀后，获得50气势并立即出手一次</color>\r\n2.己阵攻击敌阵相同标记的精灵时，造成正常伤害，攻击敌阵不同标记的精灵时，造成<color=#8bcdff>20%</color>伤害\r\n3.破阵时，己阵存活的精灵转化为能量，<color=#8bcdff>能量类型与精灵所在站位的标记类型相同</color>\r\n4.已转化为能量的精灵在后续的挑战中不可上阵"
	},
	{
		2,
		13015,
		"kingkayamainview_rule",
		"kingkayaview_quanmin_rule",
		"kingkayaview_jixian_rule",
		"mibao#yingsenzhuxiang2",
		"func#618#13015",
		"func#43#125",
		"",
		"",
		"",
		"",
		"",
		"1.每日<color=#8bcdff>5:00</color>刷新敌阵，使用玩家自己的精灵与实际的属性进行挑战。\r\n2.通关不同难度的关卡积分不同，<color=#8bcdff>简单：20分，普通：25分，困难：30分，地狱：35分，炼狱：40分</color>\r\n3.己阵攻击敌阵相同标记的精灵时，造成正常伤害，攻击敌阵不同标记的精灵时，造成<color=#8bcdff>20%</color>伤害\r\n4.积分足够即可领取奖励",
		"1.己阵与敌阵带有标记的位置上阵精灵可获得以下效果：\r\n<color=#8bcdff>圣盾：首次死亡时，解除禁疗效果后复活并恢复50</color>\r\n<color=#8bcdff>曙光：首次超杀后，获得50气势并立即出手一次</color>\r\n2.己阵攻击敌阵相同标记的精灵时，造成正常伤害，攻击敌阵不同标记的精灵时，造成<color=#8bcdff>20%</color>伤害\r\n3.破阵时，己阵存活的精灵转化为能量，<color=#8bcdff>能量类型与精灵所在站位的标记类型相同</color>\r\n4.已转化为能量的精灵在后续的挑战中不可上阵"
	}
}
local t_king_kaya_client_common = {
	dataList[1],
	dataList[2]
}

t_king_kaya_client_common.dataList = dataList

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

return t_king_kaya_client_common
