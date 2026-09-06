-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_activity.lua

module("logicconfig.config.t_ultimate_war_activity", package.seeall)

local title = {
	mainRuleKey = 5,
	score2Item = 2,
	petUpRuleKey = 9,
	jumpStrOne = 10,
	secondStepSubmitFormRank = 4,
	jumpStrTwo = 11,
	firstStepRule = 6,
	gameJumpStr = 13,
	thirdStepRule = 8,
	itemStr = 3,
	gameReds = 14,
	gameType = 12,
	activityId = 1,
	secondStepRule = 7
}
local dataList = {
	{
		434001,
		100000,
		"10:434001",
		100,
		"ultimatewarmainview_main_rule",
		"ultimatewardispatchpartview_rule",
		"ultimatewartowerstageview_rule",
		"ultimatewarfinalbossview_rule",
		"ultimatewaruppetview_rule",
		"mibao#shenyaolibao",
		"func#191#434#434001",
		1,
		"event#enteraixinmmgame#281004",
		"491"
	}
}
local t_ultimate_war_activity = {
	[434001] = dataList[1]
}

t_ultimate_war_activity.dataList = dataList

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

return t_ultimate_war_activity
