-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_recruit_event.lua

module("logicconfig.config.t_rich_man_x_plan_recruit_event", package.seeall)

local title = {
	activityId = 1,
	eventId = 2
}
local dataList = {
	{
		373001,
		1
	},
	{
		373001,
		2
	},
	{
		373001,
		3
	}
}
local t_rich_man_x_plan_recruit_event = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_recruit_event.dataList = dataList

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

return t_rich_man_x_plan_recruit_event
