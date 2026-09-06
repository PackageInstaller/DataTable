-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_activity.lua

module("logicconfig.config.t_destroy_evil_activity", package.seeall)

local title = {
	refreshListCd = 21,
	buyStrengthValue = 18,
	strongChallengeStrengthCost = 4,
	inheritBuddyRatio = 12,
	needKillLv = 22,
	fixHelpTimes = 5,
	buyTicketId = 9,
	inheritBuddyRank = 10,
	buffPlanId = 19,
	jumpTo1 = 20,
	inheritRequiredScore = 11,
	reportNumLimit = 13,
	initStar = 7,
	noPaidHelpTimes = 6,
	activityId = 1,
	publicAfterPlayerHelpCount = 24,
	itemKey = 2,
	strengthLimit = 16,
	strengthDailyPresent = 15,
	recommendNumLimit = 14,
	strengthCost = 3,
	resetDifficultyCostPlanId = 23,
	timeGap = 17,
	initLevel = 8
}
local dataList = {
	{
		322001,
		"10:322001",
		1,
		2,
		20,
		40,
		1,
		1,
		1,
		3,
		10,
		500,
		30,
		15,
		50,
		240,
		360,
		1,
		1,
		"func#191#322#322001",
		10,
		50,
		1,
		5
	},
	{
		322002,
		"10:322005",
		6,
		12,
		10,
		40,
		1,
		1,
		1,
		3,
		10,
		500,
		30,
		15,
		180,
		360,
		360,
		30,
		2,
		"func#191#322#322002",
		10,
		50,
		1,
		5
	},
	{
		322003,
		"10:322009",
		6,
		12,
		10,
		40,
		1,
		1,
		1,
		3,
		10,
		500,
		30,
		15,
		180,
		360,
		360,
		30,
		3,
		"func#191#322#322002",
		10,
		50,
		1,
		5
	}
}
local t_destroy_evil_activity = {
	[322001] = dataList[1],
	[322002] = dataList[2],
	[322003] = dataList[3]
}

t_destroy_evil_activity.dataList = dataList

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

return t_destroy_evil_activity
