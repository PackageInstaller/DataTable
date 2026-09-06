-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_dragon_activity.lua

module("logicconfig.config.t_eternal_dragon_activity", package.seeall)

local title = {
	cutViewValidator = 11,
	waterScore = 4,
	gamePrize = 10,
	activityId = 1,
	cuttingScore = 14,
	openCuttingLimit = 13,
	maxScore = 2,
	openGameLimit = 6,
	comPlanId = 18,
	redPointId = 17,
	waterPrize = 5,
	gameValidator = 9,
	gameScore = 7,
	cutViewJumpStr = 12,
	gameDailyTimes = 8,
	cuttingPhysicalCost = 15,
	activation = 3,
	cuttingPrize = 16
}
local dataList = {
	{
		295001,
		650,
		30,
		10,
		"8:1:5000",
		20,
		25,
		2,
		{
			score = "500"
		},
		"8:1:10000",
		nil,
		"event#openrecastgloryshieldviewbyed#3:2#4:3#5:4",
		120,
		10,
		"66:9:1",
		"8:1:5000",
		509,
		1
	},
	{
		295002,
		600,
		30,
		10,
		"8:1:5000",
		50,
		25,
		2,
		{
			score = "500"
		},
		"8:1:10000",
		{
			score = "12"
		},
		"event#openflipgamebyed#24006",
		250,
		10,
		"66:10:1",
		"8:1:5000",
		509,
		2
	},
	{
		295003,
		600,
		30,
		10,
		"8:1:5000",
		50,
		25,
		2,
		{
			score = "500"
		},
		"8:1:10000",
		{
			score = "10"
		},
		"ui#guesssnowmangameview#138006#1#295003",
		250,
		10,
		"66:12:1",
		"8:1:5000",
		509,
		3
	},
	{
		295004,
		600,
		30,
		10,
		"8:1:5000",
		50,
		25,
		2,
		{
			score = "500"
		},
		"8:1:10000",
		{
			score = "10"
		},
		"event#openflipgamebyed#24008",
		250,
		10,
		"66:14:1",
		"8:1:5000",
		509,
		4
	}
}
local t_eternal_dragon_activity = {
	[295001] = dataList[1],
	[295002] = dataList[2],
	[295003] = dataList[3],
	[295004] = dataList[4]
}

t_eternal_dragon_activity.dataList = dataList

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

return t_eternal_dragon_activity
