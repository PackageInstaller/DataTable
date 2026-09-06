-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_festival_activity.lua

module("logicconfig.config.t_lantern_festival_activity", package.seeall)

local title = {
	checkInDays = 4,
	gotoCollect = 8,
	activityId = 1,
	collectRuleKey = 10,
	gotoCollectItem = 9,
	personExtPrize = 5,
	personQuastionPlan = 11,
	gotoShop = 7,
	dailyChannelPrizeLimit = 2,
	personLanternPrize = 3,
	ruleKey = 6
}
local dataList = {
	{
		566001,
		10,
		"10:566001:200",
		5,
		"13:527:1",
		"lantern_festival_rule",
		"func#191#562#562001",
		"ui#lanternfestivalcollectview#566001",
		"ui#chat#16",
		"lantern_festival_collect_rule",
		1
	}
}
local t_lantern_festival_activity = {
	[566001] = dataList[1]
}

t_lantern_festival_activity.dataList = dataList

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

return t_lantern_festival_activity
