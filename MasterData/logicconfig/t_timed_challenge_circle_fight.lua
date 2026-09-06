-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_circle_fight.lua

module("logicconfig.config.t_timed_challenge_circle_fight", package.seeall)

local title = {
	challengeId = 1,
	name = 2,
	progressFloorUnit = 10,
	petRankPrize = 7,
	petRankThreshold = 6,
	detailViewName = 11,
	buffPlanId = 3,
	params = 12,
	dailyTimes = 4,
	maxProgress = 9,
	progressBase = 8,
	progressFactor = 5
}
local dataList = {
	{
		1,
		"阿瑞斯挑战",
		15,
		3,
		67,
		1000,
		"2:27:1",
		2000000,
		999999999,
		100000,
		"aruisidetailview"
	},
	{
		3,
		"龙皇挑战",
		-1,
		3,
		67,
		9999,
		"14:5:1",
		2000000,
		999999999,
		100000,
		"longhuangdetailview"
	},
	{
		5,
		"阿米尔挑战",
		16,
		3,
		50,
		9999,
		"14:11:1",
		1500000,
		999999999,
		100000,
		"amierdetailview"
	},
	{
		12,
		"明镜挑战",
		17,
		3,
		35,
		9999,
		"14:20:1",
		1000000,
		999999999,
		100000,
		"mingjingdetailview"
	},
	{
		14,
		"尤烈挑战",
		18,
		3,
		35,
		9999,
		"14:25:1",
		1000000,
		999999999,
		100000,
		"youliedetailview"
	},
	{
		22,
		"诺雅挑战",
		22,
		3,
		35,
		9999,
		"14:43:1",
		1000000,
		999999999,
		100000,
		"nuoyadetailview"
	},
	{
		147,
		"冥皇挑战",
		55,
		3,
		67,
		1000,
		"2:27:1",
		2000000,
		999999999,
		100000,
		"minghuangdetailview",
		{
			jumpToGift = "mibao#liandongtehui4",
			jumpToRank = "func#618#15023",
			jumpToExchangeStore = "func#191#340#340001",
			jumpToLottery = "func#1010"
		}
	}
}
local t_timed_challenge_circle_fight = {
	dataList[1],
	[3] = dataList[2],
	[5] = dataList[3],
	[12] = dataList[4],
	[14] = dataList[5],
	[22] = dataList[6],
	[147] = dataList[7]
}

t_timed_challenge_circle_fight.dataList = dataList

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

return t_timed_challenge_circle_fight
