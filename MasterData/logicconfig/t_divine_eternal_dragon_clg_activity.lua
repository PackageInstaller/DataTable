-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_eternal_dragon_clg_activity.lua

module("logicconfig.config.t_divine_eternal_dragon_clg_activity", package.seeall)

local title = {
	gotoStr1 = 3,
	gotoStr2 = 4,
	skinId = 2,
	gotoStr3 = 5,
	activityId = 1,
	ruleKey = 6
}
local dataList = {
	{
		445001,
		13022,
		"func#618#13022",
		"mibao#shenyaomiya2",
		"ui#lottery",
		"divine_eternal_dragon_rule_key"
	},
	{
		445002,
		13022,
		"func#618#13022",
		"mibao#shenyaomiya2",
		"ui#lottery",
		"divine_eternal_dragon_rule_key"
	}
}
local t_divine_eternal_dragon_clg_activity = {
	[445001] = dataList[1],
	[445002] = dataList[2]
}

t_divine_eternal_dragon_clg_activity.dataList = dataList

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

return t_divine_eternal_dragon_clg_activity
