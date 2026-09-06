-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_daily_recharge_plan.lua

module("logicconfig.config.t_activity_daily_recharge_plan", package.seeall)

local title = {
	activity = 1,
	time = 2,
	prizePlanId = 3
}
local dataList = {
	{
		44001,
		"2021-06-17T05:00:00",
		1
	},
	{
		44001,
		"2021-06-18T05:00:00",
		1
	},
	{
		44001,
		"2021-06-19T05:00:00",
		1
	},
	{
		44001,
		"2021-06-20T05:00:00",
		1
	},
	{
		44001,
		"2021-06-24T05:00:00",
		2
	}
}
local t_activity_daily_recharge_plan = {
	[44001] = {
		["2021-06-17T05:00:00"] = dataList[1],
		["2021-06-18T05:00:00"] = dataList[2],
		["2021-06-19T05:00:00"] = dataList[3],
		["2021-06-20T05:00:00"] = dataList[4],
		["2021-06-24T05:00:00"] = dataList[5]
	}
}

t_activity_daily_recharge_plan.dataList = dataList

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

return t_activity_daily_recharge_plan
