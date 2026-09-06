-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_activity.lua

module("logicconfig.config.t_explore_under_activity", package.seeall)

local title = {
	levelPlanId = 4,
	fixedDiceLimit = 3,
	storyId = 5,
	diceConsume = 2,
	activityId = 1
}
local dataList = {
	{
		157001,
		"66:4:70",
		"1#1,2#1,3#1,4#1,5#1,6#1",
		1,
		4270004
	},
	{
		157002,
		"66:16:70",
		"1#1,2#1,3#1,4#1,5#1,6#1",
		2,
		4270004
	}
}
local t_explore_under_activity = {
	[157001] = dataList[1],
	[157002] = dataList[2]
}

t_explore_under_activity.dataList = dataList

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

return t_explore_under_activity
