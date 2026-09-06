-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_activity.lua

module("logicconfig.config.t_free_scuffle_activity", package.seeall)

local title = {
	jumpShop = 15,
	lotteryCost = 3,
	winScore = 7,
	redPointId = 12,
	ruleKeyMain = 13,
	costCoinItem = 11,
	imgRuleKeyMain = 14,
	packageNum = 6,
	oneGameMaxCoin = 4,
	loseScore = 8,
	maxHangingTimeSec = 2,
	robotBattleTimes = 10,
	packageEffectTime = 5,
	activityId = 1,
	dailyTimesLimit = 9
}
local dataList = {
	{
		489001,
		86400,
		"10:489002:1",
		"200000",
		600,
		{
			2,
			4
		},
		30,
		-10,
		10,
		3,
		"1004:1493",
		713,
		"lingnengluandou_rule",
		"freescuffle",
		"func#191#489#489001"
	},
	{
		489002,
		86400,
		"10:489004:1",
		"200000",
		600,
		{
			2,
			4
		},
		30,
		-10,
		10,
		3,
		"1004:1493",
		713,
		"lingnengluandou_rule",
		"freescuffle",
		"func#191#489#489002"
	},
	{
		489003,
		86400,
		"10:489006:1",
		"200000",
		600,
		{
			2,
			4
		},
		30,
		-10,
		10,
		3,
		"1004:1493",
		713,
		"lingnengluandou_rule",
		"freescuffle",
		"func#191#489#489003"
	}
}
local t_free_scuffle_activity = {
	[489001] = dataList[1],
	[489002] = dataList[2],
	[489003] = dataList[3]
}

t_free_scuffle_activity.dataList = dataList

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

return t_free_scuffle_activity
