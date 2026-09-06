-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_qualifier_match.lua

module("logicconfig.config.t_young_champion_king_qualifier_match", package.seeall)

local title = {
	quaMatchingId = 2,
	winPrize = 3,
	quaMatchingPlanId = 1,
	failPrize = 4
}
local dataList = {
	{
		1,
		1,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		2,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		3,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		4,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		5,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		6,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		7,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		8,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		9,
		"10:391001:100",
		"10:391001:50"
	},
	{
		1,
		10,
		"10:391001:100",
		"10:391001:50"
	}
}
local t_young_champion_king_qualifier_match = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_young_champion_king_qualifier_match.dataList = dataList

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

return t_young_champion_king_qualifier_match
