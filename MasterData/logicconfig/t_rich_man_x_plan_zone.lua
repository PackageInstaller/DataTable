-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_zone.lua

module("logicconfig.config.t_rich_man_x_plan_zone", package.seeall)

local title = {
	activityId = 1,
	name = 4,
	zoneId = 2,
	openDateTime = 3
}
local dataList = {
	{
		373001,
		1,
		"2024-05-31T05:00:00",
		"精灵大陆"
	},
	{
		373001,
		2,
		"2024-06-07T05:00:00",
		"神裁协盟"
	},
	{
		373001,
		3,
		"2024-06-14T05:00:00",
		"神域"
	}
}
local t_rich_man_x_plan_zone = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_zone.dataList = dataList

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

return t_rich_man_x_plan_zone
