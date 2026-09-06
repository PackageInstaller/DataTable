-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_golden_dragon_clg_activity.lua

module("logicconfig.config.t_origin_golden_dragon_clg_activity", package.seeall)

local title = {
	gotoStrs = 4,
	ruleKey = 3,
	activityId = 1,
	skinId = 2
}
local dataList = {
	{
		617001,
		14046,
		"yqhuangjinshenglong_rule",
		{
			"func#618#14046",
			"ui#lottery",
			"mibao#jinglingyangcheng",
			"func#545#52"
		}
	}
}
local t_origin_golden_dragon_clg_activity = {
	[617001] = dataList[1]
}

t_origin_golden_dragon_clg_activity.dataList = dataList

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

return t_origin_golden_dragon_clg_activity
