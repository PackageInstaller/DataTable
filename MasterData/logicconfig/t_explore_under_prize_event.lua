-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_prize_event.lua

module("logicconfig.config.t_explore_under_prize_event", package.seeall)

local title = {
	iconId = 4,
	rewards = 3,
	planId = 1,
	subId = 2
}
local dataList = {
	{
		1,
		1,
		"8:1:1000",
		1
	},
	{
		1,
		2,
		"104:2:50#4:71002:2",
		6
	}
}
local t_explore_under_prize_event = {
	{
		dataList[1],
		dataList[2]
	}
}

t_explore_under_prize_event.dataList = dataList

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

return t_explore_under_prize_event
