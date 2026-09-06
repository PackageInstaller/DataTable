-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qi_challenge.lua

module("logicconfig.config.t_qi_challenge", package.seeall)

local title = {
	dailyRuleKey = 8,
	ruleKey = 7,
	sealNum = 4,
	extremePlanId = 5,
	allPlanId = 2,
	deBuffId = 3,
	funcId = 10,
	raceId = 9,
	activityId = 1,
	deBuffPlanId = 6
}
local dataList = {
	{
		244001,
		1,
		6,
		3,
		1,
		1,
		"qimainview",
		"qimainview2",
		"14010",
		{
			"mibao#qixitehui1",
			"func#191#244#244001",
			"ui#publicdragontabview#4#1",
			"func#618#14010"
		}
	}
}
local t_qi_challenge = {
	[244001] = dataList[1]
}

t_qi_challenge.dataList = dataList

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

return t_qi_challenge
