-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_activity.lua

module("logicconfig.config.t_beast_rich_man_activity", package.seeall)

local title = {
	bossRuleKey = 15,
	ruleKey = 13,
	prizeItemScore = 10,
	collectRuleKey = 12,
	scoreMatStr = 8,
	prizeItemList = 11,
	prize = 3,
	redPointId = 2,
	ruleId = 17,
	cycle = 5,
	storageLimit = 4,
	paramStr = 6,
	activityId = 1,
	prizeBossScore = 9,
	ruleKeyShop = 14,
	stageBossRuleKey = 16,
	oneKeyPassGameCostNum = 7
}
local dataList = {
	{
		558001,
		757,
		"10:558002:30#10:558003:3",
		100000,
		60,
		"{\"jumpStr1\":\"func#191#558#558001\",\"jumpStr2\":\"ui#beastrichmanrankview#558001\",\"jumpStr3\":\"ui#commongrouptaskmainview#558001\"}",
		"200",
		"1004:1603:1",
		5,
		1,
		{
			558004,
			558005,
			558006,
			558007,
			558008,
			558009,
			558010,
			558011,
			558012,
			558013,
			558014,
			558015,
			558016,
			558017
		},
		"beast_rich_man_collect_rule",
		"beast_rich_man_rule",
		"beastrichmanshopview_rule",
		"beastrichmanbossview_rule",
		"beastrichmanbreakview_rule",
		1
	}
}
local t_beast_rich_man_activity = {
	[558001] = dataList[1]
}

t_beast_rich_man_activity.dataList = dataList

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

return t_beast_rich_man_activity
