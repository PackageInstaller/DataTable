-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashless_long_yan_activity.lua

module("logicconfig.config.t_ashless_long_yan_activity", package.seeall)

local title = {
	skinId = 2,
	jumpStrOne = 5,
	jumpRedIdThree = 10,
	jumpStrThree = 7,
	goldMat = 3,
	jumpStrTwo = 6,
	jumpRedIdTwo = 9,
	jumpRedIdOne = 8,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		435001,
		12026,
		"1004:1416",
		"wujinlongyanchallenge_rule_main",
		"func#618#12026",
		"mibao#shuangjiekuanghuan3",
		"func#1165",
		"",
		"",
		""
	},
	{
		435002,
		12026,
		"1004:1416",
		"wujinlongyanchallenge_rule_main",
		"func#618#12026",
		"mibao#shuangjiekuanghuan3",
		"func#1165",
		"",
		"",
		""
	}
}
local t_ashless_long_yan_activity = {
	[435001] = dataList[1],
	[435002] = dataList[2]
}

t_ashless_long_yan_activity.dataList = dataList

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

return t_ashless_long_yan_activity
