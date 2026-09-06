-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_activity.lua

module("logicconfig.config.t_dream_team_chapter_activity", package.seeall)

local title = {
	chapter3SupportPetPlan = 5,
	dailyBossChallengeTimes = 3,
	smeltPotionFailScore = 8,
	chap2StoryId = 16,
	chap2EndStoryId = 17,
	ruleIdDuolaMM = 27,
	chap3EndStoryId = 19,
	jumpTo3 = 11,
	duolaMMActId = 20,
	ruleKeyChap2 = 23,
	redPointId = 2,
	ruleKeyChap3 = 24,
	ruleKeyOtherMM = 25,
	qualityShowTitleList = 12,
	activityId = 1,
	chap3StoryId = 18,
	chapter3creepsMasterId = 4,
	jumpTo2 = 10,
	awakenMengMengPrize = 7,
	chap3SkinId = 6,
	worldProgressDamage = 13,
	chap1StoryId = 14,
	chap1EndStoryId = 15,
	jumpTo1 = 9,
	ruleIdAlchemyMM = 26,
	ruleKeySummary = 22,
	chap1ActId = 21
}
local dataList = {
	{
		595001,
		775,
		5,
		1021,
		2,
		17017,
		"10:595007:6000",
		5,
		"func#618#17029",
		"func#191#595#595001",
		"",
		{
			"S",
			"A",
			"B"
		},
		"6.82948490230906E12",
		4830007,
		4830009,
		4830010,
		4830011,
		4830012,
		4830013,
		604001,
		365002,
		"dream_team_chapter_rule",
		"dream_team_chapter2_rule",
		"dream_team_chapter3_rule",
		"dream_team_chapter2_rule",
		1,
		1
	}
}
local t_dream_team_chapter_activity = {
	[595001] = dataList[1]
}

t_dream_team_chapter_activity.dataList = dataList

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

return t_dream_team_chapter_activity
