-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge.lua

module("logicconfig.config.t_sun_wu_kong_challenge", package.seeall)

local title = {
	raceId = 7,
	goldBar2 = 9,
	dailyPrize = 10,
	jumpTo = 6,
	stagePlanId = 2,
	cimeliaPlanId = 3,
	redPointId = 4,
	goldBar1 = 8,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		263001,
		1,
		1,
		478,
		"sunwukongview_rule",
		{
			"mibao#honglianyaoshi2",
			"ui#publicdragontabview#10#1",
			"func#191#263#263001",
			"func#618#12010"
		},
		12010,
		"4:184:1",
		"4:184:1#4:190:1",
		""
	},
	{
		263002,
		2,
		2,
		0,
		"divinefeiyinchallengemainview_rule",
		{
			"mibao#honglianyaoshi2",
			"ui#lottery",
			"func#545#3",
			"func#618#16037"
		},
		16037,
		"4:291:1",
		"4:291:1#4:292:1",
		"4:292:30"
	}
}
local t_sun_wu_kong_challenge = {
	[263001] = dataList[1],
	[263002] = dataList[2]
}

t_sun_wu_kong_challenge.dataList = dataList

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

return t_sun_wu_kong_challenge
