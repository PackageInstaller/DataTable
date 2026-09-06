-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king.lua

module("logicconfig.config.t_young_champion_king", package.seeall)

local title = {
	dailyGuessCoin = 4,
	reportLimit = 5,
	redPointId = 8,
	shopGotoStr = 7,
	ruleKey = 6,
	exchangeItem = 3,
	activityId = 1,
	guessItem = 2
}
local dataList = {
	{
		391001,
		"10:391002",
		"10:391001",
		500,
		10,
		"young_champion_king_rule",
		"func#191#391#391001",
		597
	}
}
local t_young_champion_king = {
	[391001] = dataList[1]
}

t_young_champion_king.dataList = dataList

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

return t_young_champion_king
