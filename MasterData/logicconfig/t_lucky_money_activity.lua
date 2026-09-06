-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_money_activity.lua

module("logicconfig.config.t_lucky_money_activity", package.seeall)

local title = {
	redPointId = 4,
	ruleKey = 5,
	dailyActLimit = 2,
	danMuYArea = 6,
	firstStoryId = 7,
	activityId = 1,
	scoreLimit = 3
}
local dataList = {
	{
		438001,
		3,
		200,
		664,
		"lucky_money_rule",
		{
			299,
			-67
		},
		4760004
	}
}
local t_lucky_money_activity = {
	[438001] = dataList[1]
}

t_lucky_money_activity.dataList = dataList

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

return t_lucky_money_activity
