-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miya_challenge.lua

module("logicconfig.config.t_miya_challenge", package.seeall)

local title = {
	bossPrizePlanId = 7,
	endTime = 4,
	item = 8,
	tierPlanId = 2,
	buyTimeLimit = 5,
	buffId = 3,
	funcId = 11,
	decrease = 6,
	raceId = 10,
	activityId = 1,
	ruleKey = 9
}
local dataList = {
	{
		218001,
		1,
		43,
		"2022-12-16T05:00:00",
		5,
		"105:6051:100",
		1,
		"10:218001",
		"zhuzaimiya_rule",
		17008,
		{
			"func#43#201",
			"func#191#218#218001"
		}
	},
	{
		218002,
		2,
		43,
		"2022-09-22T05:00:00",
		5,
		"105:6066:100",
		2,
		"4:199",
		"jiehuangchallenge_rule",
		13012,
		{
			"mibao#yonghengguodu5",
			"func#191#218#218002",
			"func#955"
		}
	},
	{
		2180001,
		3,
		43,
		"2022-11-17T05:00:00",
		5,
		"105:6091:100",
		3,
		"10:2180001",
		"zhuzaimiya_rule",
		17008,
		{
			"func#43#201",
			"func#191#218#2180001"
		}
	}
}
local t_miya_challenge = {
	[218001] = dataList[1],
	[218002] = dataList[2],
	[2180001] = dataList[3]
}

t_miya_challenge.dataList = dataList

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

return t_miya_challenge
