-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_activity.lua

module("logicconfig.config.t_abyss_gold_rush_activity", package.seeall)

local title = {
	jumpShop = 14,
	presetCount = 5,
	failFloorCoin = 11,
	tieAddScore = 9,
	prizeDesc = 18,
	onceGainHolyStripeLimit = 3,
	goldRankTipDesc = 19,
	holyStripeTime = 17,
	showItem = 13,
	formationTime = 16,
	activityId = 1,
	fightWithHolyStripeLimit = 4,
	jumpTask = 15,
	winAddScore = 7,
	scoreRankTipDesc = 20,
	gameWithHolyStripeLimit = 6,
	loseAddScore = 8,
	petLimit = 10,
	dailyPrizeTimes = 2,
	fakeItem = 12
}
local dataList = {
	{
		612001,
		3,
		5,
		5,
		3,
		15,
		10,
		0,
		5,
		16,
		100,
		"1004:1655",
		"1004:1655#10:612001",
		"func#191#612#612001",
		"ui#commongrouptaskmainview#612001",
		20,
		20,
		"第一层: 100%获得100-200游园币，1个灵纹\r\n第二层: 70%获得400-800游园币，1个灵纹\r\n第三层: 60%获得1000-1500游园币，4个灵纹",
		"排行榜间隔5分钟刷新",
		"排行榜间隔5分钟刷新"
	}
}
local t_abyss_gold_rush_activity = {
	[612001] = dataList[1]
}

t_abyss_gold_rush_activity.dataList = dataList

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

return t_abyss_gold_rush_activity
