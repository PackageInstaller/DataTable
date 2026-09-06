-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_price_break_discount_activity.lua

module("logicconfig.config.t_price_break_discount_activity", package.seeall)

local title = {
	discPlan = 3,
	startTime = 6,
	itemPlan = 2,
	endTime = 7,
	costKey = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		219001,
		1,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule"
	},
	{
		219002,
		2,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule"
	},
	{
		219003,
		3,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule"
	},
	{
		219004,
		4,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule"
	},
	{
		219005,
		5,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule"
	},
	{
		219006,
		6,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule"
	},
	{
		219008,
		7,
		1,
		"204:1000001",
		"xiunuotiaozhanview_rule",
		"2025-02-28T05:00:00",
		"2025-04-03T05:00:00"
	}
}
local t_price_break_discount_activity = {
	[219001] = dataList[1],
	[219002] = dataList[2],
	[219003] = dataList[3],
	[219004] = dataList[4],
	[219005] = dataList[5],
	[219006] = dataList[6],
	[219008] = dataList[7]
}

t_price_break_discount_activity.dataList = dataList

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

return t_price_break_discount_activity
