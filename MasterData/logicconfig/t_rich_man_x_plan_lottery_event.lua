-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_lottery_event.lua

module("logicconfig.config.t_rich_man_x_plan_lottery_event", package.seeall)

local title = {
	prizeNum = 4,
	diceTimes = 5,
	numberMax = 3,
	cost = 6,
	prize = 7,
	eventId = 2,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		15,
		5,
		3,
		10000,
		50000
	},
	{
		373001,
		2,
		15,
		5,
		4,
		20000,
		100000
	},
	{
		373001,
		3,
		15,
		5,
		5,
		30000,
		150000
	}
}
local t_rich_man_x_plan_lottery_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_lottery_event.dataList = dataList

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

return t_rich_man_x_plan_lottery_event
