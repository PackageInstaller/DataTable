-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buddy_lucky_bag_card.lua

module("logicconfig.config.t_buddy_lucky_bag_card", package.seeall)

local title = {
	cardId = 2,
	itemCount = 4,
	itemType = 3,
	prize = 5,
	name = 6,
	pos = 7,
	activityId = 1
}
local dataList = {
	{
		544001,
		1,
		544001,
		30,
		"100:16000:1:1#4:400002:100#10:544002:1",
		"万顺福",
		{
			-267,
			67
		}
	},
	{
		544001,
		2,
		544001,
		60,
		"100:16002:1:1#4:400002:100",
		"步云福",
		{
			-56,
			-26
		}
	},
	{
		544001,
		3,
		544001,
		90,
		"4:259:100#4:400002:100",
		"鸿禧福",
		{
			159.8,
			66.8
		}
	},
	{
		544001,
		4,
		544001,
		120,
		"4:510260:100#4:400002:100",
		"祥瑞福",
		{
			369.9,
			-25.7
		}
	}
}
local t_buddy_lucky_bag_card = {
	[544001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_buddy_lucky_bag_card.dataList = dataList

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

return t_buddy_lucky_bag_card
