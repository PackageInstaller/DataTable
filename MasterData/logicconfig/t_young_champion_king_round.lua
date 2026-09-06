-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_round.lua

module("logicconfig.config.t_young_champion_king_round", package.seeall)

local title = {
	roundType = 3,
	gussPlanId = 6,
	roundId = 2,
	roundName = 4,
	activityId = 1,
	guessLimit = 5
}
local dataList = {
	{
		391001,
		1,
		"QUALIFY",
		"战区预选赛",
		0,
		0
	},
	{
		391001,
		2,
		"SCORE_MATCH",
		"战区积分赛",
		0,
		0
	},
	{
		391001,
		3,
		"COMMON_KNOCKOUT",
		"全服赛128进64",
		10000,
		1
	},
	{
		391001,
		4,
		"COMMON_KNOCKOUT",
		"全服赛64进32",
		10000,
		1
	},
	{
		391001,
		5,
		"COMMON_KNOCKOUT",
		"全服赛32进16",
		10000,
		1
	},
	{
		391001,
		6,
		"COMMON_KNOCKOUT",
		"全服赛16进8",
		10000,
		1
	},
	{
		391001,
		7,
		"COMMON_KNOCKOUT",
		"全服赛8进4",
		10000,
		1
	},
	{
		391001,
		8,
		"COMMON_KNOCKOUT",
		"全服赛4进2",
		10000,
		1
	},
	{
		391001,
		9,
		"THIRD_PLACE_MATCH",
		"全服季军赛",
		10000,
		1
	},
	{
		391001,
		10,
		"FINAL_MATCH",
		"全服冠军赛",
		10000,
		1
	},
	{
		391001,
		11,
		"DISPLAY",
		"前4展示",
		0,
		0
	}
}
local t_young_champion_king_round = {
	[391001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_young_champion_king_round.dataList = dataList

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

return t_young_champion_king_round
