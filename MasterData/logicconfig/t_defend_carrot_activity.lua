-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_activity.lua

module("logicconfig.config.t_defend_carrot_activity", package.seeall)

local title = {
	stroyId = 7,
	costItem = 6,
	redPointId = 2,
	jumpTo = 5,
	dailyTimes = 3,
	activityId = 1,
	ruleKey = 4
}
local dataList = {
	{
		517001,
		729,
		2,
		"defend_carrot_rule",
		"func#191#517#517001",
		"10:517002",
		4820012
	}
}
local t_defend_carrot_activity = {
	[517001] = dataList[1]
}

t_defend_carrot_activity.dataList = dataList

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

return t_defend_carrot_activity
