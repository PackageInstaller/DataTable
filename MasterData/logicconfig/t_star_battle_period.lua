-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_period.lua

module("logicconfig.config.t_star_battle_period", package.seeall)

local title = {
	bossConvertScore = 6,
	openTime = 3,
	activityId = 1,
	supportPlanId = 17,
	doubleBossScorePlanId = 18,
	periodId = 2,
	minBossDamage = 19,
	eleFilter = 20,
	stageConvertScore = 5,
	defTipDesc = 21,
	buffPlanId = 13,
	endTime = 4,
	chapterLihui = 22,
	bossCreepsId = 7,
	newRankPlanId = 10,
	oldRankPlanId = 11,
	bossRuleDesc = 24,
	bossPlanId = 16,
	progressPlanId = 15,
	oldDefensePlanId = 9,
	stageRuleDesc = 23,
	stagePlanId = 14,
	formationRacePlanId = 12,
	newDefensePlanId = 8
}
local dataList = {
	{
		510001,
		1,
		"2025-08-22T05:00:00",
		"2025-08-29T05:00:00",
		50,
		100000,
		8,
		2,
		1,
		2,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		100000,
		"水#草#源",
		"本周布阵要求：水、草属性",
		11030,
		"（8.22 5:00-8.29 5:00）击杀敌阵全部精灵，己阵精灵变身次数越多，获得的积分越多，每变身1次可获得50积分",
		"（8.22 5:00-8.29 5:00）按顺序击杀8只无垢天使后，才可对BOSS吞天造成伤害，每10w点伤害=1积分"
	},
	{
		510001,
		2,
		"2025-08-29T05:00:00",
		"2025-09-05T05:00:00",
		100,
		100000,
		2,
		4,
		3,
		2,
		1,
		2,
		1,
		2,
		1,
		2,
		2,
		1,
		100000,
		"水#空#创#源",
		"本周布阵要求：水、空、创属性",
		11033,
		"（8.29 5:00-9.5 5:00）3个回合内强制结束战斗，每击杀敌阵1只精灵可获得100积分",
		"（8.29 5:00-9.5 5:00）敌阵为BOSS敖九+BOSS冰奇布，根据BOSS敖九实际扣除的血量换算积分，每10w点伤害=1积分"
	},
	{
		510001,
		3,
		"2025-09-05T05:00:00",
		"2025-09-12T05:00:00",
		100,
		100000,
		1,
		6,
		5,
		2,
		1,
		3,
		1,
		3,
		1,
		3,
		3,
		1,
		100000,
		"水#光#暗#源",
		"本周布阵要求：水、光、暗属性",
		14036,
		"（9.5 5:00-9.12 5:00）3个回合内强制结束战斗，己阵每存活1只精灵可获得100积分",
		"（9.5 5:00-9.12 5:00）圣盾会给BOSS阿瑞斯回血加气，根据对BOSS阿瑞斯实际扣除掉的血量换算积分，每10w点血量=1积分"
	},
	{
		510001,
		4,
		"2025-09-12T05:00:00",
		"2025-09-19T05:00:00",
		100,
		100000,
		1,
		8,
		7,
		2,
		1,
		4,
		1,
		4,
		1,
		4,
		4,
		1,
		100000,
		"水#火#源",
		"本周布阵要求：水、火属性",
		11034,
		"（9.12 5:00-9.19 5:00）击杀敌阵全部精灵，己阵每存活1只水or火属性精灵可获得100积分",
		"（9.12 5:00-9.19 5:00）根据两个BOSS实际扣除的血量换算积分，扣除血量差值越小积分越高，至少对两只boss造成10万伤害才能开始转换积分"
	}
}
local t_star_battle_period = {
	[510001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_star_battle_period.dataList = dataList

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

return t_star_battle_period
