-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_market_activity.lua

module("logicconfig.config.t_anniversary_market_activity", package.seeall)

local title = {
	rebatePercent = 7,
	recycleMpId = 5,
	refreshCoinMpKey = 3,
	jumpTask = 10,
	sellForOtherDailyLimit = 8,
	priceUnit = 4,
	commonPricePlanId = 6,
	ruleKeyMain = 9,
	activityId = 1,
	sellScoreMpKey = 2
}
local dataList = {
	{
		467001,
		"10:467001",
		"10:467002",
		1,
		321,
		1,
		10,
		100,
		"zhounianmarket_rule",
		"ui#commongrouptaskmainview#467001"
	},
	{
		467002,
		"10:467003",
		"10:467004",
		1,
		321,
		1,
		10,
		100,
		"zhounianmarket_rule",
		"ui#commongrouptaskmainview#467002"
	},
	{
		467003,
		"10:467005",
		"10:467006",
		1,
		321,
		1,
		10,
		100,
		"zhounianmarket_rule",
		"ui#commongrouptaskmainview#467003"
	},
	{
		467004,
		"10:467007",
		"10:467008",
		1,
		321,
		1,
		10,
		100,
		"zhounianmarket_rule",
		"ui#commongrouptaskmainview#467004"
	}
}
local t_anniversary_market_activity = {
	[467001] = dataList[1],
	[467002] = dataList[2],
	[467003] = dataList[3],
	[467004] = dataList[4]
}

t_anniversary_market_activity.dataList = dataList

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

return t_anniversary_market_activity
