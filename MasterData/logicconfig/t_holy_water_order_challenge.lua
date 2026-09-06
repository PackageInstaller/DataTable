-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_water_order_challenge.lua

module("logicconfig.config.t_holy_water_order_challenge", package.seeall)

local title = {
	jumpCultivate = 10,
	mailTpId = 4,
	selectPetNum = 3,
	jumpShenYaoMat = 9,
	raceId = 5,
	closeRange = 7,
	showRaceId = 12,
	extraStar = 6,
	dailyRankPrize = 2,
	jumpShenYao = 8,
	jumpRank = 11,
	activityId = 1
}
local dataList = {
	{
		292001,
		"4:510203:100",
		20,
		213,
		11002,
		1,
		"02:00:00-09:00:00",
		"func#375",
		"mibao#shenyaolibao",
		"mibao#nihaituntian1",
		"func#618#11011",
		11011
	}
}
local t_holy_water_order_challenge = {
	[292001] = dataList[1]
}

t_holy_water_order_challenge.dataList = dataList

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

return t_holy_water_order_challenge
