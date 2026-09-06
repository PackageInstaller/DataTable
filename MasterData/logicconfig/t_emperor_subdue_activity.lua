-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_emperor_subdue_activity.lua

module("logicconfig.config.t_emperor_subdue_activity", package.seeall)

local title = {
	bossHeadRaceId = 5,
	bossTitle = 6,
	ruleKey = 3,
	picRuleKey = 4,
	activityId = 1,
	bossOpenTime = 2
}
local dataList = {
	{
		547001,
		"2026-01-23T05:00:00",
		"emperor_subdue_rule_key",
		"emperor_subdue_pic_rule_key",
		15037,
		"念"
	}
}
local t_emperor_subdue_activity = {
	[547001] = dataList[1]
}

t_emperor_subdue_activity.dataList = dataList

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

return t_emperor_subdue_activity
