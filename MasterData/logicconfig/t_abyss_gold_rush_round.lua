-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_round.lua

module("logicconfig.config.t_abyss_gold_rush_round", package.seeall)

local title = {
	holyStripeDropTimes = 11,
	samePetGroupCount = 9,
	selectPetCount = 10,
	petBoxPlan = 6,
	activityId = 1,
	petWithBuff = 7,
	failCostCoin = 5,
	onceHolyStripeDropCount = 12,
	coinRange = 14,
	prizeDesc = 15,
	roundId = 2,
	noCoinWanPercent = 13,
	winRunScore = 3,
	prize4WinRun = 4,
	randomPetCount = 8
}
local dataList = {
	{
		612001,
		1,
		10,
		"",
		100,
		1,
		false,
		9,
		5,
		5,
		1,
		1,
		0,
		{
			100,
			200
		},
		"100%获得100-200游园币 1个灵纹"
	},
	{
		612001,
		2,
		30,
		"",
		300,
		2,
		false,
		9,
		5,
		3,
		1,
		1,
		3000,
		{
			400,
			800
		},
		"70%获得400-800游园币 1个灵纹"
	},
	{
		612001,
		3,
		50,
		"10:612001:1000",
		0,
		3,
		true,
		9,
		5,
		3,
		2,
		2,
		4000,
		{
			1000,
			1500
		},
		"60%获得1000-1500游园币 4个灵纹"
	}
}
local t_abyss_gold_rush_round = {
	[612001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_abyss_gold_rush_round.dataList = dataList

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

return t_abyss_gold_rush_round
