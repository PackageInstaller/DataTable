-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wish_tree_bottle_activity.lua

module("logicconfig.config.t_wish_tree_bottle_activity", package.seeall)

local title = {
	likePrize = 3,
	refreshTime = 5,
	dailyLikeTimes = 2,
	activityId = 1,
	wishDescLength = 4
}
local dataList = {
	{
		328001,
		5,
		"8:1:5000",
		50,
		10
	},
	{
		328002,
		5,
		"8:1:5000",
		50,
		10
	},
	{
		328003,
		5,
		"8:1:5000",
		50,
		10
	}
}
local t_wish_tree_bottle_activity = {
	[328001] = dataList[1],
	[328002] = dataList[2],
	[328003] = dataList[3]
}

t_wish_tree_bottle_activity.dataList = dataList

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

return t_wish_tree_bottle_activity
