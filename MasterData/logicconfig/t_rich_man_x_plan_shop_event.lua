-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_shop_event.lua

module("logicconfig.config.t_rich_man_x_plan_shop_event", package.seeall)

local title = {
	itemNum = 4,
	refreshCost = 3,
	refreshLimit = 5,
	raceId = 6,
	eventId = 2,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		10000,
		3,
		2,
		1301603
	},
	{
		373001,
		2,
		15000,
		3,
		3,
		1301603
	},
	{
		373001,
		3,
		20000,
		3,
		4,
		1301603
	}
}
local t_rich_man_x_plan_shop_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_shop_event.dataList = dataList

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

return t_rich_man_x_plan_shop_event
