-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buddy_lucky_bag_activity.lua

module("logicconfig.config.t_buddy_lucky_bag_activity", package.seeall)

local title = {
	openBagLimit = 2,
	templateId = 10,
	jumpStrInCard = 9,
	gainPrizeLimit = 3,
	sharePrizeTemplateId = 11,
	firstHelpUnlockCount = 5,
	gainLuckCost = 4,
	ruleKeyCard = 7,
	ruleKeyMain = 6,
	activityId = 1,
	jumpStrToCard = 8
}
local dataList = {
	{
		544001,
		6,
		2,
		"10:544002:1",
		1,
		"chaifudaiview_rule",
		"fuqijiamanview_rule",
		"itemsource#10:544002",
		"itemsource#10:544001",
		93,
		94
	},
	{
		544002,
		6,
		3,
		"10:544004:1",
		1,
		"chaifudaiview_rule",
		"fuqijiamanview_rule",
		"itemsource#10:544004",
		"itemsource#10:544003",
		93,
		94
	},
	{
		544003,
		6,
		2,
		"10:544006:1",
		1,
		"chaifudaiview_rule",
		"fuqijiamanview_rule",
		"itemsource#10:544006",
		"itemsource#10:544005",
		93,
		94
	}
}
local t_buddy_lucky_bag_activity = {
	[544001] = dataList[1],
	[544002] = dataList[2],
	[544003] = dataList[3]
}

t_buddy_lucky_bag_activity.dataList = dataList

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

return t_buddy_lucky_bag_activity
