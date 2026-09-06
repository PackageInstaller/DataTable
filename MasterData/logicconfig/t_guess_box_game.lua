-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_box_game.lua

module("logicconfig.config.t_guess_box_game", package.seeall)

local title = {
	allCorrectExtPrize = 11,
	levelPlanId = 13,
	flowerPlanId = 3,
	weekPlayTimes = 8,
	boxPlanId = 2,
	scorePrizePlanId = 4,
	canGuessTimes = 9,
	redPointId = 5,
	correctFlowerId = 10,
	rulePlanId = 6,
	firstStoryId = 14,
	prizeShowList = 12,
	activityId = 1,
	dailyPlayTimes = 7
}
local dataList = {
	{
		138001,
		1,
		1,
		0,
		228,
		1,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		0,
		0
	},
	{
		138002,
		2,
		2,
		1,
		228,
		2,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		1,
		0
	},
	{
		138003,
		2,
		2,
		2,
		228,
		3,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		1,
		0
	},
	{
		138004,
		2,
		2,
		3,
		228,
		2,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		1,
		0
	},
	{
		138005,
		2,
		2,
		4,
		228,
		4,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		1,
		4600003
	},
	{
		138006,
		3,
		4,
		0,
		228,
		5,
		3,
		9999,
		2,
		2,
		"",
		"",
		2,
		0
	},
	{
		138007,
		2,
		5,
		0,
		228,
		6,
		3,
		9999,
		0,
		0,
		"",
		"",
		3,
		0
	},
	{
		138008,
		2,
		2,
		5,
		228,
		6,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		1,
		0
	},
	{
		138009,
		2,
		2,
		6,
		228,
		2,
		3,
		9999,
		2,
		2,
		"10:137101:1",
		"10:137001:1#10:137101:1",
		1,
		0
	}
}
local t_guess_box_game = {
	[138001] = dataList[1],
	[138002] = dataList[2],
	[138003] = dataList[3],
	[138004] = dataList[4],
	[138005] = dataList[5],
	[138006] = dataList[6],
	[138007] = dataList[7],
	[138008] = dataList[8],
	[138009] = dataList[9]
}

t_guess_box_game.dataList = dataList

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

return t_guess_box_game
