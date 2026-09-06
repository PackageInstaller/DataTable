-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_welfare_activity.lua

module("logicconfig.config.t_origin_welfare_activity", package.seeall)

local title = {
	storyId = 5,
	redPointId = 2,
	jumpToHud = 4,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		538001,
		741,
		"origin_welfare_activity_rule",
		"ui#activitysmallsummarysixview",
		4820031
	}
}
local t_origin_welfare_activity = {
	[538001] = dataList[1]
}

t_origin_welfare_activity.dataList = dataList

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

return t_origin_welfare_activity
