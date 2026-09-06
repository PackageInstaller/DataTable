-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_progress_tab.lua

module("logicconfig.config.t_world_progress_tab", package.seeall)

local title = {
	progressId = 2,
	openTime = 3,
	activityId = 1,
	prizePlanId = 4
}
local dataList = {
	{
		443001,
		1,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		2,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		3,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		4,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		5,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		6,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		7,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		8,
		"2025-02-21T05:00:00",
		0
	},
	{
		443001,
		9,
		"2025-02-21T05:00:00",
		0
	},
	{
		532001,
		1,
		"2025-11-07T05:00:00",
		2
	},
	{
		525001,
		1,
		"2025-11-07T05:00:00",
		0
	},
	{
		525001,
		2,
		"2025-11-07T05:00:00",
		0
	},
	{
		525001,
		3,
		"2025-11-07T05:00:00",
		0
	},
	{
		540001,
		1,
		"2026-01-09T05:00:00",
		0
	},
	{
		540002,
		1,
		"2026-05-22T05:00:00",
		0
	},
	{
		595001,
		1,
		"2026-06-05T05:00:00",
		3
	}
}
local t_world_progress_tab = {
	[443001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[532001] = {
		dataList[10]
	},
	[525001] = {
		dataList[11],
		dataList[12],
		dataList[13]
	},
	[540001] = {
		dataList[14]
	},
	[540002] = {
		dataList[15]
	},
	[595001] = {
		dataList[16]
	}
}

t_world_progress_tab.dataList = dataList

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

return t_world_progress_tab
