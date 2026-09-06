-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hot_search_activity.lua

module("logicconfig.config.t_hot_search_activity", package.seeall)

local title = {
	kudosPrize = 6,
	giftItem = 7,
	ruleKeyMain = 12,
	dailyKudosLimit = 4,
	heatValueRatio = 2,
	giftForPrize = 10,
	informationLimit = 3,
	giftAddHeatValue = 8,
	redPointId = 11,
	kudosAddHeatValue = 5,
	giftPrizeRatio = 9,
	activityId = 1
}
local dataList = {
	{
		443001,
		3,
		7,
		3,
		20,
		"8:1:1000",
		"10:443001",
		50,
		1,
		"8:1:100000",
		671,
		"nailongresou_rule"
	}
}
local t_hot_search_activity = {
	[443001] = dataList[1]
}

t_hot_search_activity.dataList = dataList

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

return t_hot_search_activity
