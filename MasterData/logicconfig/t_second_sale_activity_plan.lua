-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_second_sale_activity_plan.lua

module("logicconfig.config.t_second_sale_activity_plan", package.seeall)

local title = {
	secondSaleTimeRange = 3,
	tabName = 4,
	activityId = 1,
	secondSalePlanId = 2
}
local dataList = {
	{
		210001,
		1,
		"09:00:00-10:00:00",
		"9点开"
	},
	{
		210001,
		2,
		"12:00:00-13:00:00",
		"12点开"
	},
	{
		210001,
		3,
		"18:00:00-19:00:00",
		"18点开"
	},
	{
		210002,
		4,
		"09:00:00-10:00:00",
		"9点开"
	},
	{
		210002,
		5,
		"12:00:00-13:00:00",
		"12点开"
	},
	{
		210002,
		6,
		"18:00:00-19:00:00",
		"18点开"
	},
	{
		210003,
		7,
		"09:00:00-10:00:00",
		"9点开"
	},
	{
		210003,
		8,
		"12:00:00-13:00:00",
		"12点开"
	},
	{
		210003,
		9,
		"18:00:00-19:00:00",
		"18点开"
	}
}
local t_second_sale_activity_plan = {
	[210001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[210002] = {
		[4] = dataList[4],
		[5] = dataList[5],
		[6] = dataList[6]
	},
	[210003] = {
		[7] = dataList[7],
		[8] = dataList[8],
		[9] = dataList[9]
	}
}

t_second_sale_activity_plan.dataList = dataList

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

return t_second_sale_activity_plan
