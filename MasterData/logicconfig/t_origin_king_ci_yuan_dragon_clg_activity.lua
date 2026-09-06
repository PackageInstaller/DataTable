-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_ci_yuan_dragon_clg_activity.lua

module("logicconfig.config.t_origin_king_ci_yuan_dragon_clg_activity", package.seeall)

local title = {
	jumpStrThree = 7,
	jumpStrOne = 5,
	jumpRedIdTwo = 11,
	skinId = 4,
	jumpRedIdThree = 12,
	jumpStrTwo = 6,
	passPrize = 2,
	jumpRedIdFour = 13,
	jumpRedIdOne = 10,
	jumpStrFive = 9,
	jumpStrFour = 8,
	ruleKeyMain = 3,
	activityId = 1
}
local dataList = {
	{
		534001,
		"4:431:100",
		"xinwangzheciyuan_rule_main",
		14042,
		"event#gotofirstpassrankview#534001",
		"func#618#14042",
		"mibao#MibaoShop",
		"ui#lottery",
		"",
		"",
		"",
		"",
		""
	}
}
local t_origin_king_ci_yuan_dragon_clg_activity = {
	[534001] = dataList[1]
}

t_origin_king_ci_yuan_dragon_clg_activity.dataList = dataList

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

return t_origin_king_ci_yuan_dragon_clg_activity
