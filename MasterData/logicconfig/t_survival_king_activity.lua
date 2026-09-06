-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_activity.lua

module("logicconfig.config.t_survival_king_activity", package.seeall)

local title = {
	gotoTask = 10,
	gotoExchange = 5,
	openTime = 6,
	skinId = 8,
	endTime = 7,
	picRuleKey = 4,
	buffMode = 12,
	taskPointId = 11,
	redPointId = 9,
	prizeTimes = 2,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		529001,
		2,
		"rule_survival_king",
		"pic_rule_survival_king",
		"func#191#17#17173",
		"08:00:00",
		"00:00:00",
		1801102,
		740,
		"ui#commongrouptaskmainview#529001",
		445,
		1
	},
	{
		529002,
		2,
		"rule_survival_king",
		"pic_rule_survival_king",
		"func#191#529#529002",
		"08:00:00",
		"00:00:00",
		1604603,
		740,
		"ui#commongrouptaskmainview#529002",
		445,
		2
	}
}
local t_survival_king_activity = {
	[529001] = dataList[1],
	[529002] = dataList[2]
}

t_survival_king_activity.dataList = dataList

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

return t_survival_king_activity
