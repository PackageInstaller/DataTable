-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dragon_arya_clg_activity.lua

module("logicconfig.config.t_origin_dragon_arya_clg_activity", package.seeall)

local title = {
	junpStr3 = 10,
	junpStr1 = 8,
	annuityGodRankEndTime = 5,
	skinId = 12,
	junpStr4 = 11,
	passPrize = 14,
	junpStr2 = 9,
	annuityGodRankMpId = 6,
	damageScoreRate = 3,
	annuityGodRankScoreLimit = 4,
	activityId = 1,
	ruleTip = 7,
	ruleDesc = 15,
	txtTipsGod = 17,
	showPrizeDesc = 13,
	challengeClosedTimeRange = 16,
	damageSignBuffId = 2
}
local dataList = {
	{
		573001,
		20072301,
		0.0002,
		80000,
		"2026-04-30T05:00:00",
		397,
		"originlongzhumainview_rule",
		"func#618#17029",
		"ui#lottery",
		"mibao#MibaoShop",
		"ui#goddailyrankmainview#573001#28",
		17029,
		"战斗中，龙尊标记精灵在其他精灵全部被击杀前阵亡将解除无法回血状态并满血复活",
		"4:510747:100",
		"1、战斗中，龙尊标记精灵在其他精灵被击杀前无限复活\r\n2、全部通关才更新排行榜积分，重置关卡将清空该关的积分\r\n3、只保留每关的历史最高积分",
		"02:00:00-09:00:00",
		"积分达到80000将立即获得奖励，\r\n且自动加入周年大神榜，不再参与普通大神榜排名"
	}
}
local t_origin_dragon_arya_clg_activity = {
	[573001] = dataList[1]
}

t_origin_dragon_arya_clg_activity.dataList = dataList

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

return t_origin_dragon_arya_clg_activity
