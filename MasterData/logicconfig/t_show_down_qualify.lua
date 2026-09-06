-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_qualify.lua

module("logicconfig.config.t_show_down_qualify", package.seeall)

local title = {
	maxMatchingTimeSec = 8,
	winRankScore = 9,
	prizePlanId = 7,
	type = 2,
	endMatchMinuteEarly = 5,
	matchPlanId = 6,
	loseRankScore = 10,
	desc = 3,
	winMatchScore = 11,
	loseMatchScore = 12,
	matchTimePeriodStr = 4,
	activityId = 1
}
local dataList = {
	{
		360001,
		1,
		"预选赛",
		"09:00:00#23:00:00",
		10,
		1,
		1,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360001,
		2,
		"娱乐模式",
		"09:00:00#23:00:00",
		10,
		1,
		0,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360002,
		1,
		"预选赛",
		"09:00:00#23:00:00",
		10,
		1,
		1,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360002,
		2,
		"娱乐模式",
		"09:00:00#23:00:00",
		10,
		2,
		0,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360003,
		1,
		"预选赛",
		"09:00:00#23:00:00",
		10,
		1,
		1,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360003,
		2,
		"娱乐模式",
		"09:00:00#23:00:00",
		10,
		2,
		0,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360004,
		1,
		"预选赛",
		"09:00:00#23:00:00",
		10,
		1,
		1,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360004,
		2,
		"娱乐模式",
		"09:00:00#23:00:00",
		10,
		2,
		0,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360005,
		1,
		"预选赛",
		"09:00:00#23:00:00",
		10,
		1,
		1,
		20,
		20,
		0,
		20,
		-20
	},
	{
		360005,
		2,
		"娱乐模式",
		"09:00:00#23:00:00",
		10,
		2,
		0,
		20,
		20,
		0,
		20,
		-20
	}
}
local t_show_down_qualify = {
	[360001] = {
		dataList[1],
		dataList[2]
	},
	[360002] = {
		dataList[3],
		dataList[4]
	},
	[360003] = {
		dataList[5],
		dataList[6]
	},
	[360004] = {
		dataList[7],
		dataList[8]
	},
	[360005] = {
		dataList[9],
		dataList[10]
	}
}

t_show_down_qualify.dataList = dataList

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

return t_show_down_qualify
