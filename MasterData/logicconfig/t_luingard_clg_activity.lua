-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luingard_clg_activity.lua

module("logicconfig.config.t_luingard_clg_activity", package.seeall)

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
	ruleKeyMain = 10,
	activityId = 1
}
local dataList = {
	{
		465001,
		"02:00:00-09:00:00",
		100,
		1000,
		100,
		"2024-02-23T05:00:00",
		"2024-03-08T05:00:00",
		"8:1:100",
		14031,
		"nailongevolvemainview_rule",
		"nailongevolvemainview_rule",
		"func#1198",
		"mibao#ZhounianShop2",
		"func#618#14031"
	}
}
local t_luingard_clg_activity = {
	[465001] = dataList[1]
}

t_luingard_clg_activity.dataList = dataList

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

return t_luingard_clg_activity
