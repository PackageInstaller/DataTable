-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_activity.lua

module("logicconfig.config.t_saint_knight_expedition_activity", package.seeall)

local title = {
	islandRuleKey = 9,
	bossBuffNum = 4,
	shopJump = 10,
	mainRuleKey = 6,
	miningCost = 3,
	gameActivityId = 5,
	miningRuleKey = 8,
	redPointId = 2,
	activityId = 1,
	clgRuleKey = 7
}
local dataList = {
	{
		481001,
		711,
		"66:19:1",
		3,
		479001,
		"stknexpmainview_rule",
		"stknexpclgtabview_rule",
		"stknexpminingview_rule",
		"stknexpislandview_rule",
		"func#191#481#481001"
	}
}
local t_saint_knight_expedition_activity = {
	[481001] = dataList[1]
}

t_saint_knight_expedition_activity.dataList = dataList

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

return t_saint_knight_expedition_activity
