-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fee_preheat.lua

module("logicconfig.config.t_annual_fee_preheat", package.seeall)

local title = {
	dailyLimit = 4,
	informationPlanId = 3,
	totalLimit = 5,
	prizePlanId = 2,
	activityId = 1
}
local dataList = {
	{
		97001,
		1,
		1,
		4,
		28
	}
}
local t_annual_fee_preheat = {
	[97001] = dataList[1]
}

t_annual_fee_preheat.dataList = dataList

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

return t_annual_fee_preheat
