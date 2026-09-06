-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_step.lua

module("logicconfig.config.t_teen_champion_king_step", package.seeall)

local title = {
	canGuss = 5,
	needKnockoutRoom = 6,
	roundId = 3,
	stepId = 2,
	activityId = 1,
	startTime = 4
}
local dataList = {
	{
		501001,
		1,
		1,
		"2025-07-25T05:00:00",
		false,
		false
	},
	{
		501001,
		2,
		2,
		"2025-08-01T05:00:00",
		false,
		false
	},
	{
		501001,
		3,
		3,
		"2025-08-08T05:00:00",
		true,
		false
	},
	{
		501001,
		4,
		3,
		"2025-08-08T19:00:00",
		false,
		true
	},
	{
		501001,
		5,
		4,
		"2025-08-08T19:20:00",
		true,
		false
	},
	{
		501001,
		6,
		4,
		"2025-08-09T19:40:00",
		false,
		true
	},
	{
		501001,
		7,
		5,
		"2025-08-09T20:00:00",
		true,
		false
	},
	{
		501001,
		8,
		5,
		"2025-08-10T19:00:00",
		false,
		true
	},
	{
		501001,
		9,
		6,
		"2025-08-10T19:20:00",
		true,
		false
	},
	{
		501001,
		10,
		6,
		"2025-08-10T19:40:00",
		false,
		true
	},
	{
		501001,
		11,
		7,
		"2025-08-10T20:00:00",
		true,
		false
	},
	{
		501001,
		12,
		7,
		"2025-08-15T19:00:00",
		true,
		true
	},
	{
		501001,
		13,
		8,
		"2025-08-15T19:20:00",
		true,
		false
	},
	{
		501001,
		14,
		8,
		"2025-08-15T19:40:00",
		true,
		true
	},
	{
		501001,
		15,
		9,
		"2025-08-15T20:00:00",
		true,
		false
	},
	{
		501001,
		16,
		9,
		"2025-08-15T20:20:00",
		true,
		true
	},
	{
		501001,
		17,
		10,
		"2025-08-15T20:40:00",
		true,
		false
	},
	{
		501001,
		18,
		10,
		"2025-08-16T19:00:00",
		true,
		true
	},
	{
		501001,
		19,
		11,
		"2025-08-16T19:20:00",
		false,
		false
	},
	{
		501001,
		20,
		11,
		"2025-08-16T19:40:00",
		false,
		true
	},
	{
		501001,
		21,
		12,
		"2025-08-16T20:00:00",
		false,
		false
	},
	{
		501001,
		22,
		12,
		"2025-08-16T20:20:00",
		false,
		true
	},
	{
		501001,
		23,
		13,
		"2025-08-16T20:40:00",
		false,
		false
	},
	{
		501001,
		24,
		13,
		"2025-08-16T21:00:00",
		false,
		true
	},
	{
		501001,
		25,
		14,
		"2025-08-16T21:20:00",
		false,
		false
	}
}
local t_teen_champion_king_step = {
	[501001] = {
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
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_teen_champion_king_step.dataList = dataList

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

return t_teen_champion_king_step
