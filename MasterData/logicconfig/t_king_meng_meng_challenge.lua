-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge.lua

module("logicconfig.config.t_king_meng_meng_challenge", package.seeall)

local title = {
	lockPetSign = 7,
	bubblePrize1 = 12,
	bossMasterId = 6,
	bubblePrize2 = 13,
	mainRuleKey = 14,
	gotoSummon = 10,
	gotoRank = 9,
	gotoCultivate = 11,
	redPointId = 8,
	bossPrize = 5,
	raceId = 3,
	dailyChallengeTimes = 2,
	activityId = 1,
	extScore = 4
}
local dataList = {
	{
		278001,
		3,
		11010,
		300,
		"100:11010:1:1",
		401,
		"英雄",
		490,
		"func#618#11010",
		"func#43#112",
		"mibao#mengzhiduiguilai4",
		"4:194:20",
		"100:11010:1:1",
		"kingmmmainview_rule"
	},
	{
		278002,
		3,
		11010,
		300,
		"8:1:1",
		401,
		"英雄",
		644,
		"func#618#11010",
		"func#43#112",
		"mibao#mengzhiduiguilai4",
		"8:1:1",
		"8:1:1",
		"kingmmmainview_rule01"
	}
}
local t_king_meng_meng_challenge = {
	[278001] = dataList[1],
	[278002] = dataList[2]
}

t_king_meng_meng_challenge.dataList = dataList

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

return t_king_meng_meng_challenge
