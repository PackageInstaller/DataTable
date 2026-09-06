-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_contest_activity.lua

module("logicconfig.config.t_magic_contest_activity", package.seeall)

local title = {
	goldItem = 12,
	winStreakPlanId = 5,
	termWinPrize = 8,
	jumpStrThree = 16,
	termPrizeMpId = 10,
	winAddScore = 4,
	jumpStrTwo = 15,
	jumpRedIdTwo = 18,
	jumpRedIdThree = 19,
	jumpRedIdOne = 17,
	advanceBalanceMinutes = 11,
	maxSelectBuffCount = 6,
	dailyChallengeTimes = 2,
	activityId = 1,
	jumpStrOne = 14,
	matchPlanId = 7,
	excludeMatchRecentCount = 3,
	ruleKeyMain = 13,
	termLosePrize = 9
}
local dataList = {
	{
		514001,
		10,
		10,
		10,
		1,
		4,
		1,
		"10:17168:1000#8:1:6660000#4:108:3",
		"10:17168:500#8:1:3880000#4:107:3",
		356,
		30,
		"10:17168",
		"heibaiduijue_rule_main",
		"func#191#17#17168",
		"ui#commongrouptaskmainview#514001",
		"",
		"",
		"735",
		""
	}
}
local t_magic_contest_activity = {
	[514001] = dataList[1]
}

t_magic_contest_activity.dataList = dataList

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

return t_magic_contest_activity
