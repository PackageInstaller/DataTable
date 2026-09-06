-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_gambling_item_event.lua

module("logicconfig.config.t_rich_man_x_plan_gambling_item_event", package.seeall)

local title = {
	itemId = 3,
	range = 6,
	param = 5,
	type = 4,
	eventId = 2,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		373001,
		1,
		1,
		1,
		"10:373003:1",
		{
			3,
			8
		},
		"遥控骰子*1"
	},
	{
		373001,
		1,
		2,
		2,
		"1",
		{
			9,
			13
		},
		"资金收益增加20%，持续10次投骰子"
	},
	{
		373001,
		1,
		3,
		1,
		"10:373001:10",
		{
			14,
			18
		},
		"探奇奖徽*10"
	},
	{
		373001,
		2,
		1,
		1,
		"10:373003:1",
		{
			3,
			8
		},
		"遥控骰子*1"
	},
	{
		373001,
		2,
		2,
		1,
		"10:373001:10",
		{
			9,
			13
		},
		"探奇奖徽*10"
	},
	{
		373001,
		2,
		3,
		2,
		"2",
		{
			14,
			18
		},
		"资金收益增加50%，持续9次投骰子"
	},
	{
		373001,
		3,
		1,
		2,
		"3",
		{
			3,
			8
		},
		"资金收益增加80%，持续8次投骰子"
	},
	{
		373001,
		3,
		2,
		1,
		"10:373003:1",
		{
			9,
			13
		},
		"遥控骰子*1"
	},
	{
		373001,
		3,
		3,
		1,
		"10:373001:10",
		{
			14,
			18
		},
		"探奇奖徽*10"
	},
	{
		373001,
		4,
		1,
		2,
		"1",
		{
			3,
			8
		},
		"资金收益增加20%，持续10次投骰子"
	},
	{
		373001,
		4,
		2,
		1,
		"10:373001:10",
		{
			9,
			13
		},
		"探奇奖徽*10"
	},
	{
		373001,
		4,
		3,
		1,
		"10:373003:1",
		{
			14,
			18
		},
		"遥控骰子*1"
	},
	{
		373001,
		5,
		1,
		1,
		"10:373001:10",
		{
			3,
			8
		},
		"探奇奖徽*10"
	},
	{
		373001,
		5,
		2,
		2,
		"2",
		{
			9,
			13
		},
		"资金收益增加50%，持续9次投骰子"
	},
	{
		373001,
		5,
		3,
		1,
		"10:373003:1",
		{
			14,
			18
		},
		"遥控骰子*1"
	},
	{
		373001,
		6,
		1,
		1,
		"10:373001:10",
		{
			3,
			8
		},
		"探奇奖徽*10"
	},
	{
		373001,
		6,
		2,
		1,
		"10:373003:1",
		{
			9,
			13
		},
		"遥控骰子*1"
	},
	{
		373001,
		6,
		3,
		2,
		"3",
		{
			14,
			18
		},
		"资金收益增加80%，持续8次投骰子"
	}
}
local t_rich_man_x_plan_gambling_item_event = {
	[373001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_rich_man_x_plan_gambling_item_event.dataList = dataList

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

return t_rich_man_x_plan_gambling_item_event
