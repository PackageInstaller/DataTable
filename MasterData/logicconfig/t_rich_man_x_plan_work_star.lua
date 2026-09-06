-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_work_star.lua

module("logicconfig.config.t_rich_man_x_plan_work_star", package.seeall)

local title = {
	efficiency = 3,
	activityId = 1,
	starLevel = 2,
	exclusiveEfficiency = 4
}
local dataList = {
	{
		373001,
		1,
		0,
		0.2
	},
	{
		373001,
		2,
		0.3,
		0.6
	},
	{
		373001,
		3,
		0.5,
		1
	}
}
local t_rich_man_x_plan_work_star = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_work_star.dataList = dataList

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

return t_rich_man_x_plan_work_star
