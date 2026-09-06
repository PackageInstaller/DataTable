-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_shop_discount_time.lua

module("logicconfig.config.t_activity_shop_discount_time", package.seeall)

local title = {
	activityId = 1,
	discountTime = 2
}
local dataList = {
	{
		6001,
		"时段|2021-12-03 00:00:00,2038-01-01 00:00:00"
	},
	{
		108001,
		"时段|2021-01-14 05:00:00,2022-03-04 05:00:00"
	},
	{
		102001,
		"时段|2021-01-14 05:00:00,2022-02-11 05:00:00"
	},
	{
		112002,
		"时段|2021-01-28 05:00:00,2022-02-18 05:00:00"
	},
	{
		112003,
		"时段|2021-02-18 05:00:00,2022-03-03 05:00:00"
	},
	{
		112004,
		"时段|2021-03-04 05:00:00,2022-04-01 05:00:00"
	},
	{
		112005,
		"时段|2021-04-01 05:00:00,2022-04-15 05:00:00"
	},
	{
		144001,
		"时段|2021-04-15 05:00:00,2022-04-22 05:00:00"
	},
	{
		144002,
		"时段|2021-12-09 05:00:00,2022-12-30 05:00:00"
	},
	{
		108002,
		"时段|2022-04-29 05:00:00,2022-06-02 05:00:00"
	},
	{
		112008,
		"时段|2022-06-02 05:00:00,2022-06-17 05:00:00"
	}
}
local t_activity_shop_discount_time = {
	[6001] = dataList[1],
	[108001] = dataList[2],
	[102001] = dataList[3],
	[112002] = dataList[4],
	[112003] = dataList[5],
	[112004] = dataList[6],
	[112005] = dataList[7],
	[144001] = dataList[8],
	[144002] = dataList[9],
	[108002] = dataList[10],
	[112008] = dataList[11]
}

t_activity_shop_discount_time.dataList = dataList

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

return t_activity_shop_discount_time
