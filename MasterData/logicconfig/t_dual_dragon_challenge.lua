-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_dragon_challenge.lua

module("logicconfig.config.t_dual_dragon_challenge", package.seeall)

local title = {
	universalPrice = 4,
	universalDailyLimit = 2,
	jump_act_shop = 10,
	jump_lotery = 8,
	extremeReward = 6,
	raceId = 11,
	pos = 13,
	desc = 12,
	activityId = 1,
	redPointId = 14,
	universalBuyLimit = 3,
	ruleKeyUniversal = 16,
	universalReward = 5,
	ruleKeyExtreme = 17,
	jump_shop = 9,
	jump_rank = 7,
	ruleKeyMain = 15
}
local dataList = {
	{
		258001,
		5,
		3,
		"105:6059:50",
		"4:179:100",
		"100:16016:1:1",
		"func#618#16016",
		"func#43#96",
		"func#191#258#258001",
		"mibao#zhouniantehui3",
		16016,
		"将神判之关，裁决之关同时击败，即可获得精灵！",
		{
			0,
			0,
			1
		},
		466,
		"dualdragonchallengemainview",
		"dualdragonchallengewholeview",
		"dualdragonchallengelimitview"
	},
	{
		258002,
		5,
		3,
		"105:6059:50",
		"8:1:100",
		"8:1:100",
		"func#618#16016",
		"func#43#96",
		"func#191#258#258001",
		"mibao#zhouniantehui3",
		16016,
		"将神判之关，裁决之关同时击败，即可获得精灵！",
		{
			0,
			0,
			1
		},
		719,
		"dualdragonchallengemainview_2",
		"dualdragonchallengewholeview",
		"dualdragonchallengelimitview_2"
	}
}
local t_dual_dragon_challenge = {
	[258001] = dataList[1],
	[258002] = dataList[2]
}

t_dual_dragon_challenge.dataList = dataList

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

return t_dual_dragon_challenge
