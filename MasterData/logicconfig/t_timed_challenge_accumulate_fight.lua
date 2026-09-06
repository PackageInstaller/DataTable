-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_accumulate_fight.lua

module("logicconfig.config.t_timed_challenge_accumulate_fight", package.seeall)

local title = {
	challengeId = 1,
	name = 2,
	progressFloorUnit = 8,
	vipDailyTimes = 4,
	maxProgerss = 7,
	petRankThreshold = 10,
	normalDailyTimes = 3,
	petRankPrize = 11,
	reGainBuffCost = 9,
	progressBase = 6,
	progressFactor = 5
}
local dataList = {
	{
		2,
		"潘多拉挑战",
		3,
		6,
		100,
		3000000,
		999999999,
		10000,
		"105:150:50",
		1000,
		"4:31:5"
	}
}
local t_timed_challenge_accumulate_fight = {
	[2] = dataList[1]
}

t_timed_challenge_accumulate_fight.dataList = dataList

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

return t_timed_challenge_accumulate_fight
