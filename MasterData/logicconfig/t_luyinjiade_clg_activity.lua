-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyinjiade_clg_activity.lua

module("logicconfig.config.t_luyinjiade_clg_activity", package.seeall)

local title = {
	dailyRankEndTime = 7,
	minScore2SubmitGodRank = 3,
	dailyRankStartTime = 6,
	skinId = 9,
	godRankLimit = 4,
	ruleKeyChallenge = 11,
	jumpStrTwo = 13,
	jumpStrOne = 12,
	dailyRankLimit = 5,
	jumpStrThree = 14,
	rankPrize = 8,
	challengeClosedTimeRange = 2,
	jumpStrFour = 15,
	ruleKeyMain = 10,
	activityId = 1
}
local dataList = {
	{
		465001,
		"02:00:00-09:00:00",
		50,
		1000,
		500,
		"2026-04-24T05:00:00",
		"2026-05-01T05:00:00",
		"100:15032:1:1",
		15032,
		"luyinjiadetiaozhan_rule",
		"luyinjiadetiaozhan_rule",
		"func#618#15032",
		"ui#luyinjiadechallengeranktabframeview",
		"mibao#ZhounianShop2",
		"mibao#Skin"
	}
}
local t_luyinjiade_clg_activity = {
	[465001] = dataList[1]
}

t_luyinjiade_clg_activity.dataList = dataList

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

return t_luyinjiade_clg_activity
