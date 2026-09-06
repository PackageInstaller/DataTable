-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_fu_yao_clg_activity.lua

module("logicconfig.config.t_divine_fu_yao_clg_activity", package.seeall)

local title = {
	prizeKeyMain = 5,
	jumpStrOne = 7,
	jumpStrThree = 9,
	skinId = 3,
	jumpRedIdThree = 14,
	prizeKeyJixian = 6,
	jumpStrTwo = 8,
	jumpRedIdTwo = 13,
	jumpRedIdFour = 15,
	jumpRedIdOne = 12,
	jumpStrFive = 11,
	jumpStrFour = 10,
	ruleKeyMain = 4,
	activityId = 1,
	extremePrize = 2
}
local dataList = {
	{
		502001,
		"4:299:100",
		12033,
		"shenyaofy_rule_main",
		"shenyaofyReward_rule_main",
		"shenyaofyJX_rule_main",
		"func#618#12033",
		"ui#lottery",
		"mibao#Yangchenglibao",
		"event#gotofirstpassrankview#502001",
		"func#43#134",
		"",
		"",
		"",
		""
	}
}
local t_divine_fu_yao_clg_activity = {
	[502001] = dataList[1]
}

t_divine_fu_yao_clg_activity.dataList = dataList

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

return t_divine_fu_yao_clg_activity
