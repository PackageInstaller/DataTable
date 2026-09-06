-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_activity.lua

module("logicconfig.config.t_ji_activity", package.seeall)

local title = {
	tetsShow = 9,
	timeShow = 3,
	skinId = 8,
	poolActyId = 7,
	shopId = 4,
	redPointId = 2,
	plotPrizeActyId = 6,
	skinGoto = 5,
	activityId = 1
}
local dataList = {
	{
		144001,
		-206,
		"活动时间：4月15日-5月06日",
		50021,
		"ui#preferentialview#3&&report_behavior#200919",
		142003,
		112006,
		16009,
		"2022-04-15 05:00:00#2022-05-06 05:00:00"
	},
	{
		144002,
		-206,
		"活动时间：04月07日-04月28日",
		50021,
		"func#545#28",
		142003,
		112006,
		16009,
		"2023-04-07 05:00:00#2023-04-28 05:00:00"
	},
	{
		144003,
		-206,
		"活动时间：04月07日-04月28日",
		50021,
		"func#545#28",
		142003,
		112006,
		16009,
		"2023-04-07 05:00:00#2023-04-28 05:00:00"
	},
	{
		144004,
		-206,
		"活动时间：04月03日-04月26日",
		50021,
		"func#545#28",
		142003,
		112006,
		16009,
		"2024-04-03 05:00:00#2024-04-26 05:00:00"
	}
}
local t_ji_activity = {
	[144001] = dataList[1],
	[144002] = dataList[2],
	[144003] = dataList[3],
	[144004] = dataList[4]
}

t_ji_activity.dataList = dataList

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

return t_ji_activity
