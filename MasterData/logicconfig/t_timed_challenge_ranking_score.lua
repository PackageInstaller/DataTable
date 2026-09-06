-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_ranking_score.lua

module("logicconfig.config.t_timed_challenge_ranking_score", package.seeall)

local title = {
	buffBuyTimesCost = 10,
	scorePlanId = 12,
	bossEnterBattleView = 17,
	jumpTo = 21,
	name = 2,
	buyNeedVipLv = 11,
	bossBuyTimesCost = 7,
	dailyRankLimit = 20,
	bossWithBuffs = 19,
	bossId = 4,
	buffEnterBattleView = 16,
	dailyRankPrize = 13,
	buffFreeTimes = 8,
	bossFreeTimes = 5,
	challengeId = 1,
	buffShowView = 15,
	settlementView = 18,
	notFightDays = 14,
	closeRange = 3,
	bossBuyTimes = 6,
	buffBuyTimes = 9
}
local dataList = {
	{
		27,
		"秩序龙挑战",
		"02:00:00-09:00:00",
		1,
		5,
		3,
		"105:193:100",
		5,
		0,
		"105:193:100",
		0,
		1,
		"100:11002:1:1",
		2,
		"zhixulongbuffshowview",
		"zhixulongbuffenterview",
		"zhixulongbossenterview",
		"zhixulongsettlementview",
		{
			1,
			2,
			3,
			4
		},
		500,
		"func#43#201"
	}
}
local t_timed_challenge_ranking_score = {
	[27] = dataList[1]
}

t_timed_challenge_ranking_score.dataList = dataList

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

return t_timed_challenge_ranking_score
