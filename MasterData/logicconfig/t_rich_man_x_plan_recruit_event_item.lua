-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_recruit_event_item.lua

module("logicconfig.config.t_rich_man_x_plan_recruit_event_item", package.seeall)

local title = {
	raceId = 3,
	eventId = 2,
	activityId = 1,
	cost = 4
}
local dataList = {
	{
		373001,
		1,
		1,
		10000
	},
	{
		373001,
		1,
		2,
		10000
	},
	{
		373001,
		1,
		3,
		10000
	},
	{
		373001,
		1,
		4,
		10000
	},
	{
		373001,
		1,
		5,
		10000
	},
	{
		373001,
		1,
		6,
		10000
	},
	{
		373001,
		2,
		7,
		10000
	},
	{
		373001,
		2,
		8,
		10000
	},
	{
		373001,
		2,
		9,
		10000
	},
	{
		373001,
		2,
		10,
		10000
	},
	{
		373001,
		2,
		11,
		10000
	},
	{
		373001,
		2,
		12,
		10000
	},
	{
		373001,
		3,
		13,
		10000
	},
	{
		373001,
		3,
		14,
		10000
	},
	{
		373001,
		3,
		15,
		10000
	},
	{
		373001,
		3,
		16,
		10000
	}
}
local t_rich_man_x_plan_recruit_event_item = {
	[373001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			[7] = dataList[7],
			[8] = dataList[8],
			[9] = dataList[9],
			[10] = dataList[10],
			[11] = dataList[11],
			[12] = dataList[12]
		},
		{
			[13] = dataList[13],
			[14] = dataList[14],
			[15] = dataList[15],
			[16] = dataList[16]
		}
	}
}

t_rich_man_x_plan_recruit_event_item.dataList = dataList

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

return t_rich_man_x_plan_recruit_event_item
