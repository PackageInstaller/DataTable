-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_gambling_event.lua

module("logicconfig.config.t_rich_man_x_plan_gambling_event", package.seeall)

local title = {
	diceNum = 5,
	diceRange = 6,
	refreshCost = 3,
	refreshLimit = 4,
	eventId = 2,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		10000,
		5,
		3,
		6
	},
	{
		373001,
		2,
		10000,
		5,
		3,
		6
	},
	{
		373001,
		3,
		10000,
		5,
		3,
		6
	},
	{
		373001,
		4,
		10000,
		5,
		3,
		6
	},
	{
		373001,
		5,
		10000,
		5,
		3,
		6
	},
	{
		373001,
		6,
		10000,
		5,
		3,
		6
	}
}
local t_rich_man_x_plan_gambling_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_rich_man_x_plan_gambling_event.dataList = dataList

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

return t_rich_man_x_plan_gambling_event
