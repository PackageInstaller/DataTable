-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_rush_event.lua

module("logicconfig.config.t_rich_man_x_plan_rush_event", package.seeall)

local title = {
	raceId = 4,
	eventId = 2,
	activityId = 1,
	diceType = 3
}
local dataList = {
	{
		373001,
		1,
		3,
		13015
	},
	{
		373001,
		2,
		3,
		1301603
	},
	{
		373001,
		3,
		3,
		1301701
	}
}
local t_rich_man_x_plan_rush_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_rush_event.dataList = dataList

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

return t_rich_man_x_plan_rush_event
