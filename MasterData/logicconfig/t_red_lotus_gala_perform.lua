-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_lotus_gala_perform.lua

module("logicconfig.config.t_red_lotus_gala_perform", package.seeall)

local title = {
	stageId = 12,
	name = 3,
	freeNum = 9,
	buyPlanId = 10,
	handler = 11,
	gameId = 2,
	performPlanId = 1,
	stagePlanId = 7,
	endTime = 5,
	gamePrize = 6,
	gamePrizePlan = 8,
	startTime = 4
}
local dataList = {
	{
		1,
		1,
		"盛宴开启",
		"2023-04-28T05:00:00",
		"2023-05-01T05:00:00",
		"",
		1,
		0,
		5,
		0,
		"oneStrokeDrawing",
		0
	},
	{
		1,
		2,
		"筹备宴会",
		"2023-05-01T05:00:00",
		"2023-05-05T05:00:00",
		"8:1:10000",
		0,
		1,
		3,
		0,
		"threeMatches",
		1
	},
	{
		1,
		3,
		"盛宴开启",
		"2023-05-05T05:00:00",
		"2023-05-08T05:00:00",
		"",
		2,
		0,
		5,
		0,
		"oneStrokeDrawing",
		0
	},
	{
		1,
		4,
		"筹备宴会",
		"2023-05-08T05:00:00",
		"2023-05-12T05:00:00",
		"8:1:10000",
		0,
		1,
		3,
		0,
		"threeMatches",
		2
	},
	{
		1,
		5,
		"盛宴开启",
		"2023-05-12T05:00:00",
		"2023-05-15T05:00:00",
		"",
		3,
		0,
		5,
		0,
		"oneStrokeDrawing",
		0
	},
	{
		1,
		6,
		"筹备宴会",
		"2023-05-15T05:00:00",
		"2023-05-19T05:00:00",
		"8:1:10000",
		0,
		1,
		3,
		0,
		"threeMatches",
		3
	},
	{
		1,
		7,
		"盛宴开启",
		"2023-05-19T05:00:00",
		"2023-05-22T05:00:00",
		"",
		4,
		0,
		5,
		0,
		"oneStrokeDrawing",
		0
	},
	{
		1,
		8,
		"筹备宴会",
		"2023-05-22T05:00:00",
		"2023-05-26T05:00:00",
		"8:1:10000",
		0,
		1,
		3,
		0,
		"threeMatches",
		4
	},
	{
		1,
		9,
		"盛宴开启",
		"2023-05-26T05:00:00",
		"2023-05-29T05:00:00",
		"",
		5,
		0,
		5,
		0,
		"oneStrokeDrawing",
		0
	},
	{
		1,
		10,
		"筹备宴会",
		"2023-05-29T05:00:00",
		"2023-06-02T05:00:00",
		"8:1:10000",
		0,
		1,
		3,
		0,
		"threeMatches",
		5
	}
}
local t_red_lotus_gala_perform = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_red_lotus_gala_perform.dataList = dataList

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

return t_red_lotus_gala_perform
