-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_goal.lua

module("logicconfig.config.t_anchor_simulator_goal", package.seeall)

local title = {
	guestLimit = 4,
	goalValues = 5,
	incHeatValues = 6,
	bulletPlanId = 3,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		446001,
		1,
		1,
		1,
		{
			10,
			10,
			10
		},
		{
			20,
			20,
			20
		}
	},
	{
		446001,
		2,
		1,
		2,
		{
			20,
			20,
			20
		},
		{
			40,
			40,
			40
		}
	},
	{
		446001,
		3,
		1,
		3,
		{
			35,
			35,
			35
		},
		{
			80,
			80,
			80
		}
	}
}
local t_anchor_simulator_goal = {
	[446001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_anchor_simulator_goal.dataList = dataList

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

return t_anchor_simulator_goal
