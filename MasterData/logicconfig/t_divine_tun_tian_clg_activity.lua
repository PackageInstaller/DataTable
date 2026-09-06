-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tun_tian_clg_activity.lua

module("logicconfig.config.t_divine_tun_tian_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 5,
	extremeBuffPlanId = 3,
	extremePowerTransmit = 4,
	jumpTo = 9,
	normalSupportPetId = 7,
	skinId = 10,
	normalBuffPlanId = 6,
	ruleKeyExt = 12,
	ruleKeyNor = 13,
	showNorRule = 14,
	redPointId = 8,
	ruleKeyMain = 11,
	activityId = 1,
	buffCounterId = 2
}
local dataList = {
	{
		508001,
		30000025,
		1,
		"1=50,2=25",
		"4:394:100",
		2,
		100000001,
		722,
		{
			"func#618#11030",
			"ui#lottery",
			"mibao#MibaoShop",
			"func#43#135",
			"event#gotofirstpassrankview#508001"
		},
		11030,
		"divinetuntianmainview_rule",
		"divinetuntianextremeclg_rule",
		"divinetuntiannormalclg_rule",
		"1、每日5:00刷新3个平行敌阵。\r\n2、破阵时，分别记录每个敌阵的每日最高的变身次数，每日重置\r\n3、活动期间，累计变身次数达标即可领取进度奖励\r\n4、根据今日三个敌阵累计的最高变身次数总和，激活敌阵加成\r\n5、使用背包精灵极限战力挑战，提供神曜吞天助战"
	}
}
local t_divine_tun_tian_clg_activity = {
	[508001] = dataList[1]
}

t_divine_tun_tian_clg_activity.dataList = dataList

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

return t_divine_tun_tian_clg_activity
