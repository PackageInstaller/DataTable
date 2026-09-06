-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_draw_event.lua

module("logicconfig.config.t_rich_man_x_plan_draw_event", package.seeall)

local title = {
	cost = 3,
	eventId = 2,
	activityId = 1,
	multipleLimit = 4
}
local dataList = {
	{
		373001,
		1,
		120000,
		5
	},
	{
		373001,
		2,
		150000,
		5
	},
	{
		373001,
		3,
		250000,
		5
	},
	{
		373001,
		4,
		500000,
		5
	}
}
local t_rich_man_x_plan_draw_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_rich_man_x_plan_draw_event.dataList = dataList

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

return t_rich_man_x_plan_draw_event
