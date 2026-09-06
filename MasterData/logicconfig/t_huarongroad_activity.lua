-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_huarongroad_activity.lua

module("logicconfig.config.t_huarongroad_activity", package.seeall)

local title = {
	isCanAddTime = 10,
	redPointId = 6,
	challengePlanId = 4,
	jumpTo = 8,
	isNeedPass = 9,
	bNeedGuide = 5,
	timePlanId = 3,
	switchTo = 7,
	activityId = 1,
	challengeDailyTimes = 2
}
local dataList = {
	{
		171001,
		9999,
		1,
		1,
		true,
		305,
		"",
		"ui#publicdragontabview#2#2",
		true,
		true
	},
	{
		171002,
		9999,
		1,
		2,
		false,
		353,
		"",
		"ui#publicdragontabview#2#2",
		true,
		true
	},
	{
		171003,
		9999,
		0,
		3,
		false,
		353,
		"",
		"ui#publicdragontabview#2#2",
		false,
		false
	},
	{
		171004,
		5,
		2,
		4,
		false,
		353,
		"func#427",
		"ui#publicdragontabview#2#2",
		true,
		true
	},
	{
		171005,
		5,
		2,
		5,
		false,
		353,
		"",
		"ui#publicdragontabview#2#2",
		true,
		true
	},
	{
		171006,
		3,
		2,
		6,
		false,
		353,
		"",
		"ui#publicdragontabview#2#2",
		true,
		true
	}
}
local t_huarongroad_activity = {
	[171001] = dataList[1],
	[171002] = dataList[2],
	[171003] = dataList[3],
	[171004] = dataList[4],
	[171005] = dataList[5],
	[171006] = dataList[6]
}

t_huarongroad_activity.dataList = dataList

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

return t_huarongroad_activity
