-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_step.lua

module("logicconfig.config.t_young_champion_king_step", package.seeall)

local title = {
	canGuss = 5,
	haveKnockoutBattle = 6,
	roundId = 3,
	stepId = 2,
	activityId = 1,
	startTime = 4
}
local dataList = {
	{
		391001,
		1,
		1,
		"2024-07-26T05:00:00",
		false,
		false
	},
	{
		391001,
		2,
		2,
		"2024-08-02T05:00:00",
		false,
		false
	},
	{
		391001,
		3,
		3,
		"2024-08-09T05:00:00",
		true,
		false
	},
	{
		391001,
		4,
		3,
		"2024-08-09T19:00:00",
		false,
		true
	},
	{
		391001,
		5,
		4,
		"2024-08-09T19:30:00",
		true,
		false
	},
	{
		391001,
		6,
		4,
		"2024-08-10T19:00:00",
		false,
		true
	},
	{
		391001,
		7,
		5,
		"2024-08-10T19:30:00",
		true,
		false
	},
	{
		391001,
		8,
		5,
		"2024-08-11T19:00:00",
		false,
		true
	},
	{
		391001,
		9,
		6,
		"2024-08-11T19:30:00",
		true,
		false
	},
	{
		391001,
		10,
		6,
		"2024-08-16T19:00:00",
		false,
		true
	},
	{
		391001,
		11,
		7,
		"2024-08-16T19:30:00",
		true,
		false
	},
	{
		391001,
		12,
		7,
		"2024-08-17T19:00:00",
		false,
		true
	},
	{
		391001,
		13,
		8,
		"2024-08-17T19:30:00",
		true,
		false
	},
	{
		391001,
		14,
		8,
		"2024-08-17T20:00:00",
		false,
		true
	},
	{
		391001,
		15,
		9,
		"2024-08-17T20:30:00",
		true,
		false
	},
	{
		391001,
		16,
		9,
		"2024-08-18T19:00:00",
		false,
		true
	},
	{
		391001,
		17,
		9,
		"2024-08-18T19:20:00",
		false,
		true
	},
	{
		391001,
		18,
		9,
		"2024-08-18T19:40:00",
		false,
		true
	},
	{
		391001,
		19,
		10,
		"2024-08-18T20:00:00",
		true,
		false
	},
	{
		391001,
		20,
		10,
		"2024-08-18T20:20:00",
		false,
		true
	},
	{
		391001,
		21,
		10,
		"2024-08-18T20:40:00",
		false,
		true
	},
	{
		391001,
		22,
		10,
		"2024-08-18T21:00:00",
		false,
		true
	},
	{
		391001,
		23,
		11,
		"2024-08-18T21:20:00",
		false,
		false
	}
}
local t_young_champion_king_step = {
	[391001] = {
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
		dataList[23]
	}
}

t_young_champion_king_step.dataList = dataList

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

return t_young_champion_king_step
