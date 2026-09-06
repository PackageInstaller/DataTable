-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_repair_channel_activity.lua

module("logicconfig.config.t_repair_channel_activity", package.seeall)

local title = {
	btnJumpToStrs = 6,
	portalJumpToStrs = 7,
	storyId = 3,
	moveArea = 4,
	originPos = 5,
	activityId = 1,
	ruleKey = 2
}
local dataList = {
	{
		605001,
		"repair_channel_rule",
		4820095,
		{
			0,
			0,
			-130,
			150
		},
		{
			6,
			316
		},
		{
			"event#openholydragonfieldrank#611001",
			"func#191#605#605001",
			"func#1364"
		},
		{
			"func#1362",
			"func#1363"
		}
	}
}
local t_repair_channel_activity = {
	[605001] = dataList[1]
}

t_repair_channel_activity.dataList = dataList

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

return t_repair_channel_activity
