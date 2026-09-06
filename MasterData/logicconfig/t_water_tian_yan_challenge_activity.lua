-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_tian_yan_challenge_activity.lua

module("logicconfig.config.t_water_tian_yan_challenge_activity", package.seeall)

local title = {
	challengeId = 5,
	buildingDailyChallengeTimes = 2,
	buildRule = 8,
	jumpTo1 = 9,
	jumpTo2 = 10,
	jumpTo3 = 11,
	clgRule = 7,
	buildingRefreshCost = 3,
	goldBarCon = 4,
	jumpTo4 = 12,
	activityId = 1,
	ruleTip = 6
}
local dataList = {
	{
		305001,
		5,
		"105:6070:50",
		"4:406",
		130,
		"watertianyanmainview_rule",
		"watertianyanclgmainview_rule",
		"watertianyanclgbuildview_rule",
		"func#959",
		"func#618#11017",
		"mibao#shuangjiekuanghuan5",
		""
	},
	{
		305002,
		5,
		"105:6070:50",
		"4:417",
		173,
		"miracledishitianmainview_rule",
		"miracledishitianclgmainview_rule",
		"miracledishitianclgbuildview_rule",
		"func#1089",
		"func#618#11024",
		"func#545#9",
		""
	},
	{
		305003,
		5,
		"105:6070:50",
		"4:510598",
		259,
		"divinemiukemainview_rule",
		"divinemiukeclgmainview_rule",
		"divinemiukeclgbuildview_rule",
		"func#618#15038",
		"mibao#shuangjiekuanghuan5",
		"ui#lottery",
		"func#545#1"
	}
}
local t_water_tian_yan_challenge_activity = {
	[305001] = dataList[1],
	[305002] = dataList[2],
	[305003] = dataList[3]
}

t_water_tian_yan_challenge_activity.dataList = dataList

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

return t_water_tian_yan_challenge_activity
