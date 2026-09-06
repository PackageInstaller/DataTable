-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_growth_rate_plan.lua

module("logicconfig.config.t_kindergarten_growth_rate_plan", package.seeall)

local title = {
	growRateRange = 3,
	growthRateId = 2,
	growthRatePlanId = 1
}
local dataList = {
	{
		1,
		1,
		{
			1,
			15
		}
	},
	{
		2,
		1,
		{
			10,
			30
		}
	}
}
local t_kindergarten_growth_rate_plan = {
	{
		dataList[1]
	},
	{
		dataList[2]
	}
}

t_kindergarten_growth_rate_plan.dataList = dataList

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

return t_kindergarten_growth_rate_plan
