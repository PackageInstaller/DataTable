-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_plant_god_tree_event.lua

module("logicconfig.config.t_plant_god_tree_event", package.seeall)

local title = {
	interval = 4,
	dailyLimit = 3,
	prize = 6,
	saveLimit = 5,
	eventId = 2,
	activityId = 1
}
local dataList = {
	{
		556001,
		1,
		5,
		30,
		3,
		"10:555001:5"
	},
	{
		556001,
		2,
		5,
		30,
		3,
		"10:555001:5"
	}
}
local t_plant_god_tree_event = {
	[556001] = {
		dataList[1],
		dataList[2]
	}
}

t_plant_god_tree_event.dataList = dataList

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

return t_plant_god_tree_event
