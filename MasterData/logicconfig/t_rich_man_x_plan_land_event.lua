-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_land_event.lua

module("logicconfig.config.t_rich_man_x_plan_land_event", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	iconRes = 5,
	eventId = 2,
	prize = 4
}
local dataList = {
	{
		373001,
		1,
		10000,
		30000,
		"com_icon_zijifangzi"
	},
	{
		373001,
		2,
		20000,
		60000,
		"com_icon_zijifangzi"
	},
	{
		373001,
		3,
		30000,
		90000,
		"com_icon_zijifangzi"
	},
	{
		373001,
		4,
		40000,
		120000,
		"com_icon_zijifangzi"
	},
	{
		373001,
		5,
		50000,
		150000,
		"com_icon_zijifangzi"
	}
}
local t_rich_man_x_plan_land_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_rich_man_x_plan_land_event.dataList = dataList

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

return t_rich_man_x_plan_land_event
