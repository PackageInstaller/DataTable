-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buddy_lucky_bag_bag.lua

module("logicconfig.config.t_buddy_lucky_bag_bag", package.seeall)

local title = {
	pos = 5,
	name = 4,
	bagId = 2,
	activityId = 1,
	poolId = 3
}
local dataList = {
	{
		544001,
		1,
		1,
		"精灵福袋",
		{
			-310.6,
			53.8
		}
	},
	{
		544001,
		2,
		3,
		"红星/道具福袋",
		{
			-106.7,
			-84.8
		}
	},
	{
		544001,
		3,
		1,
		"精灵福袋",
		{
			97,
			35
		}
	},
	{
		544001,
		4,
		4,
		"道具福袋",
		{
			302.3,
			-85.6
		}
	},
	{
		544001,
		5,
		2,
		"皮肤福袋",
		{
			506,
			53.4
		}
	},
	{
		544002,
		1,
		5,
		"精灵福袋",
		{
			-310.6,
			53.8
		}
	},
	{
		544002,
		2,
		7,
		"红星/道具福袋",
		{
			-106.7,
			-84.8
		}
	},
	{
		544002,
		3,
		5,
		"精灵福袋",
		{
			97,
			35
		}
	},
	{
		544002,
		4,
		8,
		"道具福袋",
		{
			302.3,
			-85.6
		}
	},
	{
		544002,
		5,
		6,
		"皮肤福袋",
		{
			506,
			53.4
		}
	},
	{
		544003,
		1,
		9,
		"精灵福袋",
		{
			-310.6,
			53.8
		}
	},
	{
		544003,
		2,
		11,
		"红星/道具福袋",
		{
			-106.7,
			-84.8
		}
	},
	{
		544003,
		3,
		12,
		"道具福袋",
		{
			97,
			35
		}
	},
	{
		544003,
		4,
		10,
		"皮肤福袋",
		{
			302.3,
			-85.6
		}
	},
	{
		544003,
		5,
		12,
		"道具福袋",
		{
			506,
			53.4
		}
	}
}
local t_buddy_lucky_bag_bag = {
	[544001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[544002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[544003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_buddy_lucky_bag_bag.dataList = dataList

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

return t_buddy_lucky_bag_bag
