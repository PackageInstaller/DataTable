-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_dark_dragon_main_stage.lua

module("logicconfig.config.t_god_dark_dragon_main_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	creepsMasterId = 3,
	prize = 4,
	startTime = 5
}
local dataList = {
	{
		331001,
		1,
		1001,
		"4:221:3",
		"2024-01-19T05:00:00"
	},
	{
		331001,
		2,
		1002,
		"4:221:4",
		"2024-01-19T05:00:00"
	},
	{
		331001,
		3,
		1003,
		"4:221:5",
		"2024-01-19T05:00:00"
	},
	{
		331001,
		4,
		1004,
		"4:221:6",
		"2024-01-19T05:00:00"
	},
	{
		331001,
		5,
		1005,
		"4:221:8",
		"2024-01-20T05:00:00"
	},
	{
		331001,
		6,
		1006,
		"4:221:9",
		"2024-01-20T05:00:00"
	},
	{
		331001,
		7,
		1007,
		"4:221:10",
		"2024-01-20T05:00:00"
	},
	{
		331001,
		8,
		1008,
		"4:221:11",
		"2024-01-20T05:00:00"
	},
	{
		331001,
		9,
		1009,
		"4:221:14",
		"2024-01-21T05:00:00"
	},
	{
		331001,
		10,
		1010,
		"4:221:14",
		"2024-01-21T05:00:00"
	},
	{
		331001,
		11,
		1011,
		"4:221:16",
		"2024-01-21T05:00:00"
	},
	{
		331001,
		12,
		1012,
		"4:221:20",
		"2024-01-21T05:00:00"
	}
}
local t_god_dark_dragon_main_stage = {
	[331001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_god_dark_dragon_main_stage.dataList = dataList

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

return t_god_dark_dragon_main_stage
