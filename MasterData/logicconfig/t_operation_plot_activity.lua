-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_plot_activity.lua

module("logicconfig.config.t_operation_plot_activity", package.seeall)

local title = {
	plotId = 2,
	leftDayTip = 4,
	trialId = 3,
	sccParams = 6,
	activityId = 1,
	energy = 5
}
local dataList = {
	{
		12001,
		1,
		1,
		"2021-06-15 05:00:00",
		"66:1",
		""
	},
	{
		12002,
		2,
		1,
		"2021-06-15 05:00:00",
		"66:1",
		""
	},
	{
		12003,
		3,
		1,
		"2021-06-15 05:00:00",
		"66:1",
		""
	},
	{
		12004,
		4,
		2,
		"2021-07-20 05:00:00",
		"66:1",
		""
	},
	{
		12005,
		5,
		-1,
		"2021-06-15 05:00:00",
		"",
		""
	},
	{
		12006,
		6,
		0,
		"",
		"",
		""
	},
	{
		12007,
		7,
		0,
		"",
		"",
		""
	},
	{
		12008,
		8,
		3,
		"",
		"66:3",
		"nianfeicopyview:38:44"
	},
	{
		12009,
		9,
		0,
		"",
		"",
		""
	},
	{
		12010,
		10,
		0,
		"",
		"",
		""
	}
}
local t_operation_plot_activity = {
	[12001] = dataList[1],
	[12002] = dataList[2],
	[12003] = dataList[3],
	[12004] = dataList[4],
	[12005] = dataList[5],
	[12006] = dataList[6],
	[12007] = dataList[7],
	[12008] = dataList[8],
	[12009] = dataList[9],
	[12010] = dataList[10]
}

t_operation_plot_activity.dataList = dataList

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

return t_operation_plot_activity
