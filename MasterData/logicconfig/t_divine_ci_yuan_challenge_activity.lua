-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ci_yuan_challenge_activity.lua

module("logicconfig.config.t_divine_ci_yuan_challenge_activity", package.seeall)

local title = {
	ruleKeyMain = 15,
	jump_rank = 14,
	jump_gift = 12,
	raceId = 9,
	ruleKeyExtreme = 17,
	universalOneKeyPassUnitPrice = 7,
	ruleKeyBuff = 18,
	extremePassPrize = 2,
	redPointId = 10,
	jump_evolution = 11,
	ruleKeyNation = 16,
	activityId = 1,
	universalSignInTimes = 3,
	universalOneKeySignInOpenTime = 8,
	jump_passport = 13,
	universalDailyTimes = 4,
	universalOneKeyPassOpenTime = 6,
	universalPassPrize = 5
}
local dataList = {
	{
		302001,
		"4:510228:100",
		4,
		5,
		"4:510228:100",
		"2023-09-28T05:00:00",
		"105:6069:2",
		"2023-09-28T05:00:00",
		14016,
		512,
		"func#856",
		"mibao#shenyaolibao",
		"func#545#25",
		"func#618#14016",
		"divineciyuanextreme_rule",
		"divineciyuannation_rule",
		"divineciyuanextreme_rule",
		"divineciyuanbuff_rule"
	},
	{
		302002,
		"8:1:1",
		4,
		5,
		"8:1:1",
		"2023-09-28T05:00:00",
		"105:6069:2",
		"2023-09-28T05:00:00",
		14016,
		787,
		"func#856",
		"mibao#shenyaolibao",
		"func#545#25",
		"func#618#14016",
		"divineciyuanextreme_rule1",
		"divineciyuanextreme_rule1",
		"divineciyuanextreme_rule1",
		"divineciyuanextreme_rule1"
	}
}
local t_divine_ci_yuan_challenge_activity = {
	[302001] = dataList[1],
	[302002] = dataList[2]
}

t_divine_ci_yuan_challenge_activity.dataList = dataList

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

return t_divine_ci_yuan_challenge_activity
