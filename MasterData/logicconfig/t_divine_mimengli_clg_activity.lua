-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mimengli_clg_activity.lua

module("logicconfig.config.t_divine_mimengli_clg_activity", package.seeall)

local title = {
	skinId = 2,
	jumpStrOne = 4,
	jumpRedIdThree = 9,
	jumpStrThree = 6,
	jumpStrTwo = 5,
	jumpRedIdTwo = 8,
	jumpRedIdOne = 7,
	ruleKeyMain = 3,
	activityId = 1
}
local dataList = {
	{
		460001,
		12029,
		"shenyaomml_rule_main",
		"func#618#12029",
		"mibao#shuangjiekuanghuan3",
		"ui#lottery",
		"",
		"",
		""
	},
	{
		460002,
		12029,
		"shenyaomml_rule_main2",
		"func#618#12029",
		"mibao#shuangjiekuanghuan3",
		"ui#lottery",
		"",
		"",
		""
	}
}
local t_divine_mimengli_clg_activity = {
	[460001] = dataList[1],
	[460002] = dataList[2]
}

t_divine_mimengli_clg_activity.dataList = dataList

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

return t_divine_mimengli_clg_activity
