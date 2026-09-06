-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_tarot_item_event.lua

module("logicconfig.config.t_rich_man_x_plan_tarot_item_event", package.seeall)

local title = {
	itemId = 3,
	param = 5,
	type = 4,
	eventId = 2,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		1,
		3,
		"80000"
	},
	{
		373001,
		1,
		2,
		3,
		"50000"
	},
	{
		373001,
		1,
		3,
		3,
		"20000"
	},
	{
		373001,
		2,
		1,
		3,
		"150000"
	},
	{
		373001,
		2,
		2,
		3,
		"100000"
	},
	{
		373001,
		2,
		3,
		3,
		"50000"
	},
	{
		373001,
		3,
		1,
		3,
		"300000"
	},
	{
		373001,
		3,
		2,
		3,
		"200000"
	},
	{
		373001,
		3,
		3,
		3,
		"100000"
	}
}
local t_rich_man_x_plan_tarot_item_event = {
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
		}
	}
}

t_rich_man_x_plan_tarot_item_event.dataList = dataList

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

return t_rich_man_x_plan_tarot_item_event
