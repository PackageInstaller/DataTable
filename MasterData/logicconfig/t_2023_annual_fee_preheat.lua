-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_2023_annual_fee_preheat.lua

module("logicconfig.config.t_2023_annual_fee_preheat", package.seeall)

local title = {
	dailyTimes = 4,
	progressPlanId = 3,
	activityId = 1,
	designPlanId = 2
}
local dataList = {
	{
		233001,
		1,
		1,
		1
	},
	{
		233002,
		2,
		2,
		1
	}
}
local t_2023_annual_fee_preheat = {
	[233001] = dataList[1],
	[233002] = dataList[2]
}

t_2023_annual_fee_preheat.dataList = dataList

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

return t_2023_annual_fee_preheat
