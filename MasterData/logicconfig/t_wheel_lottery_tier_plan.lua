-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wheel_lottery_tier_plan.lua

module("logicconfig.config.t_wheel_lottery_tier_plan", package.seeall)

local title = {
	tierPlanId = 1,
	lotteryCost = 4,
	tier = 2,
	prizePlanId = 3
}
local dataList = {
	{
		1,
		1,
		1001,
		"10:409001:35"
	},
	{
		1,
		2,
		1002,
		"10:409001:35"
	},
	{
		1,
		3,
		1003,
		"10:409001:35"
	},
	{
		2,
		1,
		2001,
		"10:409001:30"
	},
	{
		2,
		2,
		2002,
		"10:409001:30"
	},
	{
		2,
		3,
		2003,
		"10:409001:30"
	},
	{
		3,
		1,
		3001,
		"10:409001:20"
	},
	{
		3,
		2,
		3001,
		"10:409001:20"
	},
	{
		3,
		3,
		3002,
		"10:409001:10"
	}
}
local t_wheel_lottery_tier_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_wheel_lottery_tier_plan.dataList = dataList

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

return t_wheel_lottery_tier_plan
