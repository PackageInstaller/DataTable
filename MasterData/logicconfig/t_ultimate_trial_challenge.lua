-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_trial_challenge.lua

module("logicconfig.config.t_ultimate_trial_challenge", package.seeall)

local title = {
	clgIndex = 2,
	hasTimeRank = 11,
	clgActType = 5,
	jumpStr = 8,
	scoreRankPrizePlanId = 10,
	clgName = 6,
	scoreTitle = 13,
	clgActId = 4,
	supportPetPlanId = 15,
	mode = 3,
	timeRankPrizePlanId = 12,
	scoreRuleDesc = 14,
	limitStartTime = 7,
	hasScoreRank = 9,
	activityId = 1
}
local dataList = {
	{
		472001,
		1,
		1,
		471002,
		471,
		"神曜王者诺雅-全民试炼",
		"2025-04-30T10:00:00",
		"ui#divinekingnuoyainfinitefightchallengeview#471002",
		false,
		0,
		false,
		0,
		"",
		"",
		1
	},
	{
		472001,
		1,
		2,
		471003,
		471,
		"神曜王者诺雅-大神试炼",
		"2025-04-30T10:00:00",
		"ui#divinekingnuoyainfinitefightchallengeview#471003",
		true,
		1,
		true,
		2,
		"最高超杀",
		"1、根据超杀次数进行排名，次数越多，排名越靠前",
		0
	},
	{
		472001,
		2,
		1,
		473002,
		473,
		"神曜无敌-全民试炼",
		"2025-05-02T10:00:00",
		"ui#divineinvincibleextremeview#473002",
		false,
		0,
		false,
		0,
		"",
		"",
		1
	},
	{
		472001,
		2,
		2,
		473003,
		473,
		"神曜无敌-大神试炼",
		"2025-05-02T10:00:00",
		"ui#divineinvincibleextremeview#473003",
		true,
		1,
		true,
		2,
		"最高群攻",
		"1、根据群攻次数进行排名，次数越多，排名越靠前",
		0
	},
	{
		472001,
		3,
		1,
		469002,
		469,
		"神曜双生龙-全民试炼",
		"2025-05-16T10:00:00",
		"ui#ultimatetrialdualdragonlevelview#469002",
		false,
		0,
		false,
		0,
		"",
		"",
		1
	},
	{
		472001,
		3,
		2,
		469003,
		469,
		"神曜双生龙-大神试炼",
		"2025-05-16T10:00:00",
		"ui#ultimatetrialdualdragonlevelview#469003",
		true,
		1,
		true,
		2,
		"最低战力和",
		"1、根据己方上阵精灵的历史最低通关战力总和（去公共养成）排名，战力越低，排名越靠前",
		0
	}
}
local t_ultimate_trial_challenge = {
	[472001] = {
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6]
		}
	}
}

t_ultimate_trial_challenge.dataList = dataList

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

return t_ultimate_trial_challenge
