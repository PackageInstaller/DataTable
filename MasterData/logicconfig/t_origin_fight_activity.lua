-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_activity.lua

module("logicconfig.config.t_origin_fight_activity", package.seeall)

local title = {
	gainTitanActivityId = 3,
	summonStoryId = 7,
	rewardGoto = 8,
	prize = 9,
	redPointId = 2,
	firstStoryId = 5,
	tiTanStoryId = 6,
	activityId = 1,
	ruleKey = 4
}
local dataList = {
	{
		525001,
		733,
		523001,
		"origin_fight_rule",
		4820021,
		4820022,
		4820030,
		"func#1274",
		"18:410:1#4:36:20#8:1:30000000#4:12102:5#4:11002:15000#4:90312:2"
	}
}
local t_origin_fight_activity = {
	[525001] = dataList[1]
}

t_origin_fight_activity.dataList = dataList

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

return t_origin_fight_activity
