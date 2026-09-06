-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_game_activity.lua

module("logicconfig.config.t_guess_game_activity", package.seeall)

local title = {
	firstScore = 13,
	bgImage = 19,
	perQuestionSec = 8,
	personPrizePlanId = 2,
	viewTip = 10,
	activityName = 20,
	playerCount = 6,
	globalPrizePlanId = 3,
	activityTipsKey = 21,
	mainImage = 16,
	mainImagePose = 17,
	activityId = 1,
	score = 14,
	range = 15,
	viewTipPos = 11,
	tipsPlan = 4,
	num = 7,
	gameImagePose = 18,
	tipTime = 12,
	gameTimeSec = 5,
	maxMatchingSec = 9
}
local dataList = {
	{
		139001,
		1,
		1,
		"1",
		3,
		3,
		5,
		25,
		120,
		"还曾记得我们一起并肩作战的日子么？",
		{
			190,
			220
		},
		30,
		10,
		7,
		"",
		"16008_miruike",
		{
			0,
			0,
			1
		},
		{
			0,
			0,
			1
		},
		"bg_ktcjl_02",
		"看图猜精灵",
		"tips_huiyichanglang"
	},
	{
		139002,
		2,
		0,
		"1",
		3,
		3,
		5,
		25,
		120,
		"铁甲巨龙所带来的焰火，将把黑夜点亮。",
		{
			190,
			220
		},
		30,
		10,
		7,
		"",
		"17002_longzunshengzhu01",
		{
			0,
			0,
			1
		},
		{
			0,
			0,
			1
		},
		"bg_ktcjl_lzsz_01",
		"看图猜精灵",
		"tips_huiyichanglang"
	}
}
local t_guess_game_activity = {
	[139001] = dataList[1],
	[139002] = dataList[2]
}

t_guess_game_activity.dataList = dataList

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

return t_guess_game_activity
