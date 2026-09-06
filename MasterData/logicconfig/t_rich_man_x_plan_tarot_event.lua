-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_tarot_event.lua

module("logicconfig.config.t_rich_man_x_plan_tarot_event", package.seeall)

local title = {
	eventId = 2,
	tarotNum = 3,
	prize = 5,
	gridNum = 6,
	boomNum = 4,
	activityId = 1
}
local dataList = {
	{
		373001,
		1,
		3,
		1,
		10000,
		10
	},
	{
		373001,
		2,
		3,
		2,
		25000,
		10
	},
	{
		373001,
		3,
		3,
		3,
		50000,
		10
	}
}
local t_rich_man_x_plan_tarot_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_tarot_event.dataList = dataList

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

return t_rich_man_x_plan_tarot_event
