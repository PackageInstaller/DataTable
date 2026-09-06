-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_normal_clg_plan.lua

module("logicconfig.config.t_divine_tian_shan_clg_normal_clg_plan", package.seeall)

local title = {
	stagePlanId = 4,
	prizePlanId = 3,
	endTime = 5,
	dailyFightTimesLimit = 2,
	normalClgPlanId = 1
}
local dataList = {
	{
		1,
		5,
		1,
		1,
		"2025-06-27T05:00:00"
	}
}
local t_divine_tian_shan_clg_normal_clg_plan = {
	dataList[1]
}

t_divine_tian_shan_clg_normal_clg_plan.dataList = dataList

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

return t_divine_tian_shan_clg_normal_clg_plan
