-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_yu_hui_clg_activity.lua

module("logicconfig.config.t_divine_yu_hui_clg_activity", package.seeall)

local title = {
	activityId = 1,
	jumpTo = 5,
	skinId = 3,
	prize = 2,
	ruleKey = 4
}
local dataList = {
	{
		499001,
		"4:298:100",
		12036,
		"syyuhui_rule_main",
		{
			"func#618#12036",
			"ui#lottery",
			"mibao#shenyaolibao",
			"mibao#shengqiyangcheng"
		}
	}
}
local t_divine_yu_hui_clg_activity = {
	[499001] = dataList[1]
}

t_divine_yu_hui_clg_activity.dataList = dataList

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

return t_divine_yu_hui_clg_activity
