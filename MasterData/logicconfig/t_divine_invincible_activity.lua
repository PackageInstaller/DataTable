-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_activity.lua

module("logicconfig.config.t_divine_invincible_activity", package.seeall)

local title = {
	skinId = 10,
	extremePlanId = 4,
	jumpRedIdThree = 18,
	jumpStrThree = 14,
	jumpRedIdFour = 19,
	jumpStrTwo = 13,
	jumpRedIdTwo = 17,
	normalSignBuffId = 9,
	extremeSignBuffId = 6,
	jumpRedIdOne = 16,
	activityId = 1,
	normalRaceId = 8,
	normalPlanId = 7,
	jumpStrOne = 12,
	extremeLockPetNum = 5,
	disablePhasePrize = 2,
	jumpStrFour = 15,
	ruleKeyMain = 11,
	extremePrize = 3
}
local dataList = {
	{
		473001,
		false,
		"4:510493:100",
		1,
		2,
		30000014,
		1,
		14032,
		30000034,
		14032,
		"divineinvinciblemainview_rule",
		"func#618#14032",
		"mibao#ZhounianShop1",
		"ui#lottery",
		"func#43#134",
		"",
		"",
		"",
		""
	},
	{
		473002,
		true,
		"8:1:1000",
		2,
		2,
		30000014,
		0,
		0,
		30000034,
		14032,
		"divineinvinciblemainview_rule2",
		"func#618#14032",
		"mibao#ZhounianShop1",
		"ui#lottery",
		"func#43#134",
		"",
		"",
		"",
		""
	},
	{
		473003,
		true,
		"8:1:1000",
		1,
		2,
		30000014,
		0,
		0,
		30000034,
		14032,
		"divineinvinciblemainview_rule2",
		"func#618#14032",
		"mibao#ZhounianShop1",
		"ui#lottery",
		"func#43#134",
		"",
		"",
		"",
		""
	}
}
local t_divine_invincible_activity = {
	[473001] = dataList[1],
	[473002] = dataList[2],
	[473003] = dataList[3]
}

t_divine_invincible_activity.dataList = dataList

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

return t_divine_invincible_activity
