-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_activity.lua

module("logicconfig.config.t_aoqi_hero_activity", package.seeall)

local title = {
	cardNum = 5,
	encryptorSwitch = 4,
	pvpDailyTimes = 8,
	jumpTo = 24,
	initCardUnlock = 6,
	pvpDefFormations = 15,
	pvpMatchTimeSec = 17,
	pvpFormationTime = 19,
	killEnergy = 22,
	showBar = 23,
	redPointId = 2,
	endTime = 13,
	pvpLosePrize = 10,
	dailyPrize = 25,
	activityId = 1,
	attackMaxEnergy = 20,
	endlessRoundLimit = 7,
	pvpTieScore = 14,
	pvpWinPrize = 9,
	attackStandEnergy = 21,
	pvpDefCreepsNum = 16,
	pvpTiePrize = 11,
	totalSwitch = 3,
	pvpMaxTimeSec = 18,
	startTime = 12
}
local dataList = {
	{
		450001,
		672,
		true,
		true,
		6,
		3,
		500,
		10,
		"10:450001:50",
		"10:450001:30",
		"10:450001:20",
		"09:00:00",
		"23:00:00",
		10,
		{
			201,
			202,
			203
		},
		9,
		30,
		600,
		30,
		150,
		50,
		0,
		"10:450002#10:450001",
		"func#191#450#450001",
		"10:450002:500"
	}
}
local t_aoqi_hero_activity = {
	[450001] = dataList[1]
}

t_aoqi_hero_activity.dataList = dataList

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

return t_aoqi_hero_activity
