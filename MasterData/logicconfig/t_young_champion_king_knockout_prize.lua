-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_knockout_prize.lua

module("logicconfig.config.t_young_champion_king_knockout_prize", package.seeall)

local title = {
	knockoutPrizePlanId = 1,
	failurePrize = 3,
	winnerPrize = 2
}
local dataList = {
	{
		1,
		"8:1:2000",
		"8:1:1000"
	},
	{
		2,
		"8:1:2000",
		"8:1:1000"
	},
	{
		3,
		"8:1:2000",
		"8:1:1000"
	}
}
local t_young_champion_king_knockout_prize = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_young_champion_king_knockout_prize.dataList = dataList

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

return t_young_champion_king_knockout_prize
