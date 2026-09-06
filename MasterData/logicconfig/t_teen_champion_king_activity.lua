-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_activity.lua

module("logicconfig.config.t_teen_champion_king_activity", package.seeall)

local title = {
	selectPetCount = 9,
	sysZdlWanPercent = 5,
	winPrize = 6,
	ruleKey2 = 16,
	dailyGuessCoin = 4,
	exchangeItem = 3,
	ruleKey4 = 18,
	championScoreWinAddScore = 10,
	failPrize = 7,
	ruleKey3 = 17,
	redPointId = 19,
	dailyFightTimes = 8,
	ruleKey1 = 15,
	activityId = 1,
	guessItem = 2,
	reportLimit = 11,
	maxGuessScore = 14,
	shopGotoStr = 13,
	ruleKey = 12
}
local dataList = {
	{
		501001,
		"10:501002",
		"10:501001",
		500,
		10000,
		"10:501001:100",
		"10:501001:50",
		10,
		20,
		20,
		10,
		"young_champion_king_rule",
		"func#191#501#501001",
		100000,
		"young_champion_king_rule1",
		"young_champion_king_rule2",
		"young_champion_king_rule3",
		"young_champion_king_rule4",
		717
	}
}
local t_teen_champion_king_activity = {
	[501001] = dataList[1]
}

t_teen_champion_king_activity.dataList = dataList

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

return t_teen_champion_king_activity
