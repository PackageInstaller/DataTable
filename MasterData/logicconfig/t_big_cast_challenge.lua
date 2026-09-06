-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_cast_challenge.lua

module("logicconfig.config.t_big_cast_challenge", package.seeall)

local title = {
	fightTimes = 7,
	lotteryCost = 11,
	res = 12,
	down = 17,
	petId = 13,
	title = 3,
	buffPlan = 4,
	lotteryPlan = 9,
	roundNum = 6,
	activityId = 1,
	petScale = 15,
	failWhenLoseTimes = 8,
	petPos = 14,
	lotterTitle = 16,
	winStreakPrizePlan = 5,
	winGainLotteryScore = 10,
	petPlan = 2
}
local dataList = {
	{
		98001,
		1,
		"第 一 期",
		1,
		1,
		8,
		2,
		4,
		1,
		1,
		4,
		"icon_choujiang",
		12005,
		{
			0,
			0
		},
		{
			1,
			1
		},
		"有标题",
		"保底第<color=#C54949>3、9、20</color>抽必中大奖"
	},
	{
		98002,
		2,
		"第 二 期",
		1,
		1,
		8,
		2,
		4,
		1,
		1,
		4,
		"icon_choujiang",
		12005,
		{
			0,
			0
		},
		{
			1,
			1
		},
		"",
		"保底第<color=#C54949>9</color>抽必中大奖"
	},
	{
		98003,
		1,
		"第 一 期",
		1,
		2,
		6,
		2,
		3,
		1,
		1,
		3,
		"icon_choujiang",
		12005,
		{
			0,
			0
		},
		{
			1,
			1
		},
		"有标题",
		"保底第<color=#C54949>3、9、20</color>抽必中大奖"
	},
	{
		98004,
		2,
		"第 二 期",
		1,
		2,
		6,
		2,
		3,
		2,
		1,
		3,
		"icon_choujiang",
		12005,
		{
			0,
			0
		},
		{
			1,
			1
		},
		"",
		"保底第<color=#C54949>9</color>抽必中大奖"
	}
}
local t_big_cast_challenge = {
	[98001] = dataList[1],
	[98002] = dataList[2],
	[98003] = dataList[3],
	[98004] = dataList[4]
}

t_big_cast_challenge.dataList = dataList

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

return t_big_cast_challenge
