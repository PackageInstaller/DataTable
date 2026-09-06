-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_shop_event_item.lua

module("logicconfig.config.t_rich_man_x_plan_shop_event_item", package.seeall)

local title = {
	itemId = 3,
	param = 5,
	cost = 6,
	type = 4,
	eventId = 2,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		1,
		1,
		"10:373002:2",
		20000
	},
	{
		373001,
		1,
		2,
		1,
		"10:373001:10",
		100000
	},
	{
		373001,
		1,
		3,
		2,
		"4",
		40000
	},
	{
		373001,
		1,
		4,
		2,
		"7",
		80000
	},
	{
		373001,
		1,
		5,
		1,
		"10:378001:1",
		100000
	},
	{
		373001,
		2,
		1,
		1,
		"10:373002:2",
		20000
	},
	{
		373001,
		2,
		2,
		1,
		"10:373001:20",
		200000
	},
	{
		373001,
		2,
		3,
		2,
		"5",
		50000
	},
	{
		373001,
		2,
		4,
		2,
		"8",
		100000
	},
	{
		373001,
		2,
		5,
		1,
		"10:378002:1",
		50000
	},
	{
		373001,
		3,
		1,
		1,
		"10:373002:2",
		20000
	},
	{
		373001,
		3,
		2,
		1,
		"10:373001:30",
		300000
	},
	{
		373001,
		3,
		3,
		2,
		"6",
		60000
	},
	{
		373001,
		3,
		4,
		2,
		"9",
		120000
	},
	{
		373001,
		3,
		5,
		1,
		"10:378001:1",
		100000
	},
	{
		373001,
		3,
		6,
		1,
		"10:378002:1",
		100000
	}
}
local t_rich_man_x_plan_shop_event_item = {
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
			dataList[15],
			dataList[16]
		}
	}
}

t_rich_man_x_plan_shop_event_item.dataList = dataList

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

return t_rich_man_x_plan_shop_event_item
