-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_holy_dragon_clg_activity_define.lua

module("logicconfig.config.t_eternal_holy_dragon_clg_activity_define", package.seeall)

local title = {
	title = 7,
	iconName = 8,
	gameRuleKey = 6,
	jumpTo = 3,
	raceId = 4,
	petVerifyPlanId = 2,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		301001,
		54,
		{
			"func#940",
			"mibao#yonghengguodu1",
			"func#618#13008"
		},
		13008,
		"yonghengshenglong_rule",
		"yonghengshenglong_rule2",
		"无限生灵",
		"ui/icon/headicon/com_player_cxsl"
	},
	{
		301002,
		54,
		{
			"func#940",
			"mibao#yonghengguodu1",
			"func#618#13008"
		},
		13008,
		"yonghengshenglong_rule",
		"yonghengshenglong_rule2",
		"无限生灵",
		"ui/icon/headicon/com_player_cxsl"
	}
}
local t_eternal_holy_dragon_clg_activity_define = {
	[301001] = dataList[1],
	[301002] = dataList[2]
}

t_eternal_holy_dragon_clg_activity_define.dataList = dataList

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

return t_eternal_holy_dragon_clg_activity_define
