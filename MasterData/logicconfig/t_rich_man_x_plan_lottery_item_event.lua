-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_lottery_item_event.lua

module("logicconfig.config.t_rich_man_x_plan_lottery_item_event", package.seeall)

local title = {
	param = 5,
	type = 4,
	hitNum = 3,
	eventId = 2,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		373001,
		1,
		1,
		3,
		"1000",
		"预算"
	},
	{
		373001,
		1,
		2,
		3,
		"2000",
		"预算"
	},
	{
		373001,
		1,
		3,
		3,
		"3000",
		"预算"
	},
	{
		373001,
		1,
		4,
		3,
		"4000",
		"预算"
	},
	{
		373001,
		1,
		5,
		3,
		"5000",
		"预算"
	},
	{
		373001,
		2,
		1,
		3,
		"1000",
		"预算"
	},
	{
		373001,
		2,
		2,
		3,
		"2000",
		"预算"
	},
	{
		373001,
		2,
		3,
		3,
		"3000",
		"预算"
	},
	{
		373001,
		2,
		4,
		3,
		"4000",
		"预算"
	},
	{
		373001,
		2,
		5,
		3,
		"5000",
		"预算"
	},
	{
		373001,
		3,
		1,
		3,
		"1000",
		"预算"
	},
	{
		373001,
		3,
		2,
		3,
		"2000",
		"预算"
	},
	{
		373001,
		3,
		3,
		3,
		"3000",
		"预算"
	},
	{
		373001,
		3,
		4,
		3,
		"4000",
		"预算"
	},
	{
		373001,
		3,
		5,
		3,
		"5000",
		"预算"
	}
}
local t_rich_man_x_plan_lottery_item_event = {
	[373001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_rich_man_x_plan_lottery_item_event.dataList = dataList

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

return t_rich_man_x_plan_lottery_item_event
