-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_control_clg_stage.lua

module("logicconfig.config.t_fan_rui_control_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterIds = 3,
	passStagePrize = 4,
	title = 5,
	activityId = 1
}
local dataList = {
	{
		293001,
		1,
		{
			311,
			312,
			313
		},
		"4:378:20",
		"掌控万物"
	},
	{
		293001,
		2,
		{
			321,
			322,
			323
		},
		"4:378:20",
		"掌控万物"
	},
	{
		293001,
		3,
		{
			331,
			332,
			333
		},
		"4:378:20",
		"掌控万物"
	},
	{
		293002,
		1,
		{
			611,
			612,
			613
		},
		"4:397:15",
		"智脉觉醒"
	},
	{
		293002,
		2,
		{
			621,
			622,
			623
		},
		"4:397:15",
		"智脉觉醒"
	},
	{
		293002,
		3,
		{
			631,
			632,
			633
		},
		"4:397:20",
		"智脉觉醒"
	},
	{
		293003,
		1,
		{
			3001,
			3002,
			3003
		},
		"4:510781:15",
		"花影流年"
	},
	{
		293003,
		2,
		{
			3004,
			3005,
			3006
		},
		"4:510781:15",
		"花影流年"
	},
	{
		293003,
		3,
		{
			3007,
			3008,
			3009
		},
		"4:510781:20",
		"花影流年"
	}
}
local t_fan_rui_control_clg_stage = {
	[293001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[293002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[293003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_fan_rui_control_clg_stage.dataList = dataList

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

return t_fan_rui_control_clg_stage
